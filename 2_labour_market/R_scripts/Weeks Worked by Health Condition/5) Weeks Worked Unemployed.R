weeksworkedunemployed <- filter(imputednasremoved, MSK1 == 1)

##weighted means

#Wave 2

Wave21 <- filter(weeksworkedunemployed, Empl1 == 0, Empl2 == 0) %>%
  drop_na(wave2months)

Wave21 <- Wave21 %>%
  summarise(Wave21 = weighted.mean(wave2months, w = LGWT))

#Wave 3

Wave31 <- filter(weeksworkedunemployed, Empl1 == 0, Empl2 == 0, Empl3 == 0) %>%
  drop_na(wave3months)

Wave31 <- Wave31 %>%
  summarise(Wave31 = weighted.mean(wave3months, w = LGWT))


Wave32 <- filter(weeksworkedunemployed, Empl1 == 0, Empl2 == 1, Empl3 == 0) %>%
  drop_na(wave3months)

Wave32 <- Wave32 %>%
  summarise(Wave32 = weighted.mean(wave3months, w = LGWT))


#Wave 4

Wave41 <- filter(weeksworkedunemployed, Empl1 == 0, Empl2 == 0, Empl3 == 0, Empl4 == 0) %>%
  drop_na(wave4months)

Wave41 <- Wave41 %>%
  summarise(Wave41 = weighted.mean(wave4months, w = LGWT))


Wave42 <- filter(weeksworkedunemployed, Empl1 == 0, Empl2 == 0, Empl3 == 1, Empl4 == 0) %>%
  drop_na(wave4months)

Wave42 <- Wave42 %>%
  summarise(Wave42 = weighted.mean(wave4months, w = LGWT))


Wave43 <- filter(weeksworkedunemployed, Empl1 == 0, Empl2 == 1, Empl3 == 0, Empl4 == 0) %>%
  drop_na(wave4months)

Wave43 <- Wave43 %>%
  summarise(Wave43 = weighted.mean(wave4months, w = LGWT))


Wave44 <- filter(weeksworkedunemployed, Empl1 == 0, Empl2 == 1, Empl3 == 1, Empl4 == 0) %>%
  drop_na(wave4months)

Wave44 <- Wave44 %>%
  summarise(Wave44 = weighted.mean(wave4months, w = LGWT))


#Wave 5

Wave51 <- filter(weeksworkedunemployed, Empl1 == 0, Empl2 == 0, Empl3 == 0, Empl4 == 0, Empl5 == 0) %>%
  drop_na(wave5months)

Wave51 <- Wave51 %>%
  summarise(Wave51 = weighted.mean(wave5months, w = LGWT))

Wave52 <- filter(weeksworkedunemployed, Empl1 == 0, Empl2 == 0, Empl3 == 0, Empl4 == 1, Empl5 == 0) %>%
  drop_na(wave5months)

Wave52 <- Wave52 %>%
  summarise(Wave52 = weighted.mean(wave5months, w = LGWT))

wave53 <- filter(weeksworkedunemployed, Empl1 == 0, Empl2 == 0, Empl3 == 1, Empl4 == 0, Empl5 == 0) %>%
  drop_na(wave5months)

wave53 <- wave53 %>%
  summarise(wave53 = weighted.mean(wave5months, w = LGWT))

wave54 <- filter(weeksworkedunemployed, Empl1 == 0, Empl2 == 0, Empl3 == 1, Empl4 == 1, Empl5 == 0) %>%
  drop_na(wave5months)

wave54 <- wave54 %>%
  summarise(wave54 = weighted.mean(wave5months, w = LGWT))

wave55 <- filter(weeksworkedunemployed, Empl1 == 0, Empl2 == 1, Empl3 == 0, Empl4 == 0, Empl5 == 0) %>%
  drop_na(wave5months)

wave55 <- wave55 %>%
  summarise(wave55 = weighted.mean(wave5months, w = LGWT))

wave56 <- filter(weeksworkedunemployed, Empl1 == 0, Empl2 == 1, Empl3 == 0, Empl4 == 1, Empl5 == 0) %>%
  drop_na(wave5months)

wave56 <- wave56 %>%
  summarise(wave56 = weighted.mean(wave5months, w = LGWT))

wave57 <- filter(weeksworkedunemployed, Empl1 == 0, Empl2 == 1, Empl3 == 1, Empl4 == 0, Empl5 == 0) %>%
  drop_na(wave5months)

wave57 <- wave57 %>%
  summarise(wave57 = weighted.mean(wave5months, w = LGWT))

wave58 <- filter(weeksworkedunemployed, Empl1 == 0, Empl2 == 1, Empl3 == 1, Empl4 == 1, Empl5 == 0) %>%
  drop_na(wave5months)

wave58 <- wave58 %>%
  summarise(wave58 = weighted.mean(wave5months, w = LGWT))



