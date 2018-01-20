# Copyright (C) 2017  Alexander Staudt
#
# This file is part of icr.
#
# icr is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# icr is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with icr; if not, see <https://www.gnu.org/licenses/>.


#' @import ggplot2
#' @importFrom stats quantile aggregate
#' @importFrom reshape2 melt
#' @export
plot.icr <- function(x, ..., level = 0.95) {
    if (x$bootstrap == FALSE & x$bootnp == FALSE) {
        stop("No bootstrapped values of alpha available")
    }

    n_alphas_k  <- length(x$bootstraps)
    n_alphas_np <- length(x$bootstrapsNP)

    df <- data.frame(krippendorff = x$bootstraps, nonparametric = x$bootstrapsNP)
    if (n_alphas_k > n_alphas_np) {
        df$nonparametric[(n_alphas_np + 1):n_alphas_k] <- NA
    } else if (n_alphas_k < n_alphas_np) {
        df$krippendorff[(n_alphas_k + 1):n_alphas_np] <- NA
    }

    plot_data <- cbind(df, id = 1:nrow(df))
    plot_data <- melt(plot_data, id = "id", variable.name = "technique")
    plot_data <- plot_data[!is.na(plot_data$value), ]
    plot_data <- plot_data[!is.nan(plot_data$value), ]
    plot_data$technique <- droplevels(plot_data$technique)

    quantiles <- ggplot_build(ggplot(plot_data,
                                     aes_(x = ~value, color = ~technique, fill = ~technique)))$data[[1]]
    quantiles <- aggregate(x = quantiles$x,
                           by = list(group = quantiles$group),
                           quantile, c((1 - level)/2, 1 - (1 - level)/2), simplify = FALSE)
    quantiles <- data.frame(group = quantiles$group,
                            lq = c(quantiles$x$`1`[1], quantiles$x$`2`[1]),
                            uq = c(quantiles$x$`1`[2], quantiles$x$`2`[2]))

    dens_data <- ggplot_build(ggplot(plot_data,
                                     aes_(x = ~value, color = ~technique, fill = ~technique)) +
                                  geom_density(alpha = 0.6))$data[[1]]
    dens_data <- merge(dens_data, quantiles, by = "group")

    if (x$bootstrap == TRUE & x$bootnp == TRUE) {
        ci_lq <- data.frame(group = c(1,2), x = quantiles$lq, y = c(0, 0))
        ci_uq <- data.frame(group = c(1,2), x = quantiles$uq, y = c(0, 0))
    } else if ((x$bootstrap == TRUE & x$bootnp == FALSE) |
               (x$bootstrap == FALSE & x$bootnp == TRUE)) {
        ci_lq <- data.frame(group = 1, x = quantiles$lq, y = 0)
        ci_uq <- data.frame(group = 1, x = quantiles$uq, y = 0)
    }

    ci_data <- dens_data[dens_data$x >= dens_data$lq & dens_data$x <= dens_data$uq, ]
    ci_data <- ci_data[, c("group", "x", "y")]
    ci_data <- rbind(ci_lq, ci_data, ci_uq)
    if (nlevels(plot_data$technique) == 2) {
        ci_data$technique <- ifelse(ci_data$group == 1, "krippendorff", "nonparametric")
    } else {
        ci_data$technique <- levels(plot_data$technique)
    }

    density_plot <- ggplot() +
        geom_density(data = plot_data, aes_(x = ~value, color = ~technique, fill = ~technique), alpha = 0.1) +
        geom_polygon(data = ci_data, aes_(x = ~x, y = ~y, fill = ~technique), alpha = 0.5)

    if (nlevels(plot_data$technique) == 2) {
        alpha_density <- density_plot +
            theme(legend.position = "bottom") +
            guides(fill = guide_legend(title = NULL)) +
            guides(color = guide_legend(title = NULL)) +
            ggtitle("Densities of bootstrapped alphas")
    } else {
        alpha_density <- density_plot +
            theme(legend.position = "none") +
            ggtitle("Density of bootstrapped alphas")
    }
    return(alpha_density)
}
