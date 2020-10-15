context("Test utils functions")

test_that("base_url returns base url", {

  expect_equal(base_url(), "https://api.beta.ons.gov.uk/v1/")

})

test_that("get_latest_version retrieves data set response", {

  out <- get_latest_version("wellbeing-local-authority")
  expect_named(out, c("@context", "alerts", "collection_id",
                      "dimensions", "downloads", "edition",
                      "id", "links", "release_date", "state",
                      "usage_notes", "version"))
  expect_type(out, "list")

})

test_that("res_to_list converst http response to list", {

  out <- res_to_list("https://api.beta.ons.gov.uk/v1/datasets/cpih01")
  expect_type(out, "list")
  expect_named(out, c("@context", "contacts", "description",
                      "id", "keywords", "license", "links", "methodologies",
                      "national_statistic", "next_release", "publications",
                      "publisher", "qmi", "related_datasets",
                      "release_frequency", "state", "theme", "title",
                      "unit_of_measure"))

})
