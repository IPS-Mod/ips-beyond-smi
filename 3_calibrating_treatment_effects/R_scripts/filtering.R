#filter to hle trial outcomes

#filtering rule - within .5% of the employed @12mths IPS outcome
#and the E1,2,3, calibration factors decline or increase consistently

#IPS_PROB_13weeks_empl_TRT <- 0.22
#IPS_PROB_at12mth_empl_TRT <- 0.2355
#IPS_PROB_in12mth_empl_TRT <- 0.3697

filteredtrial <- simulate_bi %>%
  filter(0.2305 < PROB_at12mth_empl) %>%
  filter(PROB_at12mth_empl < 0.2405) %>%
  #filter(0.20 < PROB_13weeks_empl) %>%
  #filter(PROB_13weeks_empl < 0.24) %>%
  #filter(0.30 < PROB_in12mth_empl) %>%
  #filter(PROB_in12mth_empl < 38) %>%
  filter((calib_E1 > calib_E2 & calib_E2 > calib_E3) | 
         (calib_E1 < calib_E2 & calib_E2 < calib_E3))
  
  
write.csv(filteredtrial, "X:/HAR_PR/PR/IPS_beyond_SMI_NIHR202996/General/R/ips-beyond-smi/3_calibrating_treatment_effects/output//filteredtrial.csv")





#filter to hle control outcomes

#filtering rule - within .5% of the employed @12mths IPS outcome
#and the E1,2,3, calibration factors decline or increase consistently

#IPS_PROB_13weeks_empl_CTRL <- 0.18
#IPS_PROB_at12mth_empl_CTRL <- 0.1986
#IPS_PROB_in12mth_empl_CTRL <- 0.3152


filteredcontrol <- simulate_bii %>%
  filter(0.1936 < PROB_at12mth_empl) %>%
  filter(PROB_at12mth_empl < 0.2036) %>%
  #filter(0.20 < PROB_13weeks_empl) %>%
  #filter(PROB_13weeks_empl < 0.24) %>%
  #filter(0.30 < PROB_in12mth_empl) %>%
  #filter(PROB_in12mth_empl < 38) %>%
  filter((calib_E1 > calib_E2 & calib_E2 > calib_E3) | 
           (calib_E1 < calib_E2 & calib_E2 < calib_E3))


write.csv(filteredcontrol, "X:/HAR_PR/PR/IPS_beyond_SMI_NIHR202996/General/R/ips-beyond-smi/3_calibrating_treatment_effects/output//filteredcontrol.csv")

