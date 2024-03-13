########Sustainment (Unemployed in Wave 1, Employed in Wave 2, sustainment in 3,4,5)############


######### Limit data to those who are on unemployment benefits and unemployed in wave 1 and employed in wave 2. 

employedunemp3 <- filter(datacomplete, Empl1 == 0, Unempbenefits1 == 1, Empl2 == 1)

table(employedunemp3$Empl2)

#######From this population, find mean of employment in wave 3

sustainmentunemp3 <- employedunemp3 %>%
  summarise(wave3 = weighted.mean(Empl3, w = LGWT))

table(employedunemp3$Empl3)

######### Limit data to those who are on unemployment benefits and unemployed in wave 1 and employed in wave 2 and wave 3. 
#######From this population, find mean of employment in wave 4

sustainmentunemp4 <- employedunemp3 %>%
  mutate(Empl34 = ifelse(Empl3 == 1 & Empl4 == 1, 1, 0)) 

table(sustainmentunemp4$Empl34)

######### Limit data to those who are on unemployment benefits and unemployed in wave 1 and employed in wave 2, wave 3 and wave 4.           
#######From this population, find mean of employment in wave 5            
sustainmentunemp5 <- employedunemp3 %>%
  mutate(Empl345 = ifelse(Empl3 == 1 & Empl4 == 1 & Empl5 == 1, 1, 0)) 

table(sustainmentunemp5$Empl345)          







######### Limit data to those who are on sick benefits and were unemployed in wave 1 and employed in wave 2. 

employedsick3 <- filter(datacomplete, Empl1 == 0, Sickbenefits1 == 1, Empl2 == 1)

table(employedsick3$Empl2)

#######From this population, find mean of employment in wave 3, 4 and 5 <---% of people still in work who found a job in wave 2. 

sustainmentsick3 <- employedsick3 %>%
  summarise(wave3 = weighted.mean(Empl3, w = LGWT))

table(employedsick3$Empl3)


######### Limit data to those who are on sick benefits and unemployment in wave 1 and employed in wave 2 and wave 3. 
#######From this population, find mean of employment in wave 4

sustainmentsick4 <- employedsick3 %>%
  mutate(Empl34 = ifelse(Empl3 == 1 & Empl4 == 1, 1, 0)) 

table(sustainmentsick4$Empl34)

######### Limit data to those who are on sick benefits and unemployment in wave 1 and employed in wave 2, wave 3 and wave 4.           
#######From this population, find mean of employment in wave 5            
sustainmentsick5 <- employedsick3 %>%
  mutate(Empl345 = ifelse(Empl3 == 1 & Empl4 == 1 & Empl5 == 1, 1, 0)) 

table(sustainmentsick5$Empl345)





######### Limit data to those who are on inactive benefits and were unemployed in wave 1 and employed in wave 2. 

employedinactive3 <- filter(datacomplete, Empl1 == 0, Inactbenefits1 == 1, Empl2 == 1)

table(employedinactive3$Empl2)

#######From this population, find mean of employment in wave 3, 4 and 5 <---% of people still in work who found a job in wave 2. 

sustainmentinactive3 <- employedinactive3 %>%
  summarise(wave3 = weighted.mean(Empl3, w = LGWT))

table(employedinactive3$Empl3)

######### Limit data to those who are on inactive benefits and unemployment in wave 1 and employed in wave 2 and wave 3. 
#######From this population, find mean of employment in wave 4

sustainmentinactive4 <- employedinactive3 %>%
  mutate(Empl34 = ifelse(Empl3 == 1 & Empl4 == 1, 1, 0)) 

table(sustainmentinactive4$Empl34)


######### Limit data to those who are on inactive benefits and unemployment in wave 1 and employed in wave 2, wave 3 and wave 4.           
#######From this population, find mean of employment in wave 5            
sustainmentinactive5 <- employedinactive3 %>%
  mutate(Empl345 = ifelse(Empl3 == 1 & Empl4 == 1 & Empl5 == 1, 1, 0)) 

table(sustainmentinactive5$Empl345)





######### Limit data to those who were on Other benefits and unemployed in wave 1 and employed in wave 2. 

employedother3 <- filter(datacomplete, Empl1 == 0, Otherbenefits1 == 1, Empl2 == 1)

table(employedother3$Empl2)

#######From this population, find mean of employment in wave 3, 4 and 5 <---% of people still in work who found a job in wave 2. 

sustainmentother3 <- employedother3 %>%
  summarise(wave3 = weighted.mean(Empl3, w = LGWT))

table(employedother3$Empl3)

######### Limit data to those who are on Other benefits and unemployed in wave 1 and employed in wave 2 and wave 3. 
#######From this population, find mean of employment in wave 4

sustainmentother4 <- employedother3 %>%
  mutate(Empl34 = ifelse(Empl3 == 1 & Empl4 == 1, 1, 0)) 
  
table(sustainmentother4$Empl34)

######### Limit data to those who are on Other benefits and unemployed in wave 1 and employed in wave 2, wave 3 and wave 4.           
#######From this population, find mean of employment in wave 5            
sustainmentother5 <- employedother3 %>%
  mutate(Empl345 = ifelse(Empl3 == 1 & Empl4 == 1 & Empl5 == 1, 1, 0)) 
  
table(sustainmentother5$Empl345)


######### Limit data to those who were on no benefits and unemployed in wave 1 and employed in wave 2. 

employedno3 <- filter(datacomplete, Empl1 == 0, nobenefits1 == 1, Empl2 == 1)

table(employedno3$Empl2)

#######From this population, find mean of employment in wave 3, 4 and 5 <---% of people still in work who found a job in wave 2. 

sustainmentno3 <- employedno3 %>%
  summarise(wave3 = weighted.mean(Empl3, w = LGWT))

table(employedno3$Empl3)

######### Limit data to those who are on no benefits and unemployed in wave 1 and employed in wave 2 and wave 3. 
#######From this population, find mean of employment in wave 4

sustainmentno4 <- employedno3 %>%
  mutate(Empl34 = ifelse(Empl3 == 1 & Empl4 == 1, 1, 0)) 
  
table(sustainmentno4$Empl34)

######### Limit data to those who are on no benefits and unemployment in wave 1 and employed in wave 2, wave 3 and wave 4.           
#######From this population, find mean of employment in wave 5            
sustainmentno5 <- employedno3 %>%
  mutate(Empl345 = ifelse(Empl3 == 1 & Empl4 == 1 & Empl5 == 1, 1, 0)) 
  
table(sustainmentno5$Empl345)