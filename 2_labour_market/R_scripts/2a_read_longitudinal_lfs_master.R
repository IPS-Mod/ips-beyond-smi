source("2_labour_market/R_scripts/2a_read_longitudinal_lfs1.R")
source("2_labour_market/R_scripts/2a_read_longitudinal_lfs2.R")

completedata <- rbindlist(list(final_data_1, final_data_2), fill = TRUE)

rm(i, input, input_data, data4, data20)

saveRDS(completedata, "2_labour_market/intermediate_data/lfs_longitudinal_cleaned.rds")
saveRDS(final_data_1, "2_labour_market/intermediate_data/lfs_longitudinal_cleaned_health_cond.rds")