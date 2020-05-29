context("display_names")

test_that("display_names works", {

  skip_on_cran()
  skip_on_ci()

  lg <- lagosus_load("locus")

  expect_equal(
    display_names(names(lg$locus$locus_information))[22],
    "ID (ws)")
})
