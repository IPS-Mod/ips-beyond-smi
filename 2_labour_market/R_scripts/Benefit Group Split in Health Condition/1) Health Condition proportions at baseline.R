group <- health_condition_data %>% select(PERSID, LGWT, MSK1, MH1, MSK_MH1)

group <- group %>% drop_na(MSK1) 

group <- group %>% drop_na(MH1) 

group <- group %>% drop_na(MSK_MH1) 

  

MSK <- group %>% summarise(unemp = weighted.mean(MSK1, w = LGWT))

MH <- group %>% summarise(sick = weighted.mean(MH1, w = LGWT))

MSKMH <- group %>% summarise(Inact = weighted.mean(MSK_MH1, w = LGWT))

