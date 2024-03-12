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

# All non-employed W1 population
#
#Unemployed	Sick	  Inactive	Other   None
#5.341%	    17.609%	8.834%	  17.126%	51.090%



# constraints on benefit group proportions

filtered4 <- filtered3 %>%
  filter(prop_U <= 1) %>%
  filter(prop_S <= 1) %>%
  filter(prop_I < 0.08) %>%
  filter(prop_O < 0.01) %>%
  filter(prop_N <= 1) %>%
  mutate(prop_UN = prop_U + prop_N)



#filter 'Other' group to +/- 1% of 0%

filtered5 <- filtered4 %>%
  filter(prop_UN > 0.56431)







#filter 'Unemployed' group to +/- 10% of 40%

filtered4 <- filtered3 %>%
  filter(prop_U < 0.5, prop_U > 0.3)


#filter 'Sick' group to +/- 10% of 30%

filtered5 <- filtered4 %>%
  filter(prop_S < 0.4, prop_S > 0.2)


#filter 'Inactive' group to +/- 1% of 12.7%

filtered6 <- filtered5 %>%
  filter(prop_I < 0.15, prop_I > 0.10)


#filter 'Other' group to +/- 1% of 0%

filtered7 <- filtered6 %>%
  filter(prop_O < 0.1)

#filter 'No' group to +/- 1% of 11%

filtered8 <- filtered7 %>%
  filter(prop_N < 0.20, prop_N > 0.5)





write.csv(atb, "X:/HAR_PR/PR/IPS_beyond_SMI_NIHR202996/General/CBA Tool/Data for Tool//atb.csv")
