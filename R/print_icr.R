#' @importFrom stats quantile sd
#' @export
print.icr <- function(x, ..., level = 0.95) {
    if (level > 1 || level < 0) {
        stop("level must lie within interval [0,1]")
    }

    # create summary from icr-object
    sig <- 1 - level

    # coders, units, metric
    h <- data.frame(Alpha = x$alpha,
                    coders = x$n_coders,
                    units = x$n_units,
                    level = x$method)
    f_h <- format(h, digits = 3, justify = "right")

    # alpha, quantiles, standard errors
    alpha <- x$alpha

    if (x$bootstrap == TRUE) {
        ci_1 <- quantile(x$bootstraps, c(sig/2, 1 - sig/2), na.rm = TRUE)
        sd_1 <- sd(x$bootstraps, na.rm = TRUE)
        nboot <- x$nboot
        b_alpha <- mean(x$bootstraps, na.rm = TRUE)
        if (is.nan(b_alpha)) {
            b_alpha <- NA
        }
    } else {
        ci_1 <- c(NA, NA)
        sd_1 <- NA
        nboot <- NA
        b_alpha <- NA
    }
    if (x$bootnp == TRUE) {
        ci_2 <- quantile(x$bootstrapsNP, c(sig/2, 1 - sig/2), na.rm = TRUE)
        sd_2 <- sd(x$bootstrapsNP, na.rm = TRUE)
        nnp <- x$nnp
        b_alphaNP <- mean(x$bootstrapsNP, na.rm = TRUE)
        if (is.nan(b_alphaNP)) {
            b_alphaNP <- NA
        }
    } else {
        ci_2 <- c(NA, NA)
        sd_2 <- NA
        nnp <- NA
        b_alphaNP <- NA
    }

    ll <- format(sig/2 * 100, scientific = FALSE)
    ul <- format((1 - sig/2) * 100, scientific = FALSE)

    results <- data.frame(matrix(NA, nrow = 2, ncol = 6), check.names = FALSE)
    results[, 1] <- c(b_alpha, b_alphaNP)
    results[, 2] <- c(sd_1, sd_2)
    results[, 3] <- c(ci_1[1], ci_2[1])
    results[, 4] <- c(ci_1[2], ci_2[2])
    results[, 5] = c("Krippendorff", "nonparametric")
    results[, 6] <- c(nboot, nnp)
    colnames(results) <- c("Alpha",
                           "Std. Error",
                           paste0(ll, " %"),
                           paste0(ul, " %"),
                           "Boot. technique",
                           "Bootstraps")
    f_results <- format(results, digits = 3, justify = "right")

    # alpha_min
    alpha_min <- data.frame(alpha_min = c(0.9, 0.8, 0.7, 0.67, 0.6, 0.5), krippendorff = NA, nonparametric = NA)
    if (length(x$bootstraps) > 1) {
        for (i in 1:6) {
            alpha_min[i, 2] <- sum(x$bootstraps > alpha_min[i, 1])/x$nboot
        }
    } else {
        alpha_min[, 2] <- NA
    }
    if (length(x$bootstrapsNP) > 1) {
        for (i in 1:6) {
            alpha_min[i, 3] <- sum(x$bootstrapsNP > alpha_min[i, 1])/x$nnp
        }
    } else {
        alpha_min[, 3] <- NA
    }

    f_alpha_min <- format(alpha_min, digits = 3, justify = "right")

    # print results
    cat("\n", " Krippendorff's alpha ", "\n\n", sep = "")
    print(f_h, row.names = FALSE)

    cat("\n")
    cat(" Bootstrapped alpha", "\n", sep = "")
    print(f_results, row.names = FALSE)

    cat("\n")
    cat(" P(alpha > alpha_min):\n")
    print(f_alpha_min, row.names = FALSE)
}
