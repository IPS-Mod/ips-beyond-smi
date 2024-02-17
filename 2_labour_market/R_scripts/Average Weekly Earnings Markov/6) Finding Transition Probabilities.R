
#transition probabilities 

##Filtering by Benefit group
#Unempbenefits1, Inactbenefits1, Sickbenefits1, Otherbenefits1, nobenefits1

#unemployed

#entering employment

Unemployed1 <- filter(BindingUEpost, Unempbenefits1 == 1) 
  
Unemployed1 <- Unemployed1 %>%
  summarise(Unemployed1 = weighted.mean(BindingEpost, w = LGWT))

#staying in employment

Unemployed2 <- filter(BindingEEpost, Unempbenefits1 == 1) 
  
Unemployed2 <- Unemployed2 %>%
  summarise(Unemployed1 = weighted.mean(BindingEpost, w = LGWT))

#Inactive

#entering employment

Inactive1 <- filter(BindingUEpost, Inactbenefits1 == 1) 
  
Inactive1 <- Inactive1 %>%
  summarise(Inactive1 = weighted.mean(BindingEpost, w = LGWT))

#staying in employment

Inactive2 <- filter(BindingEEpost, Inactbenefits1 == 1) 
  
Inactive2 <- Inactive2 %>%
  summarise(Inactive2 = weighted.mean(BindingEpost, w = LGWT))

#Sick

#entering employment

Sick1 <- filter(BindingUEpost, Sickbenefits1 == 1) 
  
Sick1 <- Sick1 %>%
  summarise(Sick1 = weighted.mean(BindingEpost, w = LGWT))

#staying in employment

Sick2 <- filter(BindingEEpost, Sickbenefits1 == 1) 
  
Sick2 <- Sick2 %>%
  summarise(Sick2 = weighted.mean(BindingEpost, w = LGWT))


#Other

#entering employment

Other1 <- filter(BindingUEpost, Otherbenefits1 == 1) 
  
Other1 <- Other1 %>%
  summarise(Other1 = weighted.mean(BindingEpost, w = LGWT))

#staying in employment

Other2 <- filter(BindingEEpost, Otherbenefits1 == 1) 
  
Other2 <- Other2 %>%
  summarise(Other2 = weighted.mean(BindingEpost, w = LGWT))

#No

#entering employment

No1 <- filter(BindingUEpost, nobenefits1 == 1) 
  
No1 <- No1 %>%
  summarise(No1 = weighted.mean(BindingEpost, w = LGWT))

#staying in employment 

No2 <- filter(BindingEEpost, nobenefits1 == 1) 
  
No2 <- No2 %>%
  summarise(No2 = weighted.mean(BindingEpost, w = LGWT))

