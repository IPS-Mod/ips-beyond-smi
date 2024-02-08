source("renv/activate.R")

####################################################
### Create directories if they don't already exist 
folder_paths <- c("1_populations",
                  "1_populations/R_scripts",
                  "1_populations/output",
                  "1_populations/intermediate_data",
                  "2_labour_market",
                  "2_labour_market/R_scripts",
                  "2_labour_market/output",
                  "2_labour_market/intermediate_data",
                  "3_calibrating_treatment_effects",
                  "3_calibrating_treatment_effects/R_scripts",
                  "3_calibrating_treatment_effects/output",
                  "3_calibrating_treatment_effects/intermediate_data",
                  "4_eq5d_health_utilities",
                  "4_eq5d_health_utilities/R_scripts",
                  "4_eq5d_health_utilities/output",
                  "4_eq5d_health_utilities/intermediate_data",
                  "5_ukmod_data_inputs",
                  "5_ukmod_data_inputs/R_scripts",
                  "5_ukmod_data_inputs/output",
                  "5_ukmod_data_inputs/intermediate_data",
                  "data",
                  "data/family_resources_survey",
                  "data/health_survey_for_england",
                  "data/labour_force_survey",
                  "data/understanding_society")

sapply(folder_paths, function(fpath) {
  outputDir <- fpath
  if(!dir.exists(here::here(outputDir))) {dir.create(here::here(outputDir))}
})

rm(folder_paths)
