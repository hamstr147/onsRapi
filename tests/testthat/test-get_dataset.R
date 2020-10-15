context("Test get_dataset")

test_that("get_dataset returns data set in line with specfied parameters", {

  out <- get_dataset("cpih01", aggregate = "cpih1dim1T60000")
  expect_s3_class(out, "data.frame")
  expect_named(out,
               c("V4_0", "mmm.yy", "time", "uk.only",
                 "geography", "cpih1dim1aggid",
                 "aggregate"))
  expect_true(all(out$aggregate == "06 Health"))
  expect_true(all(out$cpih1dim1aggid == "cpih1dim1T60000"))

})
