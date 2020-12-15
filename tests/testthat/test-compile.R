test_that("locus compile works on linux", {
  # Only test lagosus_compile manually via: `test(filter = "compile")`
  skip_on_ci()
  skip_on_cran()
  skip_if(.Platform$OS.type == "windows")

  lagosus_compile(
    locus_version = "1.0",
    locus_folder = "~/Downloads/LAGOSUS_LOCUS/LOCUS_v1.0",
    locus_overwrite = TRUE,
    dest_folder = ".")

  expect_true(file.exists("locus_1.0.qs"))
})

test_that("locus compile works on windows", {
  # Only test lagosus_compile manually via: `test(filter = "compile")`
  skip_on_ci()
  skip_on_cran()
  skip_if(.Platform$OS.type == "unix")

  lagosus_compile(
    locus_version = "1.0",
    locus_folder = "~/Downloads/LAGOSUS_LOCUS/LOCUS_v1.0",
    locus_overwrite = TRUE,
    dest_folder = ".")

  expect_true(file.exists("locus_1.0.qs"))
})

test_that("limno compile works", {
  # Only test lagosus_compile manually via: `test(filter = "compile")`
  skip_on_ci()
  skip_on_cran()
  skip_if(.Platform$OS.type == "windows")

  lagosus_compile(
    limno_version = "2.1",
    limno_folder = "~/Downloads/LAGOSUS_LIMNO/US/LIMNO_v2.1/Final exports",
    limno_overwrite = TRUE,
    dest_folder = ".")

  expect_true(file.exists("limno_2.1.qs"))
})
