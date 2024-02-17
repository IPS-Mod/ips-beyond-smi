

#### Using waves 4 and 5 for wages and hours




#######Average wages in wave 5 of those who were unemployed in wave 1 and employed in Wave 5

employed <- filter(datacomplete, Empl1 == 0, Empl5 == 1) %>%
  drop_na(inflatedwage)

Wages <- employed %>%
  summarise(wages = weighted.mean(inflatedwage, w = LGWT))



####### Unemployment benefits: Average wages in wave 5 of those who were unemployed in wave 1 and employed in Wave 5

employed1 <- filter(datacomplete, Unempbenefits1 == 1, Empl1 == 0, Empl5 == 1) %>%
  drop_na(inflatedwage)

unempWages <- employed1 %>%
  summarise(wages = weighted.mean(inflatedwage, w = LGWT))





####### Sick Benefits: Average wages in wave 5 of those who were unemployed in wave 1 and employed in Wave 5

employed2 <- filter(datacomplete, Sickbenefits1 == 1, Empl1 == 0, Empl5 == 1) %>%
  drop_na(inflatedwage)

sickWages <- employed2 %>%
  summarise(wages = weighted.mean(inflatedwage, w = LGWT))




####### Inactive benefits: Average wages in wave 5 of those who were unemployed in wave 1 and employed in Wave 5

employed3 <- filter(datacomplete, Inactbenefits1 == 1, Empl1 == 0, Empl5 == 1) %>%
  drop_na(inflatedwage)

inactWages <- employed3 %>%
  summarise(wages = weighted.mean(inflatedwage, w = LGWT))


####### Other Benefits: Average wages in wave 5 of those who were unemployed in wave 1 and employed in Wave 5

employed4 <- filter(datacomplete, Otherbenefits1 == 1, Empl1 == 0, Empl5 == 1) %>%
  drop_na(inflatedwage)

otherWages <- employed4 %>%
  summarise(wages = weighted.mean(inflatedwage, w = LGWT))

####### No Benefits: Average wages in wave 5 of those who were unemployed in wave 1 and employed in Wave 5

employed5 <- filter(datacomplete, nobenefits1 == 1, Empl1 == 0, Empl5 == 1) %>%
  drop_na(inflatedwage)

nobenefitsWages <- employed5 %>%
  summarise(wages = weighted.mean(inflatedwage, w = LGWT))




#######Average Hours in wave 5 of those who were unemployed in wave 1 and employed in Wave 5

Hoursdata <- filter(datacomplete, Empl1 == 0, Empl5 == 1) %>%
  drop_na(TTUSHR5)

Hours <- Hoursdata %>%
  summarise(hours = weighted.mean(TTUSHR5, w = LGWT))

#######Unemployment benefits:

Hoursdata1 <- filter(datacomplete, Unempbenefits1 == 1, Empl1 == 0, Empl5 == 1) %>%
  drop_na(TTUSHR5)

unempHours <- Hoursdata1 %>%
  summarise(hours = weighted.mean(TTUSHR5, w = LGWT))



#####Sick Benefits

Hoursdata2 <- filter(datacomplete, Sickbenefits1 == 1, Empl1 == 0, Empl5 == 1) %>%
  drop_na(TTUSHR5)

sickHours <- Hoursdata2 %>%
  summarise(hours = weighted.mean(TTUSHR5, w = LGWT))


######Inactive Benefits

Hoursdata3 <- filter(datacomplete, Inactbenefits1 == 1, Empl1 == 0, Empl5 == 1) %>%
  drop_na(TTUSHR5)

InactHours <- Hoursdata3 %>%
  summarise(hours = weighted.mean(TTUSHR5, w = LGWT))

######Other Benefits

Hoursdata4 <- filter(datacomplete, Otherbenefits1 == 1, Empl1 == 0, Empl5 == 1) %>%
  drop_na(TTUSHR5)

Hoursothers <- Hoursdata4 %>%
  summarise(hours = weighted.mean(TTUSHR5, w = LGWT))

######No benefits

Hoursdata5 <- filter(datacomplete, nobenefits1 == 1, Empl1 == 0, Empl5 == 1) %>%
  drop_na(TTUSHR5)

Hoursno <- Hoursdata5 %>%
  summarise(hours = weighted.mean(TTUSHR5, w = LGWT))