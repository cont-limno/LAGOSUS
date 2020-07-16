context("query_lagos_names")

test_that("query_lagos_names works", {

  # dt <- readRDS("inst/lagos_test_subset.rds")
  dt <- readRDS("lagos_test_subset.rds")
  expect_equal(
    query_lagos_names("namegnis", dt = dt),
    c("lake_link", "lake_information"))

})
