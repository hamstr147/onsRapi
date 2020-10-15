#' Get ONS code lists for specified data sets
#'
#' @param id A data set ID.
#'
#' @return List of code lists relevant to the specified data set.
#'
#' @export
get_code_lists <- function(id) {

  link <- get_latest_version(id)
  # some links are broken as they duplicate 'v1/'
  dim_links <- ifelse(
    grepl("v1/v1", link$dimensions$href, fixed = TRUE),
    sub("v1/", "", link$dimensions$href, fixed = TRUE),
    link$dimensions$href
  )
  dimensions <- paste(dim_links, "editions", sep = "/")
  dim_names <- link$dimensions$name

  out <- lapply(
    seq_along(dimensions),
    function(i) {
      res <- res_to_list(dimensions[i])
      code_link <- res[["items"]][["links"]][["codes"]][["href"]]
      res <- res_to_list(code_link)
      res_df <- res[["items"]][, c("code", "label")]
      res_df
    }
  )

  names(out) <- dim_names

  out

}
