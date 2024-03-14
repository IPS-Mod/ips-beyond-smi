
### create a lookup table to export to excel for copying into the CBA model

msk_mh <- readRDS("3_calibrating_treatment_effects/intermediate_data/performance_multipliers_msk_mh.rds") %>%
  rename(multiplier_msk_mh = multiplier_imp)  %>%
  mutate(EmpAt12mth = as.character(EmpAt12mth))
msk <- readRDS("3_calibrating_treatment_effects/intermediate_data/performance_multipliers_msk.rds") %>%
  rename(multiplier_msk = multiplier_imp)  %>%
  mutate(EmpAt12mth = as.character(EmpAt12mth))
mh <- readRDS("3_calibrating_treatment_effects/intermediate_data/performance_multipliers_mh.rds") %>%
  rename(multiplier_mh = multiplier_imp) %>%
  mutate(EmpAt12mth = as.character(EmpAt12mth))

lookup_table <- merge(x = msk, 
                      y = merge(mh,
                                msk_mh, 
                                by = "EmpAt12mth", all = TRUE), 
                      by = "EmpAt12mth", all = TRUE) 

### create an expanded data table that allows for employment rates below the BAU ones.
### constrain all these to a multiplier of 1 (i.e. don't allow them to get any worse than BAU)

lookup <- data.table(EmpAt12mth = as.character(seq(0,1,0.01))) %>%
  left_join(lookup_table, by = "EmpAt12mth") %>%
  mutate(multiplier_msk    = ifelse(is.na(multiplier_msk)   , 1, multiplier_msk),
         multiplier_mh     = ifelse(is.na(multiplier_mh)    , 1, multiplier_mh),
         multiplier_msk_mh = ifelse(is.na(multiplier_msk_mh), 1, multiplier_msk_mh)) %>%
  mutate(EmpAt12mth = as.numeric(EmpAt12mth))

write.csv(lookup,"3_calibrating_treatment_effects/output/performance_multipliers.csv")

### plot the results:

lookup %>%
  pivot_longer(cols = c(multiplier_msk, multiplier_mh, multiplier_msk_mh), 
               names_to = "condition", 
               values_to = "multiplier") %>%
  ggplot() +
  aes(x = multiplier, y = EmpAt12mth, color = condition) +
  geom_line()


