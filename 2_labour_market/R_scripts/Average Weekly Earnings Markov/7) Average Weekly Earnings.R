
averageweeklyearnings <- datacomplete

##Find mean at individual level

averageweeklyearnings <- averageweeklyearnings %>% 
  rowwise() %>% 
  mutate(averageweeklyearnings = mean(c(GRSSWK2,GRSSWK3,GRSSWK4,GRSSWK5), na.rm=TRUE))


##Filtering by Benefit group

#Unempbenefits1, Inactbenefits1, Sickbenefits1, Otherbenefits1, nobenefits1

averageweeklyearnings <- filter(averageweeklyearnings, Otherbenefits1 == 1)

#find mean --> dropping NAs removes obvs for those not working

Markovmean <- averageweeklyearnings %>%
  drop_na(averageweeklyearnings)

Markovmean <- Markovmean %>%
  summarise(Markovmean = weighted.mean(averageweeklyearnings, w = LGWT))


