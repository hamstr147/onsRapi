#' List data sets available from the ONS
#'
#' Returns a data frame listing the ids of data sets available from the ONS
#'
#' @param include_desc A logical value indicating whether the descriptions of each dataset should be included.
#' @return A data frame of data set IDs.
#' @importFrom httr GET
#' @importFrom jsonlite fromJSON
#' @export
list_datasets <-function(include_desc = FALSE) {

  res <- httr::GET(paste0(base_url(), "datasets"))
  res_json <- rawToChar(res$content)
  res_list <- jsonlite::fromJSON(res_json)

  if(include_desc) {
    data.frame(id = res_list$items$id,
               description = res_list$items$description)
  } else {
    data.frame(id = res_list$items$id)
  }

}
