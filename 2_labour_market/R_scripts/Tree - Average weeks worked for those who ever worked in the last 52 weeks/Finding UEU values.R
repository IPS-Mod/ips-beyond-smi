

##Filtering to UEU scenarios  


#Wave 2

Wave2 <- filter(monthsworked, Empl1 == 0, Empl2 == 1, Empl3 == 0) 

Wave2 <- Wave2 %>% rename_at('wave2months', ~'UEU') 

#Wave 3

Wave3 <- filter(monthsworked, Empl1 == 0, Empl2 == 0, Empl3 == 1, Empl4 == 0) 

Wave3 <- Wave3 %>% rename_at('wave3months', ~'UEU') 

#Wave 4

Wave41 <- filter(monthsworked, Empl1 == 0, Empl2 == 0, Empl3 == 0, Empl4 == 1, Empl5 == 0)

Wave41 <- Wave41 %>% rename_at('wave4months', ~'UEU') 

Wave42 <- filter(monthsworked, Empl1 == 0, Empl2 == 1, Empl3 == 0, Empl4 == 1, Empl5 == 0) 

Wave42 <- Wave42 %>% rename_at('wave4months', ~'UEU') 


#combine waves

monthsworkedUEU <- rbind(Wave2, Wave3, Wave41, Wave42, fill=TRUE)


#Find weighted mean for each health condition

#MSK1
#MH1
#MSK_MH1

monthsworkedUEU <- filter(monthsworkedUEU, MSK_MH1 == 1)

monthsworkedUEU <- monthsworkedUEU %>% drop_na(UEU)

monthsworkedUEUMEAN <- monthsworkedUEU %>%
  summarise(MEAN = weighted.mean(UEU, w = LGWT))




