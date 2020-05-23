context("lagos_load")

test_that("lagos_load fails well", {

  skip_on_cran()
  skip_on_travis()
  skip_on_appveyor()

  expect_error(lagosus_load("gibberish"),
               paste0("Module 'gibberish' not found. Please specify one or more modules by name: locus, depth, geo, limno. Alternatively, try running the `lagosus_get` command."),
    fixed = TRUE)
})

test_that("reachcodes have non-scientific notation", {

  skip_on_cran()
  skip_on_ci()

  lakes_limno <- lagosus_load("locus")$locus$locus_information
  expect_gt(
    nchar(lakes_limno[lakes_limno$lagoslakeid == 448,]$lake_reachcode),
    13)# [1] "4.51733E+12"
})

# test_that("sampledate is parsed correctly", {
#
#   skip_on_cran()
#   skip_on_travis()
#   skip_on_appveyor()
#
#   epi_nutr <- lagosus_load("limno")$epi_nutr
#
#   expect_equal(any(!is.na(epi_nutr$sampledate)), TRUE)
# })
