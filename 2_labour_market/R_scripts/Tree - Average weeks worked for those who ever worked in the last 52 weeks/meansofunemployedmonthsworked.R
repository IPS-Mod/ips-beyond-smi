## Specify Benefit group / Unempbenefits1, Inactbenefits1, Sickbenefits1, Otherbenefits1, nobenefits1,

unemployed <- filter(datacomplete, Unempbenefits1 == 1)


#Change values for weeks worked based on benefit group specified above

#Unemployed	2.217962
#Inactive	2.587659
#Sick	2.020134
#Other	2.401251
#No	2.287036



unemployed$everworkedw1[unemployed$everworkedw1 %in% 1] <- 2.217962
unemployed$everworkedw2[unemployed$everworkedw2 %in% 1] <- 2.217962
unemployed$everworkedw3[unemployed$everworkedw3 %in% 1] <- 2.217962
unemployed$everworkedw4[unemployed$everworkedw4 %in% 1] <- 2.217962
unemployed$everworkedw5[unemployed$everworkedw5 %in% 1] <- 2.217962
  

##weighted means

#Wave 1

Wave1 <- filter(unemployed, Empl1 == 0) %>%
  drop_na(everworkedw1)

Wave1 <- Wave1 %>%
  summarise(Wave1 = weighted.mean(everworkedw1, w = LGWT))


#Wave 2

Wave2 <- filter(unemployed, Empl1 == 0, Empl2 == 0) %>%
  drop_na(everworkedw2)

Wave2 <- Wave2 %>%
  summarise(Wave2 = weighted.mean(everworkedw2, w = LGWT))

#Wave 3

Wave31 <- filter(unemployed, Empl1 == 0, Empl2 == 0, Empl3 == 0) %>%
  drop_na(everworkedw3)

Wave31 <- Wave31 %>%
  summarise(Wave31 = weighted.mean(everworkedw3, w = LGWT))


Wave32 <- filter(unemployed, Empl1 == 0, Empl2 == 1, Empl3 == 0) %>%
  drop_na(everworkedw3)

Wave32 <- Wave32 %>%
  summarise(Wave32 = weighted.mean(everworkedw3, w = LGWT))

#Wave 4

Wave41 <- filter(unemployed, Empl1 == 0, Empl2 == 0, Empl3 == 0, Empl4 == 0) %>%
  drop_na(everworkedw4)

Wave41 <- Wave41 %>%
  summarise(Wave41 = weighted.mean(everworkedw4, w = LGWT))


Wave42 <- filter(unemployed, Empl1 == 0, Empl2 == 0, Empl3 == 1, Empl4 == 0) %>%
  drop_na(everworkedw4)

Wave42 <- Wave42 %>%
  summarise(Wave41 = weighted.mean(everworkedw4, w = LGWT))


Wave43 <- filter(unemployed, Empl1 == 0, Empl2 == 1, Empl3 == 0, Empl4 == 0) %>%
  drop_na(everworkedw4)

Wave43 <- Wave43 %>%
  summarise(Wave43 = weighted.mean(everworkedw4, w = LGWT))


Wave44 <- filter(unemployed, Empl1 == 0, Empl2 == 1, Empl3 == 1, Empl4 == 0) %>%
  drop_na(everworkedw4)

Wave44 <- Wave44 %>%
  summarise(Wave44 = weighted.mean(everworkedw4, w = LGWT))

#Wave 5

Wave51 <- filter(unemployed, Empl1 == 0, Empl2 == 0, Empl3 == 0, Empl4 == 0, Empl5 == 0) %>%
  drop_na(everworkedw5)

Wave51 <- Wave51 %>%
  summarise(Wave51 = weighted.mean(everworkedw5, w = LGWT))


Wave52 <- filter(unemployed, Empl1 == 0, Empl2 == 0, Empl3 == 0, Empl4 == 1, Empl5 == 0) %>%
  drop_na(everworkedw5)

Wave52 <- Wave52 %>%
  summarise(Wave52 = weighted.mean(everworkedw5, w = LGWT))


Wave53 <- filter(unemployed, Empl1 == 0, Empl2 == 0, Empl3 == 1, Empl4 == 0, Empl5 == 0) %>%
  drop_na(everworkedw5)

Wave53 <- Wave53 %>%
  summarise(Wave53 = weighted.mean(everworkedw5, w = LGWT))


Wave54 <- filter(unemployed, Empl1 == 0, Empl2 == 0, Empl3 == 1, Empl4 == 1, Empl5 == 0) %>%
  drop_na(everworkedw5)

Wave54 <- Wave54 %>%
  summarise(Wave54 = weighted.mean(everworkedw5, w = LGWT))


Wave55 <- filter(unemployed, Empl1 == 0, Empl2 == 1, Empl3 == 0, Empl4 == 0, Empl5 == 0) %>%
  drop_na(everworkedw5)

Wave55 <- Wave55 %>%
  summarise(Wave55 = weighted.mean(everworkedw5, w = LGWT))


Wave56 <- filter(unemployed, Empl1 == 0, Empl2 == 1, Empl3 == 0, Empl4 == 1, Empl5 == 0) %>%
  drop_na(everworkedw5)

Wave56 <- Wave56 %>%
  summarise(Wave56 = weighted.mean(everworkedw5, w = LGWT))


Wave57 <- filter(unemployed, Empl1 == 0, Empl2 == 1, Empl3 == 1, Empl4 == 0, Empl5 == 0) %>%
  drop_na(everworkedw5)

Wave57 <- Wave57 %>%
  summarise(Wave57 = weighted.mean(everworkedw5, w = LGWT))


Wave58 <- filter(unemployed, Empl1 == 0, Empl2 == 1, Empl3 == 1, Empl4 == 1, Empl5 == 0) %>%
  drop_na(everworkedw5)

Wave58 <- Wave58 %>%
  summarise(Wave58 = weighted.mean(everworkedw5, w = LGWT))


















  
  



