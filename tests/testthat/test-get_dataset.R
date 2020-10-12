context("Test that get_dataset retrieves datasets as specified")

test_that("get_dataset retrieves cpih01 dataset", {
  out <- get_dataset("cpih01",
                     time = "Aug-16",
                     geography = "K02000001",
                     aggregate = "*")
  exp <- structure(list(dimensions = structure(c("09.1.2 Photographic, cinematographic and optical equipment",
                                                 "01.1.8 Sugar, jam, syrups, chocolate and confectionery", "12.5.4 Transport insurance"
  ), .Dim = c(3L, 1L), .Dimnames = list(NULL, "aggregate")), observation = c("91.8",
                                                                             "99.9", "113.7")), row.names = c(NA, 3L), class = "data.frame")

  expect_equal(head(out, 3), exp)

})

test_that("get_dataset retrieves ashe-table-7-hours data", {

  out <- get_dataset("ashe-table-7-hours",
                     full_dataset = TRUE)

})
