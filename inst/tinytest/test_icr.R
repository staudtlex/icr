## Wikipedia example
## https://en.wikipedia.org/wiki/Krippendorff%27s_alpha#A_computational_example

wiki <- matrix(c(NA, 1, NA, NA, NA, NA, NA, 2, 2, NA, 1, 1, NA, 3, 3, 3, 3, 4, 4, 4, 4, 1, 3, NA, 2, NA, 2, 1, NA, 1, 1, NA, 1, 3, NA, 3, 3, NA, 3, NA, NA, NA, 3, NA, 4), nrow = 3)

expect_equal(icr::krippalpha(wiki)$alpha,
             0.691,
             tolerance = 0.001)

expect_equal(icr::krippalpha(wiki, metric = "interval")$alpha,
             0.811,
             tolerance = 0.001)

## Example in Krippendorff (2018), p. 290
## 1 = book, 2 = letter, 3 = telephone, 4 = computer, 5 = folder

example1 <- matrix(c(1, 1, NA, 1, 2, 2, 3, 2, 3, 3, 3, 3, 3, 3, 3, 3,
                    2,2,2,2,1,2,3,4,4,4,4,4,1, 1, 2, 1, 2, 2, 2, 2, NA,5,5,5,NA,NA,1,1,NA,NA,3,NA), nrow = 4)

expect_equal(icr::krippalpha(example1)$alpha, 0.743, tolerance = 0.001)
expect_equal(icr::krippalpha(example1, metric = "ordinal")$alpha, 0.815, tolerance = 0.001)
expect_equal(icr::krippalpha(example1, metric = "interval")$alpha, 0.849, tolerance = 0.001)

expect_equal(icr::krippalpha(example1, metric = "ratio")$alpha, 0.797, tolerance = 0.001)

## Example in Krippendorff (2018), p. 306

example2 <- matrix(c(0,0,0,1,1,1,0,0,1,1,1,0,1,0,0,0,0,1,0,0,0,0,0,0,1,1,1,
                     1,1,0,1,0,0,1,1,0), nrow = 3)

expect_equal(icr::krippalpha(example2)$alpha, 0.2343, tolerance = 0.001)

## Example in Krippendorff (2018), p. 310

example3 <- matrix(c("a", "a", "a", "c",
                     "c", "c", "c", "c",
                     "c", "c", "c", "c",
                     "c", "b", "b", "b",
                     "b", "b", "b", "b",
                     "b", "b", "d", "d"),
                   nrow = 2)

## in the book, he actually said 0.760, likely due to rounding
expect_equal(icr::krippalpha(example3)$alpha, 0.759, tolerance = 0.001)

## example in Hayes & Krippendorff (2007) https://doi.org/10.1080/19312450709336664

hayes <- matrix(
    c(1,1,2,NA,2,
      1,1,0,1,NA,
      2,3,3,3,NA,
      NA,0,0,NA,0,
      0,0,0,NA,0,

      0,0,0,NA,0,           
      1,0,2,NA,1,
      1,NA,2,0,NA,
      2,2,2,NA,2,
      2,1,1,1,NA,

      NA,1,0,0,NA,
      0,0,0,0,NA,
      1,2,2,2,NA,
      3,3,2,2,3,
      1,1,1,NA,1,

      1,1,1,NA,1,
      2,1,2,NA,2,
      1,2,3,3,NA,
      1,1,0,1,NA,
      0,0,0,NA,0,

      0,0,1,1,NA,
      0,0,NA,0,0,
      2,3,3,3,NA,
      0,0,0,0,NA,
      1,2,NA,2,2,

      0,1,1,1,NA,
      0,0,0,1,0,
      1,2,1,2,NA,
      1,1,2,2,NA,
      1,1,2,NA,2,

      1,1,0,NA,0,
      2,1,2,1,NA,
      2,2,NA,2,2,
      3,2,2,2,NA,
      2,2,2,NA,2,

      2,2,3,NA,2,
      2,2,2,NA,2,
      2,2,NA,1,2,
      2,2,2,2,NA,
      1,1,1,NA,1),
    ncol = 5, byrow = TRUE)

