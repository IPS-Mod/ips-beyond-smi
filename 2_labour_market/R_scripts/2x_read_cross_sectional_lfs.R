
library(data.table)
library(lfsclean)

root <- ""
file <- here::here("data/labour_force_survey_xsection")
year <- 2015:2023
ages <- 16:89
keep_vars <- NULL
complete_vars <- NULL
deflator <- "cpih"

data <- lfsclean(root = root,
                 file = file,
                 year = year,
                 ages = ages,
                 keep_vars = keep_vars,
                 complete_vars = complete_vars,
                 deflator = deflator)

saveRDS(data, "2_labour_market/intermediate_data/lfs_cross_sectional_2015_2023_cleaned.rds")

