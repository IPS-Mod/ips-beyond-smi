#construct a total weeks worked column 

totalweeksworked <- imputednasremoved 

totalweeksworked <- mutate(totalweeksworked, totalweeksworked = wave2months + wave3months + wave4months + wave5months)

#Filtering for each end of the tree and each Health Condition and those who worked *some* hours (Average weeks employed for those employed)

##Health Condition

#MSK1 
#MH1 
#MSK_MH1 

totalweeksworked <- filter(totalweeksworked, MSK_MH1 == 1)


#filtering to the 16 scenarios

Wave51 <- filter(totalweeksworked, Empl1 == 0, Empl2 == 0, Empl3 == 0, Empl4 == 0, Empl5 == 0, totalweeksworked > 0) %>%
  drop_na(totalweeksworked)
Wave51 <- Wave51 %>%
  summarise(Wave51 = weighted.mean(totalweeksworked, w = LGWT))

Wave52 <- filter(totalweeksworked, Empl1 == 0, Empl2 == 0, Empl3 == 0, Empl4 == 0, Empl5 == 1, totalweeksworked > 0) %>%
  drop_na(totalweeksworked)
Wave52 <- Wave52 %>%
  summarise(Wave52 = weighted.mean(totalweeksworked, w = LGWT))

Wave53 <- filter(totalweeksworked, Empl1 == 0, Empl2 == 0, Empl3 == 0, Empl4 == 1, Empl5 == 0, totalweeksworked > 0) %>%
  drop_na(totalweeksworked)
Wave53 <- Wave53 %>%
  summarise(Wave53 = weighted.mean(totalweeksworked, w = LGWT))

Wave54 <- filter(totalweeksworked, Empl1 == 0, Empl2 == 0, Empl3 == 0, Empl4 == 1, Empl5 == 1, totalweeksworked > 0) %>%
  drop_na(totalweeksworked)
Wave54 <- Wave54 %>%
  summarise(Wave54 = weighted.mean(totalweeksworked, w = LGWT))

Wave55 <- filter(totalweeksworked, Empl1 == 0, Empl2 == 0, Empl3 == 1, Empl4 == 0, Empl5 == 0, totalweeksworked > 0) %>%
  drop_na(totalweeksworked)
Wave55 <- Wave55 %>%
  summarise(Wave55 = weighted.mean(totalweeksworked, w = LGWT))

wave56 <- filter(totalweeksworked, Empl1 == 0, Empl2 == 0, Empl3 == 1, Empl4 == 0, Empl5 == 1, totalweeksworked > 0) %>%
  drop_na(totalweeksworked)
wave56 <- wave56 %>%
  summarise(wave56 = weighted.mean(totalweeksworked, w = LGWT))

Wave57 <- filter(totalweeksworked, Empl1 == 0, Empl2 == 0, Empl3 == 1, Empl4 == 1, Empl5 == 0, totalweeksworked > 0) %>%
  drop_na(totalweeksworked)
Wave57 <- Wave57 %>%
  summarise(Wave57 = weighted.mean(totalweeksworked, w = LGWT))

wave58 <- filter(totalweeksworked, Empl1 == 0, Empl2 == 0, Empl3 == 1, Empl4 == 1, Empl5 == 1, totalweeksworked > 0) %>%
  drop_na(totalweeksworked)
wave58 <- wave58 %>%
  summarise(wave58 = weighted.mean(totalweeksworked, w = LGWT))

Wave59 <- filter(totalweeksworked, Empl1 == 0, Empl2 == 1, Empl3 == 0, Empl4 == 0, Empl5 == 0, totalweeksworked > 0) %>%
  drop_na(totalweeksworked)
Wave59 <- Wave59 %>%
  summarise(Wave59 = weighted.mean(totalweeksworked, w = LGWT))

wave510 <- filter(totalweeksworked, Empl1 == 0, Empl2 == 1, Empl3 == 0, Empl4 == 0, Empl5 == 1, totalweeksworked > 0) %>%
  drop_na(totalweeksworked)
wave510 <- wave510 %>%
  summarise(wave510 = weighted.mean(totalweeksworked, w = LGWT))

Wave511 <- filter(totalweeksworked, Empl1 == 0, Empl2 == 1, Empl3 == 0, Empl4 == 1, Empl5 == 0, totalweeksworked > 0) %>%
  drop_na(totalweeksworked)
Wave511 <- Wave511 %>%
  summarise(Wave511 = weighted.mean(totalweeksworked, w = LGWT))

wave512 <- filter(totalweeksworked, Empl1 == 0, Empl2 == 1, Empl3 == 0, Empl4 == 1, Empl5 == 1, totalweeksworked > 0) %>%
  drop_na(totalweeksworked)
wave512 <- wave512 %>%
  summarise(wave512 = weighted.mean(totalweeksworked, w = LGWT))

Wave513 <- filter(totalweeksworked, Empl1 == 0, Empl2 == 1, Empl3 == 1, Empl4 == 0, Empl5 == 0, totalweeksworked > 0) %>%
  drop_na(totalweeksworked)
Wave513 <- Wave513 %>%
  summarise(Wave513 = weighted.mean(totalweeksworked, w = LGWT))

wave514 <- filter(totalweeksworked, Empl1 == 0, Empl2 == 1, Empl3 == 1, Empl4 == 0, Empl5 == 1, totalweeksworked > 0) %>%
  drop_na(totalweeksworked)
wave514 <- wave514 %>%
  summarise(wave514 = weighted.mean(totalweeksworked, w = LGWT))

Wave515 <- filter(totalweeksworked, Empl1 == 0, Empl2 == 1, Empl3 == 1, Empl4 == 1, Empl5 == 0, totalweeksworked > 0) %>%
  drop_na(totalweeksworked)
Wave515 <- Wave515 %>%
  summarise(Wave515 = weighted.mean(totalweeksworked, w = LGWT))

wave516 <- filter(totalweeksworked, Empl1 == 0, Empl2 == 1, Empl3 == 1, Empl4 == 1, Empl5 == 1, totalweeksworked > 0) %>%
  drop_na(totalweeksworked)
wave516 <- wave516 %>%
  summarise(wave516 = weighted.mean(totalweeksworked, w = LGWT))
