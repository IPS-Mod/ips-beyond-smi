
### filter 

#filter to hle trial outcomes

#filtering rule - within .5% of the employed @12mths IPS outcome
#and the E1,2,3, calibration factors decline or increase consistently

#IPS_PROB_13weeks_empl_TRT <- 0.22
#IPS_PROB_at12mth_empl_TRT <- 0.2355
#IPS_PROB_in12mth_empl_TRT <- 0.3697

filteredtrial <- simulate_bi %>%
  filter(0.2305 < PROB_at12mth_empl) %>%
  filter(PROB_at12mth_empl < 0.2405) %>%
  filter(0.21 < PROB_13weeks_empl) %>%
  #filter(PROB_13weeks_empl < 0.24) %>%
  filter(0.25 < PROB_in12mth_empl) %>%
  #filter(PROB_in12mth_empl < 0.4697) %>%
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
  filter(0.1 < PROB_13weeks_empl) %>%
  filter(PROB_13weeks_empl < 0.204) %>%
  filter(0.1 < PROB_in12mth_empl) %>%
  filter(PROB_in12mth_empl < 0.35) %>%
  filter((calib_E1 > calib_E2 & calib_E2 > calib_E3) | 
           (calib_E1 < calib_E2 & calib_E2 < calib_E3))


write.csv(filteredcontrol, "X:/HAR_PR/PR/IPS_beyond_SMI_NIHR202996/General/R/ips-beyond-smi/3_calibrating_treatment_effects/output//filteredcontrol.csv")




ctrl_factors <- read.csv("3_calibrating_treatment_effects/output/filteredcontrol.csv")
trt_factors  <- read.csv("3_calibrating_treatment_effects/output/filteredtrial.csv")

for (i in 1:nrow(ctrl_factors)){
for (j in 1:nrow(trt_factors)){
  
  c <- ctrl_factors[i, c("calib_U","calib_E1","calib_E2","calib_E3")]
  t <- trt_factors[j, c("calib_U","calib_E1","calib_E2","calib_E3")]
  
  ### flag if E1 > E2 > E3 in both arms
  
  flag_descending <- ifelse(as.numeric(c[,"calib_E1"]) >= as.numeric(c[,"calib_E2"]) &
                            as.numeric(c[,"calib_E2"]) >= as.numeric(c[,"calib_E3"]) &
                            as.numeric(t[,"calib_E1"]) >= as.numeric(t[,"calib_E2"]) &
                            as.numeric(t[,"calib_E2"]) >= as.numeric(t[,"calib_E3"]), 1, 0)
  
  ### flag if E1 < E2 < E3 in both arms
  
  flag_ascending <- ifelse(as.numeric(c[,"calib_E1"]) <= as.numeric(c[,"calib_E2"]) &
                           as.numeric(c[,"calib_E2"]) <= as.numeric(c[,"calib_E3"]) &
                           as.numeric(t[,"calib_E1"]) <= as.numeric(t[,"calib_E2"]) &
                           as.numeric(t[,"calib_E2"]) <= as.numeric(t[,"calib_E3"]), 1, 0)
  
  ### flag monotonic 
  
  flag_monotonic <- ifelse(flag_ascending == 1 | flag_descending == 1, 1, 0)
  
  ### flag if trt < ctrl in all cases
  
  flag_trt_ctrl <- ifelse(as.numeric(c[,"calib_U"]) >= as.numeric(t[,"calib_U"]) &
                          as.numeric(c[,"calib_E1"]) >= as.numeric(t[,"calib_E1"]) &
                          as.numeric(c[,"calib_E2"]) >= as.numeric(t[,"calib_E2"]) &
                          as.numeric(c[,"calib_E3"]) >= as.numeric(t[,"calib_E3"]), 1, 0)
  
  ### flag if all conditions are met to be able to use the factors
  
  USE <- ifelse(flag_monotonic == 1 & flag_trt_ctrl == 1, 1, 0)
  
  ###### Store flags 
  
  data_out <- data.table(ctrl_row = i,
                         trt_row = j,
                         USE = USE,
                         flag_trt_ctrl = flag_trt_ctrl,
                         flag_monotonic = flag_monotonic,
                         flag_mono_descending = flag_descending,
                         flag_mono_ascending = flag_ascending)
  
  if (i == 1 & j == 1){
    data <- copy(data_out)
  } else {
    data <- rbindlist(list(data_out, data))
  }
  
  
}  
}

useable_cases <- data[USE == 1,]


