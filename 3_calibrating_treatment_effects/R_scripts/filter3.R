#IPS_PROB_13weeks_empl <- 0.18
#IPS_PROB_at12mth_empl <- 0.1611
#IPS_PROB_in12mth_empl <- 0.2602

######filtering by three outcome targets


#filter 'at 12 month' to +/- 0.5% of 16.11%

filtered <- sim_output_MSK_MH_e %>%
  filter(abs(diff_at12mth_empl) < 0.005)


#### filter 'in 12 months' to +/- 10% of target 

filtered2  <- filtered %>%
  filter(abs(diff_in12mth_empl) < 0.1)

#### filter '13 weeks or more' to +/- 10% of target. 

filtered3  <- filtered2 %>%
  filter(abs(diff_13weeks_empl) < 0.1)


##########Filtering by benefit group targets USION

#filter 'Unemployed' group to between 10% and 90%

filtered4 <- filtered3 %>%
  filter(prop_U < 0.9, prop_U > 0.1)


#filter 'Sick' group to between 10% and 90%

filtered5 <- filtered4 %>%
  filter(prop_S < 0.9, prop_S > 0.1)


#filter 'Inactive' group to between 10% and 20%

filtered6 <- filtered5 %>%
  filter(prop_I < 0.20, prop_I > 0.10)


#filter 'Other' group to between 0% and 5%

filtered7 <- filtered6 %>%
  filter(prop_O < 0.05)

#filter 'No' group to between 1% and 40%

filtered8 <- filtered7 %>%
  filter(prop_N < 0.4, prop_N > 0.01)




write.csv(filtered8, "X:/HAR_PR/PR/IPS_beyond_SMI_NIHR202996/General/CBA Tool/Data for Tool//benesplit2.csv")
