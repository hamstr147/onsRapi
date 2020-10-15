context("Test list_datasets function")

test_that("list_datasets returns a dataframe of dataset ids", {
  out <- list_datasets()
  exp <- structure(
    list(
      id = c("cpih01", "mid-year-pop-est",
             "ashe-table-7-hours",
             "ashe-table-7-earnings",
             "ashe-table-8-hours",
             "ashe-table-8-earnings",
             "opss-rates",
             "opss-membership",
             "wellbeing-year-ending",
             "wellbeing-local-authority",
             "trade",
             "life-expectancy-local-authority",
             "suicides-in-the-uk",
             "ashe-tables-7-and-8",
             "index-private-housing-rental-prices",
             "ashe-tables-9-and-10",
             "ashe-tables-11-and-12",
             "ashe-table-5",
             "labour-market",
             "regional-gdp-by-quarter",
             "regional-gdp-by-year",
             "childrens-wellbeing",
             "generational-income",
             "ashe-tables-26",
             "ashe-tables-25",
             "ashe-tables-3",
             "ashe-tables-20",
             "ashe-tables-27-and-28",
             "wellbeing-quarterly",
             "ageing-population-estimates",
             "older-people-sex-ratios",
             "older-people-net-internal-migration",
             "older-people-economic-activity",
             "health-accounts",
             "weekly-deaths-age-sex",
             "weekly-deaths-region",
             "weekly-deaths-health-board",
             "weekly-deaths-local-authority",
             "house-prices-local-authority",
             "ageing-population-projections",
             "projections-older-people-sex-ratios",
             "faster-indicators-shipping-data",
             "projections-older-people-in-single-households",
             "tax-benefits-statistics",
             "online-job-advert-estimates",
             "gdp-4-dp")),
    class = "data.frame", row.names = c(NA, -46L))
  expect_equal(out, exp)
})

test_that("include_desc = TRUE returns df with descriptions", {
  out <- list_datasets(include_desc = TRUE)
  expect_named(out, c("id", "description"))
  expect_type(out[["description"]], "character")
})
