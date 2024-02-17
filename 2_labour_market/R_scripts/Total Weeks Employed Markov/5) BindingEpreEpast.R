
BindingEpreEpost <- datacomplete

##############finding employment when unemployed######################

#Wave 12

Wave12 <- filter(BindingEpreEpost, Empl1 == 0) 

Wave12 <- Wave12 %>% rename_at('Empl2', ~'BindingEpost') 

#Wave 23

Wave23 <- filter(BindingEpreEpost, Empl2 == 0) 

Wave23 <- Wave23 %>% rename_at('Empl3', ~'BindingEpost') 

#Wave 34

Wave34 <- filter(BindingEpreEpost, Empl3 == 0) 

Wave34 <- Wave34 %>% rename_at('Empl4', ~'BindingEpost') 

#Wave 45

Wave45 <- filter(BindingEpreEpost, Empl4 == 0) 

Wave45 <- Wave45 %>% rename_at('Empl5', ~'BindingEpost') 

#combine waves

BindingUEpost <- rbind(Wave12, Wave23, Wave34, Wave45, fill=TRUE)



##############staying in employment when employed######################

#Wave 12

Wave12 <- filter(BindingEpreEpost, Empl1 == 1) 

Wave12 <- Wave12 %>% rename_at('Empl2', ~'BindingEpost') 

#Wave 23

Wave23 <- filter(BindingEpreEpost, Empl2 == 1) 

Wave23 <- Wave23 %>% rename_at('Empl3', ~'BindingEpost') 

#Wave 34

Wave34 <- filter(BindingEpreEpost, Empl3 == 1) 

Wave34 <- Wave34 %>% rename_at('Empl4', ~'BindingEpost') 

#Wave 45

Wave45 <- filter(BindingEpreEpost, Empl4 == 1) 

Wave45 <- Wave45 %>% rename_at('Empl5', ~'BindingEpost') 

#combine waves

BindingEEpost <- rbind(Wave12, Wave23, Wave34, Wave45, fill=TRUE)

