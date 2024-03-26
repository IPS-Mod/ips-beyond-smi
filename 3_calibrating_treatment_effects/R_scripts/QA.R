source("03_load_packages.R")


msk <- readRDS("3_calibrating_treatment_effects/intermediate_data/performance_multipliers_msk.rds")
  
msk_by_disability <- readRDS("3_calibrating_treatment_effects/intermediate_data/performance_multipliers_msk_by_disability.rds") %>%
  filter(disability_rate == 0.11)

merge <- merge(x = msk, y = msk_by_disability, by = "EmpAt12mth")

ggplot(merge) +
  geom_line(aes(x = EmpAt12mth, y = multiplier_imp.x), color = "blue") +
  geom_line(aes(x = EmpAt12mth, y = multiplier_imp.y), color = "red", linetype = 2) +
  geom_hline(yintercept = 0, color = "black") +
  theme_minimal()