### This file reads in longitudinal data (originally `data4` to `data16`)
### (this data has health condition in it)

library(data.table)
library(tidyverse)
library(dplyr)

input_data <- c("five_q_longitudinal_aj12-aj13_eul_lgwt17.tab", 
                "five_q_longitudinal_js12-js13_eul_lgwt17.tab", 
                "five_q_longitudinal_od12-od13_eul_lgwt17.tab",
                "five_q_longitudinal_jm13-jm14_eul_lgwt17.tab", 
                "five_q_longitudinal_aj13-aj14_eul_lgwt17.tab", 
                "five_q_longitudinal_js13-js14_eul_lgwt17.tab", 
                "five_q_longitudinal_od13-od14_eul_lgwt17.tab",
                "five_q_longitudinal_jm14-jm15_eul_lgwt17.tab", 
                "five_q_longitudinal_aj14-aj15_eul_lgwt17.tab", 
                "five_q_longitudinal_js14-js15_eul_lgwt17.tab", 
                "five_q_longitudinal_od14-od15_eul_lgwt17.tab") 

for (i in 1:length(input_data)){
  
  print(i)
  
  input <- paste0("data/labour_force_survey/",input_data[i])
  
  
  data4 <- data.table::fread(input = input, na.strings = c("-9","-8")) 
  

  if (!(i %in% 2:3)){
    data4 <- data4 %>% rename_at('lgwt17', ~'LGWT')
  } else {
    data4 <- data4 %>% rename_at('LGWT17', ~'LGWT')
  }

    data4 <- data4 %>% select(PERSID, LGWT, CONMPY1, WEEK, 
                              INCAC051, CONMON1, AGE1, SCHM121, GRSSWK1, TTUSHR1, WNEFT111, HEAL011, HEAL021, HEAL031,
                              INCAC052, CONMON2, AGE2, SCHM122, GRSSWK2, TTUSHR2, WNEFT112, HEAL012, HEAL022, HEAL032, 
                              INCAC053, CONMON3, AGE3, SCHM123, GRSSWK3, TTUSHR3, WNEFT113, HEAL013, HEAL023, HEAL033,
                              INCAC054, CONMON4, AGE4, SCHM124, GRSSWK4, TTUSHR4, WNEFT114, HEAL014, HEAL024, HEAL034,
                              INCAC055, CONMON5, AGE5, SCHM125, GRSSWK5, TTUSHR5, WNEFT115, HEAL015, HEAL025, HEAL035)  
  
  ################# Wave 1 ################
  
  #Limit Age group to 16-64 as this is working age population. 
  
  data4 <- subset(data4, AGE1<65 & AGE1>15)
  
  #Remove those in Employment Programme from data
  
  data4 <- filter(data4, SCHM121 == 66 | SCHM121 == 97)
  
  #set values of 1 to 4 in 'INCAC051' to 1 as this is a dummy variable for being employed and values of 1 meet this condition. 
  #set values of 5 to 34 in 'INCAC051' to 1 as this is a dummy variable for being employed and values of 1 meet this condition. 
  
  data4 <- data4 %>%
    mutate(Empl1 = ifelse(INCAC051 %in% 1:4, 1, 0))
  
  #set values of 1 in 'OOBEN1' to 1 as this is a dummy variable for receiving Unemp Benefits and values of 1 meet this condition. 
  
  #data4 <- data4 %>%
  #  mutate(Unempbenefits1 = ifelse(OOBEN1 %in% 1:1, 1, 0),
   #        Unempbenefits1 = ifelse(is.na(OOBEN1), NA, Unempbenefits1))
  
  #set values of 2 in 'OOBEN1' to 1 as this is a dummy variable for receiving Sick Benefits and values of 1 meet this condition. 
  
 # data4 <- data4 %>%
  #  mutate(Sickbenefits1 = ifelse(OOBEN1 %in% 2:2, 1, 0))
  
  
  #set values of 3 to 5 in 'OOBEN1' to 1 as this is a dummy variable for receiving Inact benefits and values of 1 meet this condition.
  
  #data4 <- data4 %>%
  #  mutate(Inactbenefits1 = ifelse(OOBEN1 %in% 3:5, 1, 0))
  
  
  #set values of 6 in 'OOBEN1' to 1 as this is a dummy variable for receiving Other Benefits and values of 1 meet this condition.
  
  #data4 <- data4 %>%
  #  mutate(Otherbenefits1 = ifelse(OOBEN1 %in% 6:6, 1, 0))
  
  
  #set values of 7 in 'OOBEN1' to 1 as this is a dummy variable for receiving no Benefits and values of 1 meet this condition.
  
  #data4 <- data4 %>%
   # mutate(nobenefits1 = ifelse(OOBEN1 %in% 7:7, 1, 0))
  
  
  
  
  #Drop INCAC051 and OOBEN1
  
  data4 <- subset(data4, select = -c(INCAC051))
  
  
  ################# Wave 2 #################
  
  #Limit Age group to 16-64 as this is working age population. 
  
  data4 <- subset(data4, AGE2<65 & AGE2>15)
  
  #Remove those in Employment Programme from data
  
  data4 <- filter(data4, SCHM122 == 66 | SCHM122 == 97)
  
  
  #set values of 1 to 4 in 'INCAC052' to 1 as this is a dummy variable for being employed and values of 1 meet this condition. 
  #set values of 5 to 34 in 'INCAC052' to 1 as this is a dummy variable for being employed and values of 1 meet this condition. 
  
  data4 <- data4 %>%
    mutate(Empl2 = ifelse(INCAC052 %in% 1:4, 1, 0))
  
  
  
  #set values of 1 in 'OOBEN2' to 1 as this is a dummy variable for receiving Unemp Benefits and values of 1 meet this condition. 
  
 # data4 <- data4 %>%
  #  mutate(Unempbenefits2 = ifelse(OOBEN2 %in% 1:1, 1, 0),
  #         Unempbenefits2 = ifelse(is.na(OOBEN2), NA, Unempbenefits2))
  
  #set values of 2 in 'OOBEN2' to 1 as this is a dummy variable for receiving Sick Benefits and values of 1 meet this condition. 
  
 # data4 <- data4 %>%
  #  mutate(Sickbenefits2 = ifelse(OOBEN2 %in% 2:2, 1, 0))
  
  
  #set values of 3 to 5 in 'OOBEN2' to 1 as this is a dummy variable for receiving Inact benefits and values of 1 meet this condition.
  
  #data4 <- data4 %>%
  #  mutate(Inactbenefits2 = ifelse(OOBEN2 %in% 3:5, 1, 0))
  
  
  #set values of 6 in 'OOBEN2' to 1 as this is a dummy variable for receiving Other Benefits and values of 1 meet this condition.
  
  #data4 <- data4 %>%
   # mutate(Otherbenefits2 = ifelse(OOBEN2 %in% 6:6, 1, 0))
  
  
  #set values of 7 in 'OOBEN2' to 1 as this is a dummy variable for receiving no Benefits and values of 1 meet this condition.
  
  #data4 <- data4 %>%
   # mutate(nobenefits2 = ifelse(OOBEN2 %in% 7:7, 1, 0))
  
  
  #Drop INCAC052 and OOBEN2
  
  data4 <- subset(data4, select = -c(INCAC052))
  
  
  
  ################# Wave 3 #################
  
  #Limit Age group to 16-64 as this is working age population. 
  
  data4 <- subset(data4, AGE3<65 & AGE3>15)
  
  #Remove those in Employment Programme from data
  
  data4 <- filter(data4, SCHM123 == 66 | SCHM123 == 97)
  
  
  #set values of 1 to 4 in 'INCAC053' to 1 as this is a dummy variable for being employed and values of 1 meet this condition. 
  #set values of 5 to 34 in 'INCAC053' to 1 as this is a dummy variable for being employed and values of 1 meet this condition. 
  
  data4 <- data4 %>%
    mutate(Empl3 = ifelse(INCAC053 %in% 1:4, 1, 0))
  
  
  
  #set values of 1 in 'OOBEN3' to 1 as this is a dummy variable for receiving Unemp benefits and values of 1 meet this condition. 
  
  #data4 <- data4 %>%
  #  mutate(Unempbenefits3 = ifelse(OOBEN3 %in% 1:1, 1, 0),
   #        Unempbenefits3 = ifelse(is.na(OOBEN3), NA, Unempbenefits3))
  
  
  #set values of 2 in 'OOBEN3' to 1 as this is a dummy variable for receiving Sick Benefits and values of 1 meet this condition. 
  
  #data4 <- data4 %>%
   # mutate(Sickbenefits3 = ifelse(OOBEN3 %in% 2:2, 1, 0))
  
  
  #set values of 3 to 5 in 'OOBEN3' to 1 as this is a dummy variable for receiving Inact benefits and values of 1 meet this condition.
  
 # data4 <- data4 %>%
   # mutate(Inactbenefits3 = ifelse(OOBEN3 %in% 3:5, 1, 0))
  
  #set values of 6 in 'OOBEN3' to 1 as this is a dummy variable for receiving Other Benefits and values of 1 meet this condition.
  
  #data4 <- data4 %>%
   # mutate(Otherbenefits3 = ifelse(OOBEN3 %in% 6:6, 1, 0))
  
  
  #set values of 7 in 'OOBEN3' to 1 as this is a dummy variable for receiving no Benefits and values of 1 meet this condition.
  
  #data4 <- data4 %>%
   # mutate(nobenefits3 = ifelse(OOBEN3 %in% 7:7, 1, 0))
  
  
  
  #Drop INCAC053 and OOBEN3
  
  data4 <- subset(data4, select = -c(INCAC053))
  
  
  ################# Wave 4 #################
  
  #Limit Age group to 16-64 as this is working age population. 
  
  data4 <- subset(data4, AGE4<65 & AGE4>15)
  
  #Remove those in Employment Programme from data
  
  data4 <- filter(data4, SCHM124 == 66 | SCHM124 == 97)
  
  #set values of 1 to 4 in 'INCAC054' to 1 as this is a dummy variable for being employed and values of 1 meet this condition. 
  #set values of 5 to 44 in 'INCAC054' to 1 as this is a dummy variable for being employed and values of 1 meet this condition. 
  
  data4 <- data4 %>%
    mutate(Empl4 = ifelse(INCAC054 %in% 1:4, 1, 0))
  
  
  
  #set values of 1 in 'OOBEN4' to 1 as this is a dummy variable for receiving Unemp benefits and values of 1 meet this condition. 
  
  #data4 <- data4 %>%
   # mutate(Unempbenefits4 = ifelse(OOBEN4 %in% 1:1, 1, 0),
   #        Unempbenefits4 = ifelse(is.na(OOBEN4), NA, Unempbenefits4))
  
  #set values of 2 in 'OOBEN4' to 1 as this is a dummy variable for receiving Sick Benefits and values of 1 meet this condition. 
  
  #data4 <- data4 %>%
  #  mutate(Sickbenefits4 = ifelse(OOBEN4 %in% 2:2, 1, 0))
  
  
  #set values of 3 to 5 in 'OOBEN4' to 1 as this is a dummy variable for receiving Inact benefits and values of 1 meet this condition.
  
  #data4 <- data4 %>%
  #  mutate(Inactbenefits4 = ifelse(OOBEN4 %in% 3:5, 1, 0))
  
  
  #set values of 6 in 'OOBEN4' to 1 as this is a dummy variable for receiving Other Benefits and values of 1 meet this condition.
  #data4 <- data4 %>%
  # mutate(Otherbenefits4 = ifelse(OOBEN4 %in% 6:6, 1, 0))
  
  
  #set values of 7 in 'OOBEN4' to 1 as this is a dummy variable for receiving no Benefits and values of 1 meet this condition.
  #data4 <- data4 %>%
   # mutate(nobenefits4 = ifelse(OOBEN4 %in% 7:7, 1, 0))
  
  
  
  #Drop INCAC054 and OOBEN4
  
  data4 <- subset(data4, select = -c(INCAC054))
  
  
  ################# Wave 5 #################
  
  #Limit Age group to 16-64 as this is working age population. 
  
  data4 <- subset(data4, AGE5<65 & AGE5>15)
  
  #Remove those in Employment Programme from data 
  
  data4 <- filter(data4, SCHM125 == 66 | SCHM125 == 97)
  
  #set values of 1 to 4 in 'INCAC055' to 1 as this is a dummy variable for being employed and values of 1 meet this condition. 
  #set values of 5 to 54 in 'INCAC055' to 1 as this is a dummy variable for being employed and values of 1 meet this condition. 
  
  data4 <- data4 %>%
    mutate(Empl5 = ifelse(INCAC055 %in% 1:4, 1, 0))
  
  
  #set values of 1 in 'OOBEN5' to 1 as this is a dummy variable for receiving Unemp Benefits and values of 1 meet this condition. 
  
  #data4 <- data4 %>%
   # mutate(Unempbenefits5 = ifelse(OOBEN5 %in% 1:1, 1, 0),
   #        Unempbenefits5 = ifelse(is.na(OOBEN5), NA, Unempbenefits5))
  
  #set values of 2 in 'OOBEN5' to 1 as this is a dummy variable for receiving Sick Benefits and values of 1 meet this condition. 
  
 # data4 <- data4 %>%
  #  mutate(Sickbenefits5 = ifelse(OOBEN5 %in% 2:2, 1, 0))
  
  
  #set values of 3 to 5 in 'OOBEN5' to 1 as this is a dummy variable for receiving Inact benefits and values of 1 meet this condition.
  
 # data4 <- data4 %>%
  #  mutate(Inactbenefits5 = ifelse(OOBEN5 %in% 3:5, 1, 0))
  
  
  #set values of 6 in 'OOBEN1' to 1 as this is a dummy variable for receiving Other Benefits and values of 1 meet this condition.
  #data4 <- data4 %>%
   # mutate(Otherbenefits5 = ifelse(OOBEN5 %in% 6:6, 1, 0))
  
  
  #set values of 7 in 'OOBEN1' to 1 as this is a dummy variable for receiving no Benefits and values of 1 meet this condition.
  #data4 <- data4 %>%
   # mutate(nobenefits5 = ifelse(OOBEN5 %in% 7:7, 1, 0))
  
  
  #Drop INCAC055 and OOBEN5
  
  data4 <- subset(data4, select = -c(INCAC055))
  
  
  ####################Add in Week Variables##############################
  
  #Add in WEEK variable
  data4$MONTHw1 = data4$WEEK
  data4$MONTHw2 = data4$WEEK
  data4$MONTHw3 = data4$WEEK
  data4$MONTHw4 = data4$WEEK
  data4$MONTHw5 = data4$WEEK
  
  #Recode WEEK variable into months
  
  data4$MONTHw1[data4$MONTHw1 %in% 1:4] <- 1
  data4$MONTHw1[data4$MONTHw1 %in% 5:8] <- 2
  data4$MONTHw1[data4$MONTHw1 %in% 9:13] <- 3
  
  data4$MONTHw2[data4$MONTHw2 %in% 1:4] <- 4
  data4$MONTHw2[data4$MONTHw2 %in% 5:8] <- 5
  data4$MONTHw2[data4$MONTHw2 %in% 9:13] <- 6
  
  data4$MONTHw3[data4$MONTHw3 %in% 9:13] <- 9
  data4$MONTHw3[data4$MONTHw3 %in% 5:8] <- 8
  data4$MONTHw3[data4$MONTHw3 %in% 1:4] <- 7
  
  data4$MONTHw4[data4$MONTHw4 %in% 9:13] <- 12
  data4$MONTHw4[data4$MONTHw4 %in% 5:8] <- 11
  data4$MONTHw4[data4$MONTHw4 %in% 1:4] <- 10
  
  data4$MONTHw5[data4$MONTHw5 %in% 9:13] <- 15
  data4$MONTHw5[data4$MONTHw5 %in% 5:8] <- 14
  data4$MONTHw5[data4$MONTHw5 %in% 1:4] <- 13
  
  ####Have CONMON so month at start of wave 1 = 1 (January)
  
  
  ######Adjusting CONMON5 to refer to the correct month
  
  data4 <- data4 %>% mutate(CONMON5 = ifelse(MONTHw5 == 14 & CONMON5 == 1, 13, CONMON5))
  
  data4 <- data4 %>% mutate(CONMON5 = ifelse(MONTHw5 == 15 & CONMON5 == 1, 13, CONMON5))
  
  data4 <- data4 %>% mutate(CONMON5 = ifelse(MONTHw5 == 15 & CONMON5 == 2, 14, CONMON5))
  
  data4 <- data4 %>% mutate(CONMON5 = ifelse(MONTHw5 == 13 & CONMON5 == 1 & Empl4 == 0, 13, CONMON5))
  
  data4 <- data4 %>% mutate(CONMON5 = ifelse(MONTHw5 == 14 & CONMON5 == 2 & Empl4 == 0, 14, CONMON5))
  
  data4 <- data4 %>% mutate(CONMON5 = ifelse(MONTHw5 == 15 & CONMON5 == 3 & Empl4 == 0, 15, CONMON5))
  
  
  #Set values of 1 in 'WNEFT115' to 1 (otherwise 0), as this is a dummy variable for ever having worked in that wave. 
  
  data4 <- data4 %>%
    mutate(everworkedw1 = ifelse(WNEFT111 %in% 1:1, 1, 0))
  
  data4 <- data4 %>%
    mutate(everworkedw2 = ifelse(WNEFT112 %in% 1:1, 1, 0))
  
  data4 <- data4 %>%
    mutate(everworkedw3 = ifelse(WNEFT113 %in% 1:1, 1, 0))
  
  data4 <- data4 %>%
    mutate(everworkedw4 = ifelse(WNEFT114 %in% 1:1, 1, 0))
  
  data4 <- data4 %>%
    mutate(everworkedw5 = ifelse(WNEFT115 %in% 1:1, 1, 0))
  
  ##### Health condition (not for the 3rd dataset, variables are missing) ######
  

    data4 <- data4 %>%
      mutate(MSK1 = 0,
             MSK1 = ifelse(HEAL011 %in% 1:3 | HEAL021 %in% 1:3 | HEAL031 %in% 1:3, 1, MSK1),
             MSK2 = 0,
             MSK2 = ifelse(HEAL012 %in% 1:3 | HEAL022 %in% 1:3 | HEAL032 %in% 1:3, 1, MSK2),
             MSK3 = 0,
             MSK3 = ifelse(HEAL013 %in% 1:3 | HEAL023 %in% 1:3 | HEAL033 %in% 1:3, 1, MSK3),
             MSK4 = 0,
             MSK4 = ifelse(HEAL014 %in% 1:3 | HEAL024 %in% 1:3 | HEAL034 %in% 1:3, 1, MSK4),
             MSK5 = 0,
             MSK5 = ifelse(HEAL015 %in% 1:3 | HEAL025 %in% 1:3 | HEAL035 %in% 1:3, 1, MSK5))
    
    data4 <- data4 %>%
      mutate(MH1 = 0,
             MH1 = ifelse(HEAL011 %in% c(12,15) | HEAL021 %in% c(12,15) | HEAL031 %in% c(12,15), 1, MH1),
             MH2 = 0,
             MH2 = ifelse(HEAL012 %in% c(12,15) | HEAL022 %in% c(12,15) | HEAL032 %in% c(12,15), 1, MH2),
             MH3 = 0,
             MH3 = ifelse(HEAL013 %in% c(12,15) | HEAL023 %in% c(12,15) | HEAL033 %in% c(12,15), 1, MH3),
             MH4 = 0,
             MH4 = ifelse(HEAL014 %in% c(12,15) | HEAL024 %in% c(12,15) | HEAL034 %in% c(12,15), 1, MH4),
             MH5 = 0,
             MH5 = ifelse(HEAL015 %in% c(12,15) | HEAL025 %in% c(12,15) | HEAL035 %in% c(12,15), 1, MH5))
    
    data4 <- data4 %>%
      mutate(MSK_MH1 = 0,
             MSK_MH1 = ifelse(MSK1 == 1 & MH1, 1, MSK_MH1),
             MSK_MH2 = 0,
             MSK_MH2 = ifelse(MSK2 == 1 & MH2, 1, MSK_MH2),
             MSK_MH3 = 0,
             MSK_MH3 = ifelse(MSK3 == 1 & MH3, 1, MSK_MH3),
             MSK_MH4 = 0,
             MSK_MH4 = ifelse(MSK4 == 1 & MH4, 1, MSK_MH4),
             MSK_MH5 = 0,
             MSK_MH5 = ifelse(MSK5 == 1 & MH5, 1, MSK_MH5))
  
  #########Reordering##########
  
    data4 <- data4 %>% select(PERSID, LGWT, CONMPY1, WNEFT111, 
                              AGE1, SCHM121, Empl1, CONMON1, MONTHw1, TTUSHR1, GRSSWK1, everworkedw1, MSK1, MH1, MSK_MH1, 
                              AGE2, SCHM122, Empl2, CONMON2, MONTHw2, TTUSHR2, GRSSWK2, everworkedw2, MSK2, MH2, MSK_MH2, 
                              AGE3, SCHM123, Empl3, CONMON3, MONTHw3, TTUSHR3, GRSSWK3, everworkedw3, MSK3, MH3, MSK_MH3,
                              AGE4, SCHM124, Empl4, CONMON4, MONTHw4, TTUSHR4, GRSSWK4, everworkedw4, MSK4, MH4, MSK_MH4,
                              AGE5, SCHM125, Empl5, CONMON5, MONTHw5, TTUSHR5, GRSSWK5, everworkedw5, MSK5, MH5, MSK_MH5)

  
  if (i == 1){
    final_data_0 <- copy(data4)
  } else {
    final_data_0 <- rbindlist(list(final_data_0, data4), fill = TRUE)
  }
  
}