
source("03_load_packages.R")

data <- readRDS("2_labour_market/intermediate_data/lfs_cross_sectional_2015_2023_cleaned.rds")

### Get three datasets - working age OOW with health conditions. Need:

## (1) FOR NHS COSTS:
##     percentage disabled - two measures: 
##        (i) in receipt of ESA / Incapacity Benefit / Universal Credit
##        (ii) disabled under the Equalities Act 2010
##
## (2) FOR CHILDCARE COSTS:
##     distribution of household types into:
##         (i) no children
##         (ii) couples with children
##         (iii) lone parents with children

data_msk <- data %>%
  filter(d_age %in% 16:64, 
         l_lmstatus_8cat %in% c("unemployed","sick","caring","other"),
         h_musculoskeletal == 1) %>%
  mutate(sick_ben_group = ifelse(b_oowben == "sick_injured_disabled", 1, 0),
         disabled = ifelse(h_disability == "disabled", 1, 0)) %>%
  mutate(children_couple = ifelse(d_dep_children == "yes" & d_married_cohabiting == 1, 1, 0),
         children_lone_p = ifelse(d_dep_children == "yes" & d_married_cohabiting == 0, 1, 0)) %>%
  summarise(disability1 = weighted.mean(sick_ben_group, w = pwt, na.rm = TRUE),
            disability2 = weighted.mean(disabled, w = pwt, na.rm = TRUE),
            children_couple = weighted.mean(children_couple, w = pwt, na.rm = TRUE),
            children_lone_p = weighted.mean(children_lone_p, w = pwt, na.rm = TRUE)) %>%
  mutate(children_none = 1 - children_couple - children_lone_p) %>%
  mutate(health_condition = "MSK")


data_mh <- data %>%
  filter(d_age %in% 16:64, 
         l_lmstatus_8cat %in% c("unemployed","sick","caring","other"),
         h_mental_health == 1) %>%
  mutate(sick_ben_group = ifelse(b_oowben == "sick_injured_disabled", 1, 0),
         disabled = ifelse(h_disability == "disabled", 1, 0)) %>%
  mutate(children_couple = ifelse(d_dep_children == "yes" & d_married_cohabiting == 1, 1, 0),
         children_lone_p = ifelse(d_dep_children == "yes" & d_married_cohabiting == 0, 1, 0)) %>%
  summarise(disability1 = weighted.mean(sick_ben_group, w = pwt, na.rm = TRUE),
            disability2 = weighted.mean(disabled, w = pwt, na.rm = TRUE),
            children_couple = weighted.mean(children_couple, w = pwt, na.rm = TRUE),
            children_lone_p = weighted.mean(children_lone_p, w = pwt, na.rm = TRUE)) %>%
  mutate(children_none = 1 - children_couple - children_lone_p) %>%
  mutate(health_condition = "MH")


data_msk_mh <- data %>%
  filter(d_age %in% 16:64, 
         l_lmstatus_8cat %in% c("unemployed","sick","caring","other"),
         h_mental_health == 1 & h_musculoskeletal == 1) %>%
  mutate(sick_ben_group = ifelse(b_oowben == "sick_injured_disabled", 1, 0),
         disabled = ifelse(h_disability == "disabled", 1, 0)) %>%
  mutate(children_couple = ifelse(d_dep_children == "yes" & d_married_cohabiting == 1, 1, 0),
         children_lone_p = ifelse(d_dep_children == "yes" & d_married_cohabiting == 0, 1, 0)) %>%
  summarise(disability1 = weighted.mean(sick_ben_group, w = pwt, na.rm = TRUE),
            disability2 = weighted.mean(disabled, w = pwt, na.rm = TRUE),
            children_couple = weighted.mean(children_couple, w = pwt, na.rm = TRUE),
            children_lone_p = weighted.mean(children_lone_p, w = pwt, na.rm = TRUE)) %>%
  mutate(children_none = 1 - children_couple - children_lone_p) %>%
  mutate(health_condition = "MSK + MH")

data_out <- rbindlist(list(data_msk, data_mh, data_msk_mh))

write.csv(data_out, "2_labour_market/output/disability_and_childcare.csv")
