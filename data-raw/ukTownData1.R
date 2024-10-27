#' UK Town Data
#'
#' A dataset containing demographic, economic, and educational information about various towns in the UK.
#'
#' @format A data frame with [number of rows] rows and 11 variables:
#' \describe{
#'   \item{population}{Population of the town (numeric)}
#'   \item{size}{Size classification of the town (character, e.g., "Small Towns")}
#'   \item{income}{Income classification of the town (character, e.g., "Higher deprivation towns")}
#'   \item{earnings_above_0_at_19}{Percentage of population with earnings above 0 at age 19 (numeric)}
#'   \item{earnings_above_10000_at_19}{Percentage of population with earnings above 10,000 at age 19 (numeric)}
#'   \item{edu_level1_2_at_22}{Percentage of population with education level 1 or 2 at age 22 (numeric)}
#'   \item{edu_level3_5_at_22}{Percentage of population with education level 3 to 5 at age 22 (numeric)}
#'   \item{edu_level6_at_22}{Percentage of population with education level 6 at age 22 (numeric)}
#'   \item{edu_score}{Educational score of the town (numeric)}
#'   \item{is_bua}{Binary indicator of whether the town is in a built-up area (BUA) (1 = Yes, 0 = No) (integer)}
#'   \item{town}{Name of the town (character)}
#' }
#' @source TidyTuesday Project 2024, "Educational attainment of young people in English towns", available on the TidyTuesday GitHub repository: \url{https://github.com/rfordatascience/tidytuesday}
"ukTownData1"
