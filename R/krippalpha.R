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


#' Krippendorff's alpha
#'
#' \code{krippalpha} computes Krippendorff's reliability coefficient alpha.
#'
#' @param data a matrix or data frame (coercible to a matrix) of reliability data. Data of type \code{character} are converted to \code{numeric} via \code{as.factor()}.
#' @param metric metric difference function to be applied to disagreements. Supports \code{nominal}, \code{ordinal}, \code{interval}, \code{ratio}, \code{bipolar}. Defaults to \code{nominal}.
#' @param bootstrap logical indicating whether uncertainty estimates should be obtained using the bootstrap algorithm defined by Krippendorff. Defaults to \code{FALSE}.
#' @param bootnp logical indicating whether non-parametric bootstrap uncertainty estimates should be computed. Defaults to \code{FALSE}.
#' @param nboot number of bootstraps used in Krippendorff's algorithm. Defaults to \code{20000}.
#' @param nnp number of non-parametric bootstraps. Defaults to \code{1000}.
#' @param cores number of cores across which bootstrap-computations are distributed. Defaults to 1. If more cores are specified than available, the number will be set to the maximum number of available cores.
#' @param seed numeric vector of length 6 for the internal L'Ecuyer-CMRG random number generator (see details). Defaults to \code{c(12345, 12345, 12345, 12345, 12345, 12345)}.
#'
#' @details
#' \code{krippalpha} takes the seed vector to seed the internal random number generator of both bootstrap-routines. It does not advance R's RNG state.
#'
#' When using the \code{ratio} metric with reliability data containing scales involving negative as well as positive values, \code{krippalpha} may return a value of \code{NaN}. The \code{ratio} metric difference function is defined as \eqn{\Big(\frac{(c - k)}{(c + k)}\Big)^2}{((c - k)/(c + k))^2}. Hence, if for any two scale values \eqn{c = -k}{c = -k}, the fraction is not defined, resulting in \eqn{\alpha =}{alpha =} \code{NaN}. In order to avoid this issue, shift your reliability data to have strictly positive values.
#'
#' @return Returns a list of type \code{icr} with following elements:
#' \item{alpha}{value of inter-coder reliability coefficient}
#' \item{metric}{integer representation of metric used to compute alpha: 1 nominal, 2 ordinal, 3 interval, 4 ratio, 6 bipolar}
#' \item{n_coders}{number of coders}
#' \item{n_units}{number of units to be coded}
#' \item{n_values}{number of unique values in reliability data}
#' \item{coincidence_matrix}{matrix containing coincidences within coder-value pairs}
#' \item{delta_matrix}{matrix of metric differences depending on \code{method}}
#' \item{D_e}{expected disagreement}
#' \item{D_o}{observed disagreement}
#' \item{bootstrap}{\code{TRUE} if Krippendorff bootstrapping algorithm was run, \code{FALSE} otherwise}
#' \item{nboot}{number of bootstraps}
#' \item{bootnp}{\code{TRUE} if nonparametric bootstrap was run, \code{FALSE} otherwise}
#' \item{nnp}{number of non-parametric bootstraps}
#' \item{bootstraps}{vector of bootstrapped values of alpha (Krippendorff's algorithm)}
#' \item{bootstrapsNP}{vector of non-parametrically bootstrapped values of alpha}
#'
#' @note \code{krippalpha}'s bootstrap-routines use L'Ecuyer's CMRG random number generator (see L'Ecyuer et al. 2002) to create random numbers suitable for parallel computations. The routines interface to L'Ecuyer's C++ code, which can be found at \url{https://www.iro.umontreal.ca/~lecuyer/myftp/streams00/c++/}
#'
#' @references
#' Krippendorff, K. (2004) \emph{Content Analysis: An Introduction to Its Methodology}. Beverly Hills: Sage.
#'
#' Krippendorff, K. (2011) \emph{Computing Krippendorff's Alpha Reliability}. Departmental Papers (ASC) 43. \url{https://web.archive.org/web/20220713195923/https://repository.upenn.edu/asc_papers/43/}.
#'
#' Krippendorff, K. (2016) \emph{Bootstrapping Distributions for Krippendorff's Alpha}. \url{https://www.asc.upenn.edu/sites/default/files/2021-03/Algorithm%20for%20Bootstrapping%20a%20Distribution%20of%20Alpha.pdf}.
#'
#' L'Ecuyer, P. (1999) Good Parameter Sets for Combined Multiple Recursive Random Number Generators. \emph{Operations Research}, 47 (1), 159--164. \url{https://www.iro.umontreal.ca/~lecuyer/myftp/streams00/opres-combmrg2-1999.pdf}.
#'
#' L'Ecuyer, P., Simard, R, Chen, E. J., and Kelton, W. D. (2002) An Objected-Oriented Random-Number Package with Many Long Streams and Substreams. \emph{Operations Research}, 50 (6), 1073--1075. \url{https://www.iro.umontreal.ca/~lecuyer/myftp/streams00/c++/streams4.pdf}.
#'
#' @examples
#' data(codings)
#'
#' # compute alpha, without uncertainty estimates
#' krippalpha(codings)
#'
#' # additionally compute bootstrapped uncertainty estimates for alpha
#' alpha <- krippalpha(codings, metric = "nominal", bootstrap = TRUE, bootnp = TRUE)
#' alpha
#'
#' # plot bootstrapped alphas
#' plot(alpha)
#'
#' # alternatively, use ggplot2
#' df <- plot(alpha, return_data = TRUE)
#'
#' library(ggplot2)
#' ggplot() +
#'   geom_line(data = df[df$ci_limit == FALSE, ], aes(x, y, color = type)) +
#'   geom_area(data = df[df$ci == TRUE, ], aes(x, y, fill = type), alpha = 0.4) +
#'   theme_minimal() +
#'   theme(plot.title = element_text(hjust = 0.5)) +
#'   theme(legend.position = "bottom", legend.title = element_blank()) +
#'   ggtitle(expression(paste("Bootstrapped ", alpha))) +
#'   xlab("value") + ylab("density") +
#'   guides(fill = FALSE)
#'
#' @useDynLib icr, .registration = TRUE
#' @importFrom Rcpp evalCpp
#' @export
krippalpha <- function(data, metric = "nominal",
                       bootstrap = FALSE, bootnp = FALSE,
                       nboot = 20000, nnp = 1000,
                       cores = 1, seed = rep(12345, 6)) {

    # check (and possibly convert) input data
    mat <- if (is.data.frame(data)) {
        if (any(lapply(data, function(x) !is.numeric(x)))) {
            data.matrix(trimws(as.matrix(data)))
        } else {
            data.matrix(as.matrix(data))
        }
    } else if (is.matrix(data)) {
        data.matrix(data)
    } else {
        stop("'data' must be a matrix or data frame")
    }

    # convert data to numeric type (double)
    data_matrix <- if (is.numeric(mat)) {
        mat * 1.0
    } else {
        matrix(as.integer(as.factor(mat)),
               nrow = nrow(mat),
               byrow = FALSE) * 1.0
    }

    # get metric
    int_metric <- switch(metric,
                         nominal = 1,
                         ordinal = 2,
                         interval = 3,
                         ratio = 4,
                         bipolar = 6)
    if (is.null(int_metric)) {
        stop("Provided metric does not exist.\n")
    }

    # get seed
    if (length(seed) == 6) {
        if (all(seed[1:3] == 0) | all(seed[4:6] == 0)) {
            stop("First three and last three seed values must not be all zero.\n")
        }
    } else {
        stop("L'Ecuyer-CMRG seed requires an integer vector of length 6.\n")
    }

    # compute alpha
    result <- alpha_k_cpp(data_matrix, int_metric,
                          bootstrap, bootnp,
                          nboot, nnp,
                          seed, cores)
    class(result) <- "icr"
    return(result)
}
