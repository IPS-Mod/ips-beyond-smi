source("03_load_packages.R")

root <- ""
file <- here::here("data/family_resources_survey")
years <- 2018:2021
ages <- NULL
keep_vars <- NULL
complete_vars <- NULL
inflate <- TRUE
price_year <- 2021
index <- "cpih"

### run cleaning function

data <- frsclean(root = root,
                 file = file,
                 years = years,
                 ages = ages,
                 keep_vars = keep_vars,
                 complete_vars = complete_vars,
                 inflate = inflate,
                 price_year = price_year,
                 index = index)

saveRDS(data, "5_ukmod_data_inputs/intermediate_data/frsclean_2018-22.rds")
