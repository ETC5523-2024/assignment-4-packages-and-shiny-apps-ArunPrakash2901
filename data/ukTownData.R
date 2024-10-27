#' UK Town Data
#'
#' A dataset containing demographic, economic, and educational information about various towns in the UK.
#'
#' @format A data frame with 1104 rows and 32 variables:
#' \describe{
#'   \item{TOWN11CD}{Unique code for each town (character)}
#'   \item{TOWN11NM}{Name of the town (character)}
#'   \item{POPULATION_2011}{Population of the town as of 2011 (numeric)}
#'   \item{SIZE_FLAG}{Size classification of the town (character, e.g., "Small Towns")}
#'   \item{RGN11NM}{Region name (character)}
#'   \item{COASTAL}{Indicates if the town is coastal or non-coastal (character)}
#'   \item{COASTAL_DETAILED}{Detailed classification of the coastal status (character)}
#'   \item{TTWA11CD}{Travel to Work Area (TTWA) code (character)}
#'   \item{TTWA11NM}{Name of the Travel to Work Area (character)}
#'   \item{TTWA_CLASSIFICATION}{Classification of the TTWA (character)}
#'   \item{JOB_DENSITY_FLAG}{Indicator of job density in the area (character)}
#'   \item{INCOME_FLAG}{Income categorization for the area (character)}
#'   \item{UNIVERSITY_FLAG}{Indicates if there is a university presence in the area (character)}
#'   \item{Level4Qual_residents35_64_2011}{Proportion of residents aged 35-64 with level 4 qualifications in 2011 (character)}
#'   \item{KS4_2012_2013_counts}{Number of Key Stage 4 students in the 2012-2013 academic year (numeric)}
#'   \item{KS2_attainment_2007_2008}{Attainment score for Key Stage 2 in the 2007-2008 academic year (numeric)}
#'   \item{KS4_attainment_2012_2013}{Attainment score for Key Stage 4 in the 2012-2013 academic year (numeric)}
#'   \item{Level_2_at_age_18}{Percentage of students achieving level 2 qualifications by age 18 (numeric)}
#'   \item{Level_3_at_age_18}{Percentage of students achieving level 3 qualifications by age 18 (numeric)}
#'   \item{full_time_HE_at_19}{Proportion of individuals at age 19 in full-time higher education (character)}
#'   \item{sustained_FE_at_19}{Proportion of individuals at age 19 in sustained further education (character)}
#'   \item{apprenticeships_at_19}{Proportion of individuals at age 19 in apprenticeships (character)}
#'   \item{earnings_above_0_at_19}{Proportion of individuals at age 19 employed with earnings above £0 (character)}
#'   \item{earnings_above_10000_at_19}{Proportion of individuals at age 19 employed with earnings above £10,000 (character)}
#'   \item{out_of_work_at_19}{Proportion of individuals at age 19 who are out of work (character)}
#'   \item{qualifications_less_than_level1_at_22}{Proportion achieving less than level 1 qualifications by age 22 (character)}
#'   \item{qualifications_level1_2_at_22}{Proportion achieving level 1 to level 2 qualifications by age 22 (character)}
#'   \item{qualifications_level3_5_at_22}{Proportion achieving level 3 to level 5 qualifications by age 22 (character)}
#'   \item{qualifications_level6_above_at_22}{Proportion achieving level 6 or above qualifications by age 22 (character)}
#'   \item{avg_qual_score_at_22}{Average qualification level achieved by age 22 (numeric)}
#'   \item{edu_score}{Composite education score for the town (numeric)}
#' }
#' @source TidyTuesday Project 2024, "Educational attainment of young people in English towns", available on the TidyTuesday GitHub repository: \url{https://github.com/rfordatascience/tidytuesday}
"ukTownData"
