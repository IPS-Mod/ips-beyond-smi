### This file reads in longitudinal data (originally `data20` to `data32`)
### (this data doesn't have health condition in it)


library(data.table)
library(tidyverse)
library(dplyr)

input_data <- c("lgwt22_5q_jm19_jm20_eul.tab", # data20
                "lgwt22_5q_aj19_aj20_eul.tab", # data21
                "lgwt22_5q_js19_js20_eul.tab", # data22
                "lgwt22_5q_od19_od20_eul.tab", # data23
                "lgwt22_5q_jm20_jm21_eul.tab", # data24
                "lgwt22_5q_aj20_aj21_eul.tab", # data25
                "lgwt22_5q_js20_js21_eul.tab", # data26
                "lgwt22_5q_od20_od21_eul.tab", # data27
                "lgwt22_5q_jm21_jm22_eul.tab",
                "lgwt22_5q_aj21_aj22_eul.tab",
                "lgwt22_5q_js21_js22_eul.tab",
                "lgwt22_5q_od21_od22_eul.tab",
                "lgwt22_5q_jm22_jm23_eul.tab") 

for (i in 1:length(input_data)){
  
  print(i)
  
  
  input <- paste0("data/labour_force_survey/",input_data[i] )
  
  data20 <- data.table::fread(input = input, na.strings = c("-9","-8")) 
  names(data20) <- toupper(names(data20))
  data20 <- data20 %>% select(PERSID, LGWT22, WEEK, CONMON1, 
                              INCAC051, CONMPY1, AGE1, SCHM121, OOBEN1, GRSSWK1, TTUSHR1, WNEFT111, 
                              INCAC052, CONMON2, AGE2, SCHM122, OOBEN2, GRSSWK2, TTUSHR2, WNEFT112, 
                              INCAC053, CONMON3, AGE3, SCHM123, OOBEN3, GRSSWK3, TTUSHR3, WNEFT113,
                              INCAC054, CONMON4, AGE4, SCHM124, OOBEN4, GRSSWK4, TTUSHR4, WNEFT114,
                              INCAC055, CONMON5, AGE5, SCHM125, OOBEN5, GRSSWK5, TTUSHR5, WNEFT115)  
  
  data20 <- data20 %>% rename_at('LGWT22', ~'LGWT')
  
  ################# Wave 1 ################
  
  #Limit Age group to 16-64 as this is working age population. 
  
  data20 <- subset(data20, AGE1<65 & AGE1>15)
  
  #Remove those in Employment Programme from data
  
  data20 <- filter(data20, SCHM121 == 66 | SCHM121 == 97)
  
  #set values of 1 to 4 in 'INCAC051' to 1 as this is a dummy variable for being employed and values of 1 meet this condition. 
  #set values of 5 to 34 in 'INCAC051' to 1 as this is a dummy variable for being employed and values of 1 meet this condition. 
  
  data20 <- data20 %>%
    mutate(Empl1 = ifelse(INCAC051 %in% 1:4, 1, 0))
  
  #set values of 1 in 'OOBEN1' to 1 as this is a dummy variable for receiving Unemp Benefits and values of 1 meet this condition. 
  
  data20 <- data20 %>%
    mutate(Unempbenefits1 = ifelse(OOBEN1 %in% 1:1, 1, 0),
           Unempbenefits1 = ifelse(is.na(OOBEN1), NA, Unempbenefits1))
  
  #set values of 2 in 'OOBEN1' to 1 as this is a dummy variable for receiving Sick Benefits and values of 1 meet this condition. 
  
  data20 <- data20 %>%
    mutate(Sickbenefits1 = ifelse(OOBEN1 %in% 2:2, 1, 0))
  
  
  #set values of 3 to 5 in 'OOBEN1' to 1 as this is a dummy variable for receiving Inact benefits and values of 1 meet this condition.
  
  data20 <- data20 %>%
    mutate(Inactbenefits1 = ifelse(OOBEN1 %in% 3:5, 1, 0))
  
  
  #set values of 6 in 'OOBEN1' to 1 as this is a dummy variable for receiving Other Benefits and values of 1 meet this condition.
  
  data20 <- data20 %>%
    mutate(Otherbenefits1 = ifelse(OOBEN1 %in% 6:6, 1, 0))
  
  
  #set values of 7 in 'OOBEN1' to 1 as this is a dummy variable for receiving no Benefits and values of 1 meet this condition.
  
  data20 <- data20 %>%
    mutate(nobenefits1 = ifelse(OOBEN1 %in% 7:7, 1, 0))
  
  
  
  
  #Drop INCAC051 and OOBEN1
  
  data20 <- subset(data20, select = -c(INCAC051, OOBEN1))
  
  
  ################# Wave 2 #################
  
  #Limit Age group to 16-64 as this is working age population. 
  
  data20 <- subset(data20, AGE2<65 & AGE2>15)
  
  #Remove those in Employment Programme from data
  
  data20 <- filter(data20, SCHM122 == 66 | SCHM122 == 97)
  
  
  #set values of 1 to 4 in 'INCAC052' to 1 as this is a dummy variable for being employed and values of 1 meet this condition. 
  #set values of 5 to 34 in 'INCAC052' to 1 as this is a dummy variable for being employed and values of 1 meet this condition. 
  
  data20 <- data20 %>%
    mutate(Empl2 = ifelse(INCAC052 %in% 1:4, 1, 0))
  
  
  
  #set values of 1 in 'OOBEN2' to 1 as this is a dummy variable for receiving Unemp Benefits and values of 1 meet this condition. 
  
  data20 <- data20 %>%
    mutate(Unempbenefits2 = ifelse(OOBEN2 %in% 1:1, 1, 0),
           Unempbenefits2 = ifelse(is.na(OOBEN2), NA, Unempbenefits2))
  
  #set values of 2 in 'OOBEN2' to 1 as this is a dummy variable for receiving Sick Benefits and values of 1 meet this condition. 
  
  data20 <- data20 %>%
    mutate(Sickbenefits2 = ifelse(OOBEN2 %in% 2:2, 1, 0))
  
  
  #set values of 3 to 5 in 'OOBEN2' to 1 as this is a dummy variable for receiving Inact benefits and values of 1 meet this condition.
  
  data20 <- data20 %>%
    mutate(Inactbenefits2 = ifelse(OOBEN2 %in% 3:5, 1, 0))
  
  
  #set values of 6 in 'OOBEN2' to 1 as this is a dummy variable for receiving Other Benefits and values of 1 meet this condition.
  
  data20 <- data20 %>%
    mutate(Otherbenefits2 = ifelse(OOBEN2 %in% 6:6, 1, 0))
  
  
  #set values of 7 in 'OOBEN2' to 1 as this is a dummy variable for receiving no Benefits and values of 1 meet this condition.
  
  data20 <- data20 %>%
    mutate(nobenefits2 = ifelse(OOBEN2 %in% 7:7, 1, 0))
  
  
  #Drop INCAC052 and OOBEN2
  
  data20 <- subset(data20, select = -c(INCAC052, OOBEN2))
  
  
  
  ################# Wave 3 #################
  
  #Limit Age group to 16-64 as this is working age population. 
  
  data20 <- subset(data20, AGE3<65 & AGE3>15)
  
  #Remove those in Employment Programme from data
  
  data20 <- filter(data20, SCHM123 == 66 | SCHM123 == 97)
  
  
  #set values of 1 to 4 in 'INCAC053' to 1 as this is a dummy variable for being employed and values of 1 meet this condition. 
  #set values of 5 to 34 in 'INCAC053' to 1 as this is a dummy variable for being employed and values of 1 meet this condition. 
  
  data20 <- data20 %>%
    mutate(Empl3 = ifelse(INCAC053 %in% 1:4, 1, 0))
  
  
  
  #set values of 1 in 'OOBEN3' to 1 as this is a dummy variable for receiving Unemp benefits and values of 1 meet this condition. 
  
  data20 <- data20 %>%
    mutate(Unempbenefits3 = ifelse(OOBEN3 %in% 1:1, 1, 0),
           Unempbenefits3 = ifelse(is.na(OOBEN3), NA, Unempbenefits3))
  
  
  #set values of 2 in 'OOBEN3' to 1 as this is a dummy variable for receiving Sick Benefits and values of 1 meet this condition. 
  
  data20 <- data20 %>%
    mutate(Sickbenefits3 = ifelse(OOBEN3 %in% 2:2, 1, 0))
  
  
  #set values of 3 to 5 in 'OOBEN3' to 1 as this is a dummy variable for receiving Inact benefits and values of 1 meet this condition.
  
  data20 <- data20 %>%
    mutate(Inactbenefits3 = ifelse(OOBEN3 %in% 3:5, 1, 0))
  
  #set values of 6 in 'OOBEN3' to 1 as this is a dummy variable for receiving Other Benefits and values of 1 meet this condition.
  
  data20 <- data20 %>%
    mutate(Otherbenefits3 = ifelse(OOBEN3 %in% 6:6, 1, 0))
  
  
  #set values of 7 in 'OOBEN3' to 1 as this is a dummy variable for receiving no Benefits and values of 1 meet this condition.
  
  data20 <- data20 %>%
    mutate(nobenefits3 = ifelse(OOBEN3 %in% 7:7, 1, 0))
  
  
  
  #Drop INCAC053 and OOBEN3
  
  data20 <- subset(data20, select = -c(INCAC053, OOBEN3))
  
  
  ################# Wave 4 #################
  
  #Limit Age group to 16-64 as this is working age population. 
  
  data20 <- subset(data20, AGE4<65 & AGE4>15)
  
  #Remove those in Employment Programme from data
  
  data20 <- filter(data20, SCHM124 == 66 | SCHM124 == 97)
  
  #set values of 1 to 4 in 'INCAC054' to 1 as this is a dummy variable for being employed and values of 1 meet this condition. 
  #set values of 5 to 44 in 'INCAC054' to 1 as this is a dummy variable for being employed and values of 1 meet this condition. 
  
  data20 <- data20 %>%
    mutate(Empl4 = ifelse(INCAC054 %in% 1:4, 1, 0))
  
  
  
  #set values of 1 in 'OOBEN4' to 1 as this is a dummy variable for receiving Unemp benefits and values of 1 meet this condition. 
  
  data20 <- data20 %>%
    mutate(Unempbenefits4 = ifelse(OOBEN4 %in% 1:1, 1, 0),
           Unempbenefits4 = ifelse(is.na(OOBEN4), NA, Unempbenefits4))
  
  #set values of 2 in 'OOBEN4' to 1 as this is a dummy variable for receiving Sick Benefits and values of 1 meet this condition. 
  
  data20 <- data20 %>%
    mutate(Sickbenefits4 = ifelse(OOBEN4 %in% 2:2, 1, 0))
  
  
  #set values of 3 to 5 in 'OOBEN4' to 1 as this is a dummy variable for receiving Inact benefits and values of 1 meet this condition.
  
  data20 <- data20 %>%
    mutate(Inactbenefits4 = ifelse(OOBEN4 %in% 3:5, 1, 0))
  
  
  #set values of 6 in 'OOBEN4' to 1 as this is a dummy variable for receiving Other Benefits and values of 1 meet this condition.
  data20 <- data20 %>%
    mutate(Otherbenefits4 = ifelse(OOBEN4 %in% 6:6, 1, 0))
  
  
  #set values of 7 in 'OOBEN4' to 1 as this is a dummy variable for receiving no Benefits and values of 1 meet this condition.
  data20 <- data20 %>%
    mutate(nobenefits4 = ifelse(OOBEN4 %in% 7:7, 1, 0))
  
  
  
  #Drop INCAC054 and OOBEN4
  
  data20 <- subset(data20, select = -c(INCAC054, OOBEN4))
  
  
  ################# Wave 5 #################
  
  #Limit Age group to 16-64 as this is working age population. 
  
  data20 <- subset(data20, AGE5<65 & AGE5>15)
  
  #Remove those in Employment Programme from data 
  
  data20 <- filter(data20, SCHM125 == 66 | SCHM125 == 97)
  
  #set values of 1 to 4 in 'INCAC055' to 1 as this is a dummy variable for being employed and values of 1 meet this condition. 
  #set values of 5 to 54 in 'INCAC055' to 1 as this is a dummy variable for being employed and values of 1 meet this condition. 
  
  data20 <- data20 %>%
    mutate(Empl5 = ifelse(INCAC055 %in% 1:4, 1, 0))
  
  
  #set values of 1 in 'OOBEN5' to 1 as this is a dummy variable for receiving Unemp Benefits and values of 1 meet this condition. 
  
  data20 <- data20 %>%
    mutate(Unempbenefits5 = ifelse(OOBEN5 %in% 1:1, 1, 0),
           Unempbenefits5 = ifelse(is.na(OOBEN5), NA, Unempbenefits5))
  
  #set values of 2 in 'OOBEN5' to 1 as this is a dummy variable for receiving Sick Benefits and values of 1 meet this condition. 
  
  data20 <- data20 %>%
    mutate(Sickbenefits5 = ifelse(OOBEN5 %in% 2:2, 1, 0))
  
  
  #set values of 3 to 5 in 'OOBEN5' to 1 as this is a dummy variable for receiving Inact benefits and values of 1 meet this condition.
  
  data20 <- data20 %>%
    mutate(Inactbenefits5 = ifelse(OOBEN5 %in% 3:5, 1, 0))
  
  
  #set values of 6 in 'OOBEN1' to 1 as this is a dummy variable for receiving Other Benefits and values of 1 meet this condition.
  data20 <- data20 %>%
    mutate(Otherbenefits5 = ifelse(OOBEN5 %in% 6:6, 1, 0))
  
  
  #set values of 7 in 'OOBEN1' to 1 as this is a dummy variable for receiving no Benefits and values of 1 meet this condition.
  data20 <- data20 %>%
    mutate(nobenefits5 = ifelse(OOBEN5 %in% 7:7, 1, 0))
  
  
  #Drop INCAC055 and OOBEN5
  
  data20 <- subset(data20, select = -c(INCAC055, OOBEN5))
  
  
  ####################Add in Week Variables##############################
  
  #Add in WEEK variable
  data20$MONTHw1 = data20$WEEK
  data20$MONTHw2 = data20$WEEK
  data20$MONTHw3 = data20$WEEK
  data20$MONTHw4 = data20$WEEK
  data20$MONTHw5 = data20$WEEK
  
  #Recode WEEK variable into months
  
  data20$MONTHw1[data20$MONTHw1 %in% 1:4] <- 1
  data20$MONTHw1[data20$MONTHw1 %in% 5:8] <- 2
  data20$MONTHw1[data20$MONTHw1 %in% 9:13] <- 3
  
  data20$MONTHw2[data20$MONTHw2 %in% 1:4] <- 4
  data20$MONTHw2[data20$MONTHw2 %in% 5:8] <- 5
  data20$MONTHw2[data20$MONTHw2 %in% 9:13] <- 6
  
  data20$MONTHw3[data20$MONTHw3 %in% 9:13] <- 9
  data20$MONTHw3[data20$MONTHw3 %in% 5:8] <- 8
  data20$MONTHw3[data20$MONTHw3 %in% 1:4] <- 7
  
  data20$MONTHw4[data20$MONTHw4 %in% 9:13] <- 12
  data20$MONTHw4[data20$MONTHw4 %in% 5:8] <- 11
  data20$MONTHw4[data20$MONTHw4 %in% 1:4] <- 10
  
  data20$MONTHw5[data20$MONTHw5 %in% 9:13] <- 15
  data20$MONTHw5[data20$MONTHw5 %in% 5:8] <- 14
  data20$MONTHw5[data20$MONTHw5 %in% 1:4] <- 13
  
  ####Have CONMON so month at start of wave 1 = 1 (January)
  
  
  
  ######Adjusting CONMON5 to refer to the correct month
  
  data20 <- data20 %>% mutate(CONMON5 = ifelse(MONTHw5 == 14 & CONMON5 == 1, 13, CONMON5))
  
  data20 <- data20 %>% mutate(CONMON5 = ifelse(MONTHw5 == 15 & CONMON5 == 1, 13, CONMON5))
  
  data20 <- data20 %>% mutate(CONMON5 = ifelse(MONTHw5 == 15 & CONMON5 == 2, 14, CONMON5))
  
  data20 <- data20 %>% mutate(CONMON5 = ifelse(MONTHw5 == 13 & CONMON5 == 1 & Empl4 == 0, 13, CONMON5))
  
  data20 <- data20 %>% mutate(CONMON5 = ifelse(MONTHw5 == 14 & CONMON5 == 2 & Empl4 == 0, 14, CONMON5))
  
  data20 <- data20 %>% mutate(CONMON5 = ifelse(MONTHw5 == 15 & CONMON5 == 3 & Empl4 == 0, 15, CONMON5))
  
  
  #Set values of 1 in 'WNEFT115' to 1 (otherwise 0), as this is a dummy variable for every having worked in that wave. 
  
  data20 <- data20 %>%
    mutate(everworkedw1 = ifelse(WNEFT111 %in% 1:1, 1, 0))
  
  data20 <- data20 %>%
    mutate(everworkedw2 = ifelse(WNEFT112 %in% 1:1, 1, 0))
  
  data20 <- data20 %>%
    mutate(everworkedw3 = ifelse(WNEFT113 %in% 1:1, 1, 0))
  
  data20 <- data20 %>%
    mutate(everworkedw4 = ifelse(WNEFT114 %in% 1:1, 1, 0))
  
  data20 <- data20 %>%
    mutate(everworkedw5 = ifelse(WNEFT115 %in% 1:1, 1, 0))
  
  #########Reordering##########
  
  data20 <- data20 %>% select(PERSID, LGWT, CONMPY1, WNEFT111, 
                              AGE1, SCHM121, Empl1, CONMON1, MONTHw1, Unempbenefits1, Sickbenefits1, Inactbenefits1, Otherbenefits1, nobenefits1, TTUSHR1, GRSSWK1, everworkedw1, 
                              AGE2, SCHM122, Empl2, CONMON2, MONTHw2, Unempbenefits2, Sickbenefits2, Inactbenefits2, Otherbenefits2, nobenefits2, TTUSHR2, GRSSWK2, everworkedw2, 
                              AGE3, SCHM123, Empl3, CONMON3, MONTHw3, Unempbenefits3, Sickbenefits3, Inactbenefits3, Otherbenefits3, nobenefits3, TTUSHR3, GRSSWK3, everworkedw3, 
                              AGE4, SCHM124, Empl4, CONMON4, MONTHw4, Unempbenefits4, Sickbenefits4, Inactbenefits4, Otherbenefits4, nobenefits4, TTUSHR4, GRSSWK4, everworkedw4, 
                              AGE5, SCHM125, Empl5, CONMON5, MONTHw5, Unempbenefits5, Sickbenefits5, Inactbenefits5, Otherbenefits5, nobenefits5, TTUSHR5, GRSSWK5, everworkedw5)
  
  if (i == 1){
    final_data_2 <- copy(data20)
  } else {
    final_data_2 <- rbindlist(list(final_data_2, data20))
  }
  
}