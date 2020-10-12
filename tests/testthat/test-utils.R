context("Test utils functions")

test_that("base_url returns base url", {
  out <- base_url()
  exp <- "https://api.beta.ons.gov.uk/v1/"
  expect_equal(out, exp)
})
