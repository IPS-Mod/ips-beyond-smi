#### read in the simulation output and produce calibration factors

simulate <- readRDS("3_calibrating_treatment_effects/output/sim_output_MSK_MH_HLEtreat_b.rds")

ggplot(simulate) +
  geom_point(aes(y = PROB_in12mth_empl, x = PROB_at12mth_empl)) +
  labs(y = "Modelled outcome \n(% ever employed within 12 months)",
       x = "Modelled outcome \n(% employed at 12 months)",
       title = "Calibration simulation of IPS impacts",
       subtitle = "") +
  geom_point(aes(y = 0.4005, x = 0.2612), size = 2, color = "#0072B2") +
  geom_point(aes(y = 0.3385, x = 0.2095), size = 2, color = "#009E73") +
  geom_point(aes(y = 0.3697, x = 0.2355), size = 2, color = "#D55E00") +
  theme_minimal() +  
  scale_y_continuous(breaks = seq(0,1,0.1), labels = scales::percent) +
  scale_x_continuous(breaks = seq(0,1,0.1), labels = scales::percent) 
ggsave("3_calibrating_treatment_effects/output/calibration_plot_HLEtreat_MSK_MH.png")

simulate <- readRDS("3_calibrating_treatment_effects/output/sim_output_MSK_MH_HLEctrl_b.rds")

ggplot(simulate) +
  geom_point(aes(y = PROB_in12mth_empl, x = PROB_at12mth_empl)) +
  labs(y = "Modelled outcome \n(% ever employed within 12 months)",
       x = "Modelled outcome \n(% employed at 12 months)",
       title = "Calibration simulation of IPS impacts",
       subtitle = "") +
  geom_point(aes(y = 0.4005, x = 0.2612), size = 2, color = "#0072B2") +
  geom_point(aes(y = 0.3385, x = 0.2095), size = 2, color = "#009E73") +
  geom_point(aes(y = 0.3697, x = 0.2355), size = 2, color = "#D55E00") +
  theme_minimal() +  
  scale_y_continuous(breaks = seq(0,1,0.1), labels = scales::percent) +
  scale_x_continuous(breaks = seq(0,1,0.1), labels = scales::percent) 
ggsave("3_calibrating_treatment_effects/output/calibration_plot_HLEcontrol_MSK_MH.png")
