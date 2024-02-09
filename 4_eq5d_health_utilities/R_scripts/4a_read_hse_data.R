## The aim of this code is to read in and clean the Health Survey for England data
## to produce health condition prevalence estimates

source("03_load_packages.R")

## set inputs for the reading function
#root <- "X:/"
#file <- "HAR_PR/PR/Consumption_TA/HSE/Health Survey for England (HSE)/HSE 2018/tab/hse_2018_eul_22052020.tab"

root <- ""
file <- "data/health_survey_for_england/hse_2018_eul_22052020.tab"

###########################################
## read in 2018 data and clean 

data_2018 <- read_2018(root = root, 
                       file = file) %>%
  clean_age() %>%
  clean_demographic() %>%
  clean_economic_status() %>%
  clean_health_and_bio() %>% 
  clean_education() %>%
  smk_status() %>%
  alc_drink_now_allages() %>%
  alc_weekmean_adult() %>%
  select(hse_id, wt_int, age, age_cat, sex, imd_quintile, ethnicity_2cat, activity_lstweek,
         marstat, eduend4cat, degree, cig_smoker_status, weekmean,
         hse_cancer, hse_endocrine, hse_heart, hse_mental, hse_nervous, hse_eye,
         hse_ear, hse_respir, hse_disgest, hse_urinary, hse_skin, hse_muscskel, hse_infect,
         hse_blood, hse_other,
         MO_5l, SC_5l, UA_5l, PA_5l, AD_5l,
         MO_3l, SC_3l, UA_3l, PA_3l, AD_3l) %>%
  filter(age %in% 18:64)

############################################
## (1) Make each health condition character variable into a factor variable
## (2) Use dummy_columns() to create a set of 0/1 dummy variables 
## (3) drop the original factor variables
## (4) rename the variables created by dummy_columns()

data <- data_2018 %>%
  mutate(hse_cancer = factor(hse_cancer, levels = c("no_cancer","cancer")),
         hse_endocrine = factor(hse_endocrine, levels = c("no_endocrine","endocrine")),
         hse_heart = factor(hse_heart, levels = c("no_heart","heart")),
         hse_mental = factor(hse_mental, levels = c("no_mental","mental")),
         hse_nervous = factor(hse_nervous, levels = c("no_nervous","nervous")),
         hse_eye = factor(hse_eye, levels = c("no_eye","eye")),
         hse_ear = factor(hse_ear, levels = c("no_ear","ear")),
         hse_respir = factor(hse_respir, levels = c("no_respir","respir")),  
         hse_disgest = factor(hse_disgest, levels = c("no_disgest","disgest")),
         hse_urinary = factor(hse_urinary, levels = c("no_urinary","urinary")),
         hse_skin = factor(hse_skin, levels = c("no_skin","skin")),
         hse_muscskel = factor(hse_muscskel, levels = c("no_muscskel","muscskel")),
         hse_infect = factor(hse_infect, levels = c("no_infect","infect")),
         hse_blood = factor(hse_blood, levels = c("no_blood","blood")),
         hse_other = factor(hse_other, levels = c("no_other","other")),
         activity_lstweek = factor(activity_lstweek, levels = c("employed","education","unemployed",
                                                                "retired","sick_ill_disab","home_or_family")),
         unempl_lstweek = ifelse(activity_lstweek %in% c("employed","education"),0,1),
         unempl_lstweek2 = ifelse(activity_lstweek %in% c("unemployed"),1,0)
  ) %>%
  dummy_columns(select_columns = c("hse_cancer", "hse_endocrine", "hse_heart", 
                                   "hse_mental", "hse_nervous", "hse_eye",
                                   "hse_ear", "hse_respir", "hse_disgest", 
                                   "hse_urinary", "hse_skin", "hse_muscskel", 
                                   "hse_infect", "hse_blood", "hse_other"), 
                ignore_na = TRUE,
                remove_first_dummy = TRUE) %>%
  select(-c(hse_cancer, hse_endocrine, hse_heart, 
            hse_mental, hse_nervous, hse_eye,
            hse_ear, hse_respir, hse_disgest, 
            hse_urinary, hse_skin, hse_muscskel, 
            hse_infect, hse_blood, hse_other)) %>%
  rename(hse_cancer = hse_cancer_cancer,
         hse_endocrine = hse_endocrine_endocrine,
         hse_heart = hse_heart_heart,
         hse_mental = hse_mental_mental,
         hse_nervous = hse_nervous_nervous,
         hse_eye = hse_eye_eye,
         hse_ear = hse_ear_ear,
         hse_respir = hse_respir_respir,  
         hse_disgest = hse_disgest_disgest,
         hse_urinary = hse_urinary_urinary,
         hse_skin = hse_skin_skin,
         hse_muscskel = hse_muscskel_muscskel,
         hse_infect = hse_infect_infect,
         hse_blood = hse_blood_blood,
         hse_other = hse_other_other) %>%
  mutate(age_cat_new = age_cat,
         age_cat_new = ifelse(age_cat %in% c("18-19","20-24"), "18-24", age_cat_new),
         age_cat_new = ifelse(age_cat %in% c("25-29","30-34"), "25-34", age_cat_new),
         age_cat_new = ifelse(age_cat %in% c("35-39","40-44","45-49"), "35-49", age_cat_new),
         age_cat_new = ifelse(age_cat %in% c("50-54","55-59","60-64"), "50-64", age_cat_new))


### save out cleaned data

saveRDS(data,"4_eq5d_health_utilities/intermediate_data/hse_cleaned_2018.rds")

rm(list = ls())