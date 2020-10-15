context("Test get_code_lists function")

test_that("get_code_lists returns list for specified data set", {

  out <- get_code_lists("ashe-tables-25")
  expect_type(out, "list")
  expect_named(out, c("time", "geography", "statistics",
                      "sex", "workingpattern",
                      "hoursandearnings", "sectortype"))

})
