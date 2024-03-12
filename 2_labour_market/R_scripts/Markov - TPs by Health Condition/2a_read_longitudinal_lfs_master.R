rm(list=ls(all=TRUE))

## 0: AJ2012 - OD2014 (doesn't have OOBEN for benefit groups)
## 1: JM2015 - OD2018
## 2: JM2019 - JM2022 (doesn't have health condition)

## 1 + 2 -> data on which benefit groups was based 
## 0 + 1 -> data from which health conditiosn are based

source("2_labour_market/R_scripts/2a_read_longitudinal_lfs0.R")
source("2_labour_market/R_scripts/2a_read_longitudinal_lfs1.R")
source("2_labour_market/R_scripts/2a_read_longitudinal_lfs2.R")

benefit_group_data    <- rbindlist(list(final_data_1, final_data_2), fill = TRUE)
health_condition_data <- rbindlist(list(final_data_0, final_data_1), fill = TRUE)

rm(i, input, input_data, data4, data20)

saveRDS(benefit_group_data, "2_labour_market/intermediate_data/lfs_longitudinal_cleaned_benefit_group.rds")
saveRDS(health_condition_data, "2_labour_market/intermediate_data/lfs_longitudinal_cleaned_health_cond.rds")