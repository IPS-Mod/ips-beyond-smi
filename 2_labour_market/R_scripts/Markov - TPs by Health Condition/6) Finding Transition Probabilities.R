
#transition probabilities 

##Filtering by Health Condition

#MSK1 
#MH1
#MSK_MH1 

#MSK

#entering employment

MSK1 <- filter(BindingUEpost, MSK1 == 1) 
  
MSK1 <- MSK1 %>%
  summarise(MSK1 = weighted.mean(BindingEpost, w = LGWT))

#staying in employment

MSK2 <- filter(BindingEEpost, MSK1 == 1) 
  
MSK2 <- MSK2 %>%
  summarise(MSK1 = weighted.mean(BindingEpost, w = LGWT))

#MH

#entering employment

MH1 <- filter(BindingUEpost, MH1 == 1) 
  
MH1 <- MH1 %>%
  summarise(MH1 = weighted.mean(BindingEpost, w = LGWT))

#staying in employment

MH2 <- filter(BindingEEpost, MH1 == 1) 
  
MH2 <- MH2 %>%
  summarise(MH2 = weighted.mean(BindingEpost, w = LGWT))

#MSKMH

#entering employment

MSKMH1 <- filter(BindingUEpost, MSK_MH1 == 1) 
  
MSKMH1 <- MSKMH1 %>%
  summarise(MSKMH1 = weighted.mean(BindingEpost, w = LGWT))

#staying in employment

MSKMH2 <- filter(BindingEEpost, MSK_MH1 == 1) 
  
MSKMH2 <- MSKMH2 %>%
  summarise(MSKMH2 = weighted.mean(BindingEpost, w = LGWT))






