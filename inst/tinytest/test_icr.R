## ---- Wikipedia example ----
# See https://en.wikipedia.org/wiki/Krippendorff%27s_alpha#A_computational_example
wiki <- as.matrix(read.csv(file = "data/wikipedia.csv"))

expect_equal(
    current = krippalpha(data = wiki)$alpha,
    target = 0.691,
    tolerance = 0.001
)
expect_equal(
    current = krippalpha(data = wiki, metric = "interval")$alpha,
    target = 0.811,
    tolerance = 0.001
)

## ---- Example in Krippendorff (2018), p. 290 ----
# 1 = book, 2 = letter, 3 = telephone, 4 = computer, 5 = folder
krippendorff_1 <- as.matrix(read.csv("data/krippendorff-2018-p290.csv"))

expect_equal(
    current = krippalpha(krippendorff_1)$alpha,
    target = 0.743,
    tolerance = 0.001
)
expect_equal(
    current = krippalpha(krippendorff_1, metric = "ordinal")$alpha,
    target = 0.815,
    tolerance = 0.001
)
expect_equal(
    current = krippalpha(krippendorff_1, metric = "interval")$alpha,
    target = 0.849,
    tolerance = 0.001
)
expect_equal(
    current = krippalpha(krippendorff_1, metric = "ratio")$alpha,
    target = 0.797,
    tolerance = 0.001
)

## ---- Example in Krippendorff (2018), p. 306 ----
krippendorff_2 <- as.matrix(read.csv("data/krippendorff-2018-p306.csv"))
expect_equal(
    current = krippalpha(krippendorff_2)$alpha,
    target = 0.2343,
    tolerance = 0.001
)

## ---- Example in Krippendorff (2018), p. 310 ----
krippendorff_3 <- as.matrix(read.csv("data/krippendorff-2018-p310.csv"))

## in the book, he actually said 0.760, likely due to rounding
expect_equal(
    current = krippalpha(krippendorff_3)$alpha,
    target = 0.759,
    tolerance = 0.001
)

## ---- Example in Hayes/Krippendorff (2007) ----
# See https://doi.org/10.1080/19312450709336664
# The Hayes/Krippendorff example data is arranged in 40 rows (coded units) and
# 5 columns (coders). Since krippalpha expects coded units in columns and
# coders in rows, we need to transpose the data.
hayes <- t(as.matrix(read.csv("data/hayes-krippendorff-2007.csv")))

expect_equal(
    current = krippalpha(hayes, metric = "ordinal")$alpha,
    target = 0.7598,
    tolerance = 0.001
)
expect_equal(
    krippalpha(hayes, metric = "nominal")$alpha,
    target = 0.4765,
    tolerance = 0.001
)

## ---- Examples in Freelon (2010) ----
# See https://dfreelon.org/publications/2010_ReCal_Intercoder_reliability_calculation_as_a_web_service.pdf
# The test data is available from http://dfreelon.org/recal/ijis/ijis.icr.data.zip

# Please note: In the Freelon example data, each row describes a coded unit,
# while each column belongs to a specific coder.
# Since krippalpha() expects coded units in columns and coders in rows, we need
# to transpose the data.
freelon_matrices <- lapply(
    X = sort(dir(path = "data", pattern = "^freelon-2010-r", full.names = TRUE)),
    FUN = function(x) t(as.matrix(read.csv(file = x, header = FALSE)))
)

# Using the reference values in the last column of Freelon 2010 (Table 9, 10),
# which were computed with Hayes' SPSS macro. Not using the values computed with
# ReCal3 due to lower numeric precision
freelon_alphas <- c(
    read.csv("data/freelon-2010-table-09.csv", check.names = FALSE)[["Krippendorff's α (Hayes)"]],
    read.csv("data/freelon-2010-table-10.csv", check.names = FALSE)[["Krippendorff's α (Hayes)"]]
)

observed_alphas <- vapply(
    X = freelon_matrices,
    FUN = function(x) krippalpha(x)$alpha,
    FUN.VALUE = numeric(1)
)
expect_equal(
    current = observed_alphas,
    target = freelon_alphas,
    tolerance = 0.001
)

## ---- Example in Chan/Sältzer's (2020) oolong-Package ----
# See https://github.com/gesistsa/oolong/issues/96
mat <- structure(
    .Data = c(
        2, 1, 1, 2, 2, 1, 2, 2, 1, 2,
        2, 1, 2, 2, 2, 2, 2, 2, 2, 2,
        2, 2, 2, 2, 2, 2, 2, 2, 2, 2
    ),
    dim = c(3L, 10L),
    dimnames = list(c("R1", "R2", "R3"), NULL)
)

hand_calculation <- 1 - (4 / ((5 * 25) / 29))
expect_equal(
    target = krippalpha(mat)$alpha,
    current = hand_calculation,
    tolerance = 0.001
)
