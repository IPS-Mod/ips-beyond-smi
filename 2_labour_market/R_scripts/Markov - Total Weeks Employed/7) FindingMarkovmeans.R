
#weighted means 

##Filtering by Health Condition

#MSK1 
#MH1 
#MSK_MH1 


#MSK

#employed
MSK1 <- filter(Emptotalmonthsworked, MSK1 == 1) 

MSK1 <- MSK1 %>%
  summarise(MSK1 = weighted.mean(Emptotalmonthsworked, w = LGWT))

#non employed

MSK2 <- filter(NonEmptotalmonthsworked, MSK1 == 1) 

MSK2 <- MSK2 %>%
  summarise(MSK1 = weighted.mean(NonEmptotalmonthsworked, w = LGWT))

#MH

#employed

MH1 <- filter(Emptotalmonthsworked, MH1 == 1) 

MH1 <- MH1 %>%
  summarise(MH1 = weighted.mean(Emptotalmonthsworked, w = LGWT))

#non employed

MH2 <- filter(NonEmptotalmonthsworked, MH1 == 1) 

MH2 <- MH2 %>%
  summarise(MH2 = weighted.mean(NonEmptotalmonthsworked, w = LGWT))

#MSK+MH

#employed

MSK_MH1 <- filter(Emptotalmonthsworked, MSK_MH1 == 1) 

MSK_MH1 <- MSK_MH1 %>%
  summarise(MSK_MH1 = weighted.mean(Emptotalmonthsworked, w = LGWT))

#non employed

MSK_MH2 <- filter(NonEmptotalmonthsworked, MSK_MH1 == 1) 

MSK_MH2 <- MSK_MH2 %>%
  summarise(MSK_MH2 = weighted.mean(NonEmptotalmonthsworked, w = LGWT))


