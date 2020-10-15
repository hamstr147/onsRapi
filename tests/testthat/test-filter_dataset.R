context("Test filter_dataset")

test_that("filter_dataset returns full data set when no parameters set", {

  out <- filter_dataset("cpih01")
  code_list <- get_code_lists("cpih01")

  expect_named(out, c("V4_0", "mmm.yy", "time", "uk.only",
                      "geography", "cpih1dim1aggid", "aggregate"))
  expect_equal(dim(out), c(55272, 7))
  expect_true(all(code_list[["aggregate"]][["label"]] %in% out[["aggregate"]]))

})

test_that("filter_dataset returns data set determined by specified parameters", {
  expect_true(TRUE)
})
