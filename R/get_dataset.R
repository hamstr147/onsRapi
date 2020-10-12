#' Get a data set
#'
#' Returns a data frame containing a data set.
#'
#' @param id ID of a data set. Data set IDs can be viewed using the `list_datasets` function.
#' @param full_dataset A logical value indicating whether you want to download the full data set. If `TRUE` any further parameters are ignored.
#' @param ... Further arguments specifying dimension values. Dimensions and possible values for a particular data set can be viewed using the `get_codelists` function.
#' @return A data frame containing requested data.
#' @export
get_dataset <- function(id, full_dataset = FALSE, ...) {

  res <- get_latest_version(id)

  if(full_dataset) {

    if("csv" %in% names(res$downloads)) {

      obs <- read.csv(res$downloads$csv$href)
      out <- obs[, !grepl(".", names(obs), fixed = TRUE)]

      return(out)

    } else {

      stop("No csv download of full data set available. Try setting query parameters instead.")

    }

  } else {

    dots <- list(...)

    dimensions <- paste(names(dots), dots, sep = "=")
    dimensions <- paste(dimensions, collapse = "&")
    dimensions <- paste0("/observations?", dimensions)

    query <- paste0(link, dimensions)
    obs <- res_to_list(query)
    out <- obs$observations[, !grepl(".*\\.(id|href)$", names(obs$observations))]

    if("dimensions" %in% names(out)) {
      out[["dimensions"]] <- vapply(
        out$dimensions,
        function(x) {
          x[["label"]]
        },
        rep("a", nrow(out)))
    }

    return(out)

  }

}
