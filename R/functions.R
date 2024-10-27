library(dplyr)
#' Display BUA or BUASD status based on town name
#'
#' This function checks if a town is classified as BUA or BUASD using the `is_bua` column.
#'
#' @param data The dataset containing town information.
#' @param town_name The name of the town to check.
#' @return A string indicating whether the town is a BUA, BUASD, or neither.
#' @export
display_bua_buasd_status <- function(data, town_name) {
  # Filter the dataset for the specified town
  town_data <- data %>% dplyr::filter(town == town_name)

  # Check if town data exists
  if (nrow(town_data) == 0) {
    return("Town not found in the dataset.")
  }

  # Directly check the is_bua status for the town
  if (town_data$is_bua == 1) {
    return(paste(town_name, "is a BUA (Built-Up Area)."))
  } else if (town_data$is_bua == 0) {
    return(paste(town_name, "is a BUASD (Built-Up Area Sub-Division)."))
  } else {
    return(paste(town_name, "does not have a defined BUA or BUASD status."))
  }
}

#' List of BUA and BUASD towns
#'
#' This function returns a list containing two data frames: one for towns classified as BUA
#' and another for towns classified as BUASD.
#'
#' @param data The dataset containing town information.
#' @return A list with two data frames: BUA towns and BUASD towns.
#' @export
list_bua_buasd_towns <- function(data) {
  bua_towns <- data %>%
    dplyr::filter(is_bua == 1) %>%
    dplyr::pull(town) %>%
    unique() %>%
    data.frame(town = ., status = "BUA", stringsAsFactors = FALSE)
  buasd_towns <- data %>%
    dplyr::filter(is_bua == 0) %>%
    dplyr::pull(town) %>%
    unique() %>%
    data.frame(town = ., status = "BUASD", stringsAsFactors = FALSE)
  # a list to store the data frames
  result_list <- list(
    BUA = bua_towns,
    BUASD = buasd_towns
  )
  return(result_list)
}

#' Retrieve selected columns
#'
#' This function returns a subset of columns from the dataset.
#'
#' @param data The dataset to subset.
#' @param columns A vector of column names to retrieve.
#' @return A dataframe with only the selected columns.
#' @export
retrieve_selected_columns <- function(data, columns) {
  data %>%
    dplyr::select(all_of(columns))
}

#' Retrieve data for a specific town
#'
#' This function returns all rows related to a specific town.
#'
#' @param data The dataset to subset.
#' @param town_name The name of the town to retrieve.
#' @return A dataframe with data for the specified town.
#' @export
retrieve_town_data <- function(data, town_name) {
  data %>%
    dplyr::filter(town == town_name)
}

#' Launch the UkTownMetrics Shiny Application
#'
#' This function launches the Shiny application included in the `ausbirthplace` package.
#'
#' @return Runs the Shiny application.
#' @export
#'
#' @examples
#' \dontrun{
#' run_app()
#' }
run_app <- function() {
  app_dir <- system.file("ukTownMetrics", package = "ukTownMetrics")
  shiny::runApp("inst/ukTownMetrics", display.mode = "normal")
}