expect_equal(icr::krippalpha(t(hayes), metric = "ordinal")$alpha,
             0.7598, tolerance = 0.001)

expect_equal(icr::krippalpha(t(hayes), metric = "nominal")$alpha,
             0.4765, tolerance = 0.001)

## examples in Freelon
## https://dfreelon.org/publications/2010_ReCal_Intercoder_reliability_calculation_as_a_web_service.pdf

## csvfiles <- list.files("inst/tinytest/", pattern = "csv")
## freelon_matrices <- lapply(csvfiles, function(x) t(as.matrix(read.csv(file.path("inst/tinytest", x), header = FALSE))))
## dput(freelon_matrices)

freelon_matrices <- list(structure(c(1L, 1L, 1L, 1L, 2L, 2L, 1L, 1L, 1L, 1L, 1L, 
1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L), dim = c(2L, 10L), dimnames = list(
    c("V1", "V2"), NULL)), structure(c(1L, 1L, 0L, 1L, 0L, 0L, 
0L, 0L, 0L, 0L, 0L, 1L, 0L, 1L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
0L, 0L, 0L, 1L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 1L, 0L, 
0L, 1L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L), dim = c(2L, 
50L), dimnames = list(c("V1", "V2"), NULL)), structure(c(2L, 
1L, 2L, 2L, 2L, 2L, 4L, 4L, 1L, 1L, 1L, 1L, 1L, 1L, 4L, 4L, 4L, 
4L, 1L, 1L, 2L, 3L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 
1L, 1L, 1L, 1L, 1L, 2L, 2L, 1L, 1L, 1L, 1L, 1L, 1L, 4L, 4L, 1L, 
1L, 4L, 4L, 1L, 1L, 1L, 1L, 3L, 1L, 4L, 4L, 1L, 1L, 1L, 1L, 4L, 
4L, 4L, 4L, 1L, 1L, 4L, 4L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 
1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 2L, 1L, 4L, 4L, 1L, 
1L, 1L, 1L), dim = c(2L, 50L), dimnames = list(c("V1", "V2"), 
    NULL)), structure(c(0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 1L, 1L, 
0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 1L, 1L, 1L, 0L, 0L, 
1L, 1L, 1L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 1L, 1L, 1L, 1L, 
0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
0L, 0L, 1L, 1L, 0L, 0L, 0L, 0L, 1L, 1L, 0L, 0L, 1L, 1L, 1L, 0L, 
0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L), dim = c(2L, 50L), dimnames = list(
    c("V1", "V2"), NULL)), structure(c(0L, 0L, 0L, 0L, 0L, 0L, 
0L, 0L, 1L, 1L, 0L, 0L, 0L, 0L, 0L, 0L, 1L, 1L, 1L, 1L, 0L, 0L, 
1L, 1L, 0L, 0L, 0L, 0L, 1L, 1L, 1L, 1L, 0L, 0L, 0L, 0L, 1L, 1L, 
0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 1L, 1L, 0L, 0L, 
0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 1L, 1L, 
0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 1L, 1L, 0L, 0L, 1L, 1L, 0L, 0L, 
0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 1L, 1L, 0L, 0L, 0L, 0L), dim = c(2L, 
50L), dimnames = list(c("V1", "V2"), NULL)), structure(c(1L, 
1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 0L, 0L, 0L, 0L, 0L, 
1L, 1L, 1L, 0L, 0L, 0L, 0L, 0L, 0L, 1L, 1L, 0L, 0L, 0L, 0L, 1L, 
1L, 0L, 0L, 0L, 0L, 0L, 0L), dim = c(2L, 20L), dimnames = list(
    c("V1", "V2"), NULL)), structure(c(0L, 0L, 0L, 0L, 0L, 0L, 
0L, 0L, 4L, 4L, 1L, 1L, 1L, 1L, 1L, 1L, 7L, 5L, 0L, 0L, 0L, 0L, 
0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
0L, 0L, 1L, 1L, 1L, 1L), dim = c(2L, 30L), dimnames = list(c("V1", 
"V2"), NULL)), structure(c(0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 1L, 
1L, 2L, 3L, 2L, 2L, 0L, 0L, 2L, 2L, 2L, 2L, 0L, 0L, 0L, 0L, 0L, 
0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 1L, 0L, 0L, 0L, 
0L, 0L, 0L, 0L, 0L, 1L, 1L, 0L, 0L, 0L, 0L, 2L, 3L, 1L, 1L, 1L, 
1L, 0L, 0L, 0L, 0L, 1L, 1L, 2L, 2L, 1L, 2L, 2L, 2L, 1L, 2L, 1L, 
2L, 3L, 3L, 3L, 3L, 3L, 3L, 1L, 1L, 0L, 0L), dim = c(2L, 50L), dimnames = list(
    c("V1", "V2"), NULL)), structure(c(1L, 1L, 1L, 1L, 1L, 1L, 
1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 
1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 2L, 2L, 1L, 1L, 1L, 1L, 
1L, 1L), dim = c(2L, 20L), dimnames = list(c("V1", "V2"), NULL)), 
    structure(c(1L, 1L, 0L, 0L, 0L, 0L, 0L, 0L, 1L, 1L, 1L, 1L, 
    1L, 1L, 1L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
    0L, 0L, 0L, 0L, 0L, 1L, 1L, 0L, 0L, 1L, 1L, 0L, 0L), dim = c(2L, 
    20L), dimnames = list(c("V1", "V2"), NULL)), structure(c(1L, 
    0L, 0L, 0L, 0L, 1L, 1L, 1L, 1L, 1L, 0L, 1L, 1L, 0L, 0L, 0L, 
    0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
    0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
    0L, 0L, 0L, 0L), dim = c(5L, 10L), dimnames = list(c("V1", 
    "V2", "V3", "V4", "V5"), NULL)), structure(c(1L, 1L, 1L, 
    1L, 1L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
    0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
    0L, 0L, 0L, 0L, 0L, 0L, 1L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
    0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
    0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
    0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
    0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
    0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 1L, 0L, 1L, 0L, 0L, 0L, 
    1L, 1L, 0L, 0L, 1L, 0L, 0L, 1L, 0L, 0L, 1L, 0L, 1L, 1L, 0L, 
    0L, 0L, 0L, 0L, 0L, 0L, 1L, 0L, 0L, 0L, 1L, 0L), dim = c(3L, 
    50L), dimnames = list(c("V1", "V2", "V3"), NULL)), structure(c(0L, 
    0L, 0L, 1L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
    0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
    0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
    0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
    0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
    0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L), dim = c(3L, 28L), dimnames = list(
        c("V1", "V2", "V3"), NULL)), structure(c(3L, 4L, 4L, 
    4L, 5L, 5L, 3L, 3L, 5L, 4L, 5L, 5L, 3L, 5L, 5L), dim = c(3L, 
    5L), dimnames = list(c("V1", "V2", "V3"), NULL)), structure(c(1L, 
    1L, 1L, 2L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 
    1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 3L, 1L, 2L, 2L, 2L, 2L, 
    2L, 1L, 2L, 2L, 2L, 2L, 2L, 2L, 3L, 3L, 3L, 2L, 2L, 2L, 2L, 
    2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 1L, 2L, 2L, 1L, 
    1L, 1L, 1L, 1L, 1L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 1L, 
    1L, 1L, 1L, 1L, 1L, 2L, 2L, 2L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 
    1L, 3L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 2L, 
    2L, 2L, 2L, 2L, 2L, 3L, 3L, 3L, 3L, 3L, 3L), dim = c(3L, 
    39L), dimnames = list(c("V1", "V2", "V3"), NULL)), structure(c(1L, 
    0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 1L, 1L, 0L, 1L, 1L, 1L, 1L, 
    0L, 0L, 0L, 0L, 0L, 1L, 1L, 1L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
    0L, 0L, 1L, 1L, 1L, 0L, 0L, 0L, 1L, 1L, 1L, 0L, 0L, 0L, 1L, 
    1L, 1L, 0L, 0L, 0L, 1L, 0L, 0L, 1L, 1L, 1L, 0L, 0L, 0L), dim = c(3L, 
    20L), dimnames = list(c("V1", "V2", "V3"), NULL)), structure(c(999L, 
    999L, 999L, 999L, 999L, 999L, 999L, 999L, 999L, 2L, 3L, 2L, 
    2L, 3L, 2L, 2L, 3L, 2L, 2L, 3L, 2L, 2L, 3L, 99L, 999L, 99L, 
    999L, 999L, 999L, 999L, 999L, 999L, 999L, 999L, 999L, 999L, 
    999L, 999L, 999L, 999L, 999L, 999L, 999L, 999L, 999L, 999L, 
    999L, 999L, 999L, 999L, 999L, 999L, 999L, 999L, 1L, 1L, 1L, 
    1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 
    1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 999L, 999L, 
    999L, 1L, 1L, 1L, 1L, 1L, 1L, 3L, 3L, 3L, 999L, 999L, 999L, 
    999L, 999L, 999L, 3L, 3L, 2L, 3L, 3L, 2L, 3L, 3L, 2L, 3L, 
    3L, 2L, 3L, 3L, 2L, 1L, 1L, 2L, 1L, 1L, 1L, 1L, 1L, 2L, 3L, 
    1L, 1L, 3L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 
    1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L), dim = c(3L, 50L), dimnames = list(
        c("V1", "V2", "V3"), NULL)), structure(c(0L, 0L, 0L, 
    0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
    0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
    0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
    0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
    0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
    0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
    0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 1L, 1L, 1L, 
    0L, 0L, 0L, 0L, 0L, 0L, 1L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
    0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
    0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L), dim = c(3L, 
    50L), dimnames = list(c("V1", "V2", "V3"), NULL)), structure(c(0L, 
    0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
    0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
    0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
    0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
    0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
    0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
    0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
    0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
    0L, 0L, 0L, 23L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 15L, 0L, 
    0L, 0L, 0L, 0L, 18L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
    0L), dim = c(3L, 50L), dimnames = list(c("V1", "V2", "V3"
    ), NULL)), structure(c(1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 
    0L, 0L, 0L, 10L, 10L, 10L, 10L, 10L, 10L, 2L, 2L, 2L, 5L, 
    5L, 5L, 4L, 4L, 4L, 1L, 1L, 1L, 0L, 0L, 0L, 0L, 0L, 0L, 3L, 
    3L, 2L, 0L, 0L, 0L, 2L, 1L, 1L, 1L, 1L, 1L, 0L, 0L, 1L, 0L, 
    0L, 0L, 2L, 3L, 1L, 1L, 0L, 0L, 0L, 0L, 2L, 2L, 2L, 1L, 3L, 
    3L, 3L, 2L, 2L, 2L, 1L, 1L, 1L), dim = c(3L, 25L), dimnames = list(
        c("V1", "V2", "V3"), NULL)))

## Using the reference values from Hayes, not Freelon (Table 9, 10)
## because of numeric precision
freelon_alphas <- c(1, 0.1929, 0.8334, 0.8070, 1, 0.9023,0.9144, 0.7928,1,0.8889,
                    0.6354, 0.3410,0, 0.0278, 0.8628, 0.7227, 0.7002, 0.7449, -0.0068, 0.7462)

observed_alphas <- vapply(freelon_matrices, function(x) icr::krippalpha(x)$alpha, numeric(1))

expect_equal(observed_alphas, freelon_alphas, tolerance = 0.001)

## oolong example https://github.com/gesistsa/oolong/issues/96

mat <- structure(c(2, 1, 1, 2, 2, 1, 2, 2, 1, 2, 2, 1, 2, 2, 2, 2, 2,
2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2), dim = c(3L, 10L), dimnames = list(
                                                              c("R1", "R2", "R3"), NULL))

hand_calculation <- 1 - (4 / ((5 * 25) / 29))
expect_equal(icr::krippalpha(mat)$alpha, hand_calculation, tolerance = 0.001)
