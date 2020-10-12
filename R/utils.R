#' Base URL for ONS API
#'
#' @noRd
#' @keywords internal
base_url <- function() {
  "https://api.beta.ons.gov.uk/v1/"
}

#' Get and parse API results
#'
#' Gets result from URL and parses JSON content.
#'
#' @noRd
#' @keywords internal
#' @importFrom httr GET content
#' @importFrom jsonlite fromJSON
res_to_list <- function(url) {
  res <- httr::GET(url)
  content <- httr::content(res, as = "text", encoding = "UTF-8")
  out <- jsonlite::fromJSON(content)
  out
}

#' Get latest version link
#'
#' Gets link to latest version of a data set
#'
#' @noRd
#' @keywords internal
get_latest_version <- function(id) {
  dataset <- res_to_list(paste0(base_url(), "datasets/", id))
  link <- dataset$links$latest_version$href
  res <- res_to_list(link)
  res
}
