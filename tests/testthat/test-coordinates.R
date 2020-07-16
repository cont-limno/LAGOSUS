context("coordinates")

test_that("coordinatize works", {
  # dt  <- readRDS("inst/lagos_test_subset.rds")
  dt  <- readRDS("lagos_test_subset.rds")
  res <- coordinatize(dt$locus$lake_information)

  expect_equal(nrow(res), 2)
  expect_s3_class(res, "sf")
})
