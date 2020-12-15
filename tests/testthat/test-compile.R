test_that("locus compile works", {
  # Only test lagosus_compile manually via: `test(filter = "compile")`
  skip_on_ci()
  skip_on_cran()

  lagosus_compile(
    locus_version = "1.0",
    locus_folder = "~/Downloads/LAGOSUS_LOCUS/LOCUS_v1.0",
    locus_overwrite = TRUE,
    dest_folder = ".")

  expect_true(file.exists("locus_1.0.qs"))
})
