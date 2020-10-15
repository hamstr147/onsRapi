<!-- badges: start -->
[![Travis build status](https://travis-ci.com/hamstr147/onsRapi.svg?branch=master)](https://travis-ci.com/hamstr147/onsRapi)
<!-- badges: end -->
# onsRapi
A package that implements an R client for the ONS web API.

## How to use it
A user can see what datasets are available using the `list_datasets` function. An optional `include_desc` argument can be set to `TRUE` to return the dataset IDs alongside full descriptions in a data frame. 
```
datasets <- list_datasets()
head(datasets)

                          id
1                     cpih01
2           mid-year-pop-est
3         ashe-table-7-hours
4      ashe-table-7-earnings
5         ashe-table-8-hours
6      ashe-table-8-earnings
7                 opss-rates
8            opss-membership
9      wellbeing-year-ending
10 wellbeing-local-authority
```
Suppose we want to look at the cpih01 data set (which shows inflation as measured using CPI). Firstly, we can see what dimensions we can use to filter the data using the `get_code_lists` function. 
```
cpi_codes <- get_code_lists("cpih01")
names(cpi_codes)

[1] "time"      "geography" "aggregate"
```
So we can filter this dataset using any of these dimensions. To see what values we can use to filter the data, we can inspect the individual elements of `cpi_codes`, which is a list. I'm not sure what 'aggregate' is so let's take a look at that. 
```
head(cpi_codes$aggregate)

             code                                     label
1 cpih1dim1S90401 09.4.1 Recreational and sporting services
2 cpih1dim1S90501                              09.5.1 Books
3 cpih1dim1S90402                  09.4.2 Cultural services
4 cpih1dim1T90000                 09 Recreation and culture
5 cpih1dim1T80000                          08 Communication
6 cpih1dim1T10000       01 Food and non-alcoholic beverages
```
I'm interested in inflation in book prices, so let's download that data. We can use the 'code' value in the code list data frames to filter the data - we can provide as many or few filters as we want, and if we don't provide any at all, I get the full data set!

In this case, I'll use the `cpih1dim1S90501` value to filter on `aggregate`, and I won't filter on `geography` or `time`, so I will get results for book-related CPI for all times and geographies available. All I need to do is pass the id of the dataset (`"cpih01"`) and a filter (`aggregate = "cpih1dim1S90501"`) to the `get_dataset` function:
```
book_cpi <- get_dataset("cpih01", aggregate = "cpih1dim1S90501")
Getting data set...
 [100%] Downloaded 28740 bytes...
Done!

head(book_cpi)
   V4_0 mmm-yy   time   uk-only      geography  cpih1dim1aggid    aggregate
1: 85.0 Jan-12 Jan-12 K02000001 United Kingdom cpih1dim1S90501 09.5.1 Books
2: 93.9 Oct-11 Oct-11 K02000001 United Kingdom cpih1dim1S90501 09.5.1 Books
3: 61.1 May-94 May-94 K02000001 United Kingdom cpih1dim1S90501 09.5.1 Books
4: 80.5 Feb-05 Feb-05 K02000001 United Kingdom cpih1dim1S90501 09.5.1 Books
5: 68.9 May-98 May-98 K02000001 United Kingdom cpih1dim1S90501 09.5.1 Books
6: 49.3 Apr-90 Apr-90 K02000001 United Kingdom cpih1dim1S90501 09.5.1 Books

```
And there you go - book inflation in the UK all the way back to the 90s. 

## How it works
This package is an R wrapper for the filtering functionality as outlined on the ONS website [here](https://developer.ons.gov.uk/filters/). It sends options for each dimension via POST to create a filtered dataset, which can then be retrieved through a GET on the filter output. This provides a more general way of retrieving datasets than just using GET requests - the current ONS API only support the use of one wildcard in each query. With filtering, we can get anything from the full data set to a single observation using a single method. 
