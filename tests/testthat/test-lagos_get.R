context("lagos_get")

test_that("lagosne_get urls are active", {

  skip_on_cran()
  skip_on_ci()

  # LAGOSNE_lakeslocus101.csv
  expect_true(
    LAGOSUS:::url_exists(paste0("https://portal.edirepository.org/nis/",
    "dataviewer?packageid=edi.100.4&entityid=ce274065dfb5b453c5696f715fe4e269"))
  )
})
