##Benefit group (Unempbenefits1, Sickbenefits1, Inactbenefits1, Otherbenefits1, nobenefits1,)

everworked <- filter(datacomplete, Inactbenefits1== 1)



##Wave 2 probabilities  

everworked <- filter(everworked, Empl1 == 0, Empl2 == 0, Empl3 == 0, Empl4 == 0, Empl5 == 0) %>%
  summarise(everworked= weighted.mean(everworked, w = LGWT))
