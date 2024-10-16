## code to prepare `ukTownData` dataset goes here
library(readxl)
library(dplyr)
library(janitor)


ukTownData <- read_excel("data-raw/data.xlsx", sheet = 2)

ukTownData <- ukTownData |>
  clean_names()  # simplifies column names


ukTownData <- ukTownData |>
  mutate(across(where(is.character),
                ~na_if(., "*"))) # special characters ('*') with NA

ukTownData <- ukTownData |>
  select(
    town11nm,
    population_2011,
    size_flag,
    income_flag,
    activity_at_age_19_employment_with_earnings_above_0, # Correct column name here
    activity_at_age_19_employment_with_earnings_above_10_000, # Correct column name here
    highest_level_qualification_achieved_by_age_22_level_1_to_level_2,
    highest_level_qualification_achieved_by_age_22_level_3_to_level_5,
    highest_level_qualification_achieved_by_age_22_level_6_or_above,
    education_score
  )

# Rename columns to shorter names
ukTownData <- ukTownData |>
  rename(
    town = town11nm,
    population = population_2011,
    size = size_flag,
    income = income_flag,
    earnings_above_0 = activity_at_age_19_employment_with_earnings_above_0,
    earnings_above_10000 = activity_at_age_19_employment_with_earnings_above_10_000,
    edu_level1_2 = highest_level_qualification_achieved_by_age_22_level_1_to_level_2,
    edu_level3_5 = highest_level_qualification_achieved_by_age_22_level_3_to_level_5,
    edu_level6 = highest_level_qualification_achieved_by_age_22_level_6_or_above,
    edu_score = education_score
  )


usethis::use_data(ukTownData, overwrite = TRUE)
