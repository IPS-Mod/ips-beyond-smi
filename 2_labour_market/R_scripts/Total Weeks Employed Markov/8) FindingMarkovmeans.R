
#weighted means 

##Filtering by Benefit group
#Unempbenefits1, Inactbenefits1, Sickbenefits1, Otherbenefits1, nobenefits1

#unemployed

#employed
Unemployed1 <- filter(Emptotalmonthsworked, Unempbenefits1 == 1) 

Unemployed1 <- Unemployed1 %>%
  summarise(Unemployed1 = weighted.mean(Emptotalmonthsworked, w = LGWT))

#non employed

Unemployed2 <- filter(NonEmptotalmonthsworked, Unempbenefits1 == 1) 

Unemployed2 <- Unemployed2 %>%
  summarise(Unemployed1 = weighted.mean(NonEmptotalmonthsworked, w = LGWT))

#Inactive

#employed

Inactive1 <- filter(Emptotalmonthsworked, Inactbenefits1 == 1) 

Inactive1 <- Inactive1 %>%
  summarise(Inactive1 = weighted.mean(Emptotalmonthsworked, w = LGWT))

#non employed

Inactive2 <- filter(NonEmptotalmonthsworked, Inactbenefits1 == 1) 

Inactive2 <- Inactive2 %>%
  summarise(Inactive2 = weighted.mean(NonEmptotalmonthsworked, w = LGWT))

#Sick

#employed

Sick1 <- filter(Emptotalmonthsworked, Sickbenefits1 == 1) 

Sick1 <- Sick1 %>%
  summarise(Sick1 = weighted.mean(Emptotalmonthsworked, w = LGWT))

#non employed

Sick2 <- filter(NonEmptotalmonthsworked, Sickbenefits1 == 1) 

Sick2 <- Sick2 %>%
  summarise(Sick2 = weighted.mean(NonEmptotalmonthsworked, w = LGWT))


#Other

#employed

Other1 <- filter(Emptotalmonthsworked, Otherbenefits1 == 1) 

Other1 <- Other1 %>%
  summarise(Other1 = weighted.mean(Emptotalmonthsworked, w = LGWT))

#non employed

Other2 <- filter(NonEmptotalmonthsworked, Otherbenefits1 == 1) 

Other2 <- Other2 %>%
  summarise(Other2 = weighted.mean(NonEmptotalmonthsworked, w = LGWT))

#No

#employed

No1 <- filter(Emptotalmonthsworked, nobenefits1 == 1) 

No1 <- No1 %>%
  summarise(No1 = weighted.mean(Emptotalmonthsworked, w = LGWT))

#non employed 

No2 <- filter(NonEmptotalmonthsworked, nobenefits1 == 1) 

No2 <- No2 %>%
  summarise(No2 = weighted.mean(NonEmptotalmonthsworked, w = LGWT))