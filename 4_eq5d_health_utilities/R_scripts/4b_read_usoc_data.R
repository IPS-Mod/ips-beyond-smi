
source("03_load_packages.R")

## input arguments

root  <- ""
file  <- here::here("data/understanding_society")
full  <- TRUE # full interviews (no proxies) only
waves <- 1:13
ages  <- 16:64
country <- "England"
keep_vars <- NULL
complete_vars <- c("h_eq5d_score","l_econ_stat_2cat")

##########################
### Full UKHLS panel data

usoc <- ukhlsclean(root = root,
                   file = file,
                   full = full,
                   waves = waves,
                   ages = ages,
                   country = country,
                   keep_vars = keep_vars,
                   complete_vars = complete_vars)

keep_vars <- c("id","wave","h_eq5d_score","d_age","d_age_12cat","d_sex","d_marital","d_hiqual",
               "l_econ_stat_7cat", "s_current_smoker","h_disability","d_gor","wave_no","d_imd_quintile")

data <- usoc[, ..keep_vars]
saveRDS(data, "4_eq5d_health_utilities/intermediate_data/USoc_w1_to_w13.rds")