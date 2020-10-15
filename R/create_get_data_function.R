#' Create a function to get a specific data set
#'
#' Returns a function that takes dimensions values as arguments which
#' can be used to get and filter a specified data set
#'
#' @param id The ID of a data set
#'
#' @return A function that takes values of each dimension of the
#' specified data set used to filter the data. These default to NULL,
#' which should return the whole data set.
#'
#' @export
create_get_data_function <- function(id) {

  codes <- get_code_lists(id)
  code_names <- names(codes)
  code_args <- paste(code_names, "NULL", sep = " = ", collapse = ", ")
  fun <- paste0("
      function(", code_args, ") {
      input_list <- c(id = '", id, "', as.list(environment()))
      input_list <- input_list[lengths(input_list) != 0]
      do.call(get_dataset, input_list)
      }
  ")

  eval(parse(text = fun))

}
