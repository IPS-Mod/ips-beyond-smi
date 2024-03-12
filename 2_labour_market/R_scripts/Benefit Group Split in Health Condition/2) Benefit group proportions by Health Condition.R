group <- health_condition_data 

#Filter to Specific Health Condition at wave 1 (MSK1, MH1 or MSK_MH1)

group <- filter(group, MSK_MH1 == 1)


group <- group %>% select(PERSID, LGWT, Unempbenefits1, Sickbenefits1, Inactbenefits1, Otherbenefits1, nobenefits1)

group <- group %>% drop_na(Unempbenefits1) 

group <- group %>% drop_na(Sickbenefits1) 

group <- group %>% drop_na(Inactbenefits1) 
  
group <- group %>% drop_na(Otherbenefits1) 
  
group <- group %>% drop_na(nobenefits1) 
  

unemp <- group %>% summarise(unemp = weighted.mean(Unempbenefits1, w = LGWT))

sick <- group %>% summarise(sick = weighted.mean(Sickbenefits1, w = LGWT))

Inact <- group %>% summarise(Inact = weighted.mean(Inactbenefits1, w = LGWT))

Other <- group %>% summarise(Other = weighted.mean(Otherbenefits1, w = LGWT))

No <- group %>% summarise(No = weighted.mean(nobenefits1, w = LGWT))