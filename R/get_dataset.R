#' Get a data set with optional filtering
#'
#' Returns a data frame containing a filtered data set.
#'
#' @param id ID of a data set. Data set IDs can be viewed using the
#' `list_datasets` function.
#' @param ... Optional further arguments specifying dimension values.
#' Dimensions and possible values for a particular data set can be viewed
#' using the `get_codelists` function.
#' @return A data frame containing requested data.
#' @importFrom jsonlite unbox toJSON fromJSON
#' @importFrom utils read.csv
#' @export
get_dataset <- function(id, ...) {

  filter_url <- paste0(base_url(), "filters?submitted=true")

  # data set details
  latest_ver <- get_latest_version(id)
  edition <- latest_ver$edition
  version <- latest_ver$version

  # create body for POST
  dots <- list(...)

  dimensions <- lapply(
    seq_along(dots),
    function(i) {
      list(
        name = jsonlite::unbox(names(dots)[i]),
        options = dots[[i]]
      )
    }
  )

  body <- list(
    dataset = list(
      id = jsonlite::unbox(id),
      edition = jsonlite::unbox(edition),
      version = jsonlite::unbox(version)
    ),
    dimensions = dimensions
  )

  body_json <- jsonlite::toJSON(body)

  # POST filter parameters then find output url
  post_res <- httr::POST(filter_url, body = body_json)
  post_raw <- post_res$content
  post_char <- rawToChar(post_raw)

  # error check
  if (httr::http_error(post_res)) {
    stop(
      sprintf(
        "ONS API request failed %s \n %s",
        httr::status_code(post_res),
        post_char
      ),
      call. = FALSE
    )
  }

  post_list <- jsonlite::fromJSON(post_char)

  filter_out <- post_list[["links"]][["filter_output"]][["href"]]

  # happens asynchronously so wait while filter processes
  download_link <- NULL
  message("Getting data set...\n")
  while (is.null(download_link)) {
    get_res <- res_to_list(filter_out)
    Sys.sleep(1)
    download_link <- get_res[["downloads"]][["csv"]][["href"]]
  }
  out <- utils::read.csv(download_link)
  message("Done!")
  out

}
