context("Test create_get_data_function")

test_that("create_get_data_function creates function for data set ID", {

  get_cpih01 <- create_get_data_function("cpih01")
  expect_type(get_cpih01, "closure")
  expect_equal(formals(get_cpih01), pairlist(time = NULL,
                                             geography = NULL,
                                             aggregate = NULL))

})
