##Health Condition 

#MSK1
#MH1
#MSK_MH1


everworkedhc <- health_condition_data

#specify health condition
  
everworkedhc <- filter(everworkedhc, MSK_MH1== 1)

everworkedhc <- filter(everworkedhc, Empl1 == 0, Empl2 == 0, Empl3 == 0, Empl4 == 0, Empl5 == 0)


#Find if anyone worked in any wave:

everworkedhc <- mutate(everworkedhc, everworked = everworkedw2 + everworkedw3 + everworkedw4 + everworkedw5)

count(everworkedhc, everworked)

#Make maximum value 1 so it's binary for having worked in that year. 

everworkedhc <- everworkedhc %>% mutate(everworked = ifelse(everworked > 1, 1, everworked))

count(everworkedhc, everworked)


everworkedhc <- everworkedhc %>%
  summarise(everworkedhc= weighted.mean(everworked, w = LGWT))

