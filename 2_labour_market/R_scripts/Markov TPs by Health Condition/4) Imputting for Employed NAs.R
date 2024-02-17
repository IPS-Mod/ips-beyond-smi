
#find average months worked at each wave for those employed for each health condition.

#MSK1 
#MH1 
#MSK_MH1 

#Wave 2

Wave2MSK <- filter(imputed, MSK1 == 1, Empl2 == 1) 
Wave2MSK <- Wave2MSK %>% drop_na(wave2months)
Wave2MSK <- Wave2MSK %>%
  summarise(MEAN = weighted.mean(wave2months, w = LGWT))

Wave2MH <- filter(imputed, MH1 == 1, Empl2 == 1)
Wave2MH <- Wave2MH %>% drop_na(wave2months)
Wave2MH <- Wave2MH %>%
  summarise(MEAN = weighted.mean(wave2months, w = LGWT))

Wave2MSK_MH <- filter(imputed, MSK_MH1 == 1, Empl2 == 1)
Wave2MSK_MH <- Wave2MSK_MH %>% drop_na(wave2months)
Wave2MSK_MH <- Wave2MSK_MH %>%
  summarise(MEAN = weighted.mean(wave2months, w = LGWT))


#Wave 3

Wave3MSK <- filter(imputed, MSK1 == 1, Empl3 == 1) 
Wave3MSK <- Wave3MSK %>% drop_na(wave3months)
Wave3MSK <- Wave3MSK %>%
  summarise(MEAN = weighted.mean(wave3months, w = LGWT))

Wave3MH <- filter(imputed, MH1 == 1, Empl3 == 1)
Wave3MH <- Wave3MH %>% drop_na(wave3months)
Wave3MH <- Wave3MH %>%
  summarise(MEAN = weighted.mean(wave3months, w = LGWT))

Wave3MSK_MH <- filter(imputed, MSK_MH1 == 1, Empl3 == 1)
Wave3MSK_MH <- Wave3MSK_MH %>% drop_na(wave3months)
Wave3MSK_MH <- Wave3MSK_MH %>%
  summarise(MEAN = weighted.mean(wave3months, w = LGWT))



#Wave 4

Wave4MSK <- filter(imputed, MSK1 == 1, Empl4 == 1) 
Wave4MSK <- Wave4MSK %>% drop_na(wave4months)
Wave4MSK <- Wave4MSK %>%
  summarise(MEAN = weighted.mean(wave4months, w = LGWT))

Wave4MH <- filter(imputed, MH1 == 1, Empl4 == 1)
Wave4MH <- Wave4MH %>% drop_na(wave4months)
Wave4MH <- Wave4MH %>%
  summarise(MEAN = weighted.mean(wave4months, w = LGWT))

Wave4MSK_MH <- filter(imputed, MSK_MH1 == 1, Empl4 == 1)
Wave4MSK_MH <- Wave4MSK_MH %>% drop_na(wave4months)
Wave4MSK_MH <- Wave4MSK_MH %>%
  summarise(MEAN = weighted.mean(wave4months, w = LGWT))


#Wave 5

Wave5MSK <- filter(imputed, MSK1 == 1, Empl5 == 1) 
Wave5MSK <- Wave5MSK %>% drop_na(wave5months)
Wave5MSK <- Wave5MSK %>%
  summarise(MEAN = weighted.mean(wave5months, w = LGWT))

Wave5MH <- filter(imputed, MH1 == 1, Empl5 == 1)
Wave5MH <- Wave5MH %>% drop_na(wave5months)
Wave5MH <- Wave5MH %>%
  summarise(MEAN = weighted.mean(wave5months, w = LGWT))

Wave5MSK_MH <- filter(imputed, MSK_MH1 == 1, Empl5 == 1)
Wave5MSK_MH <- Wave5MSK_MH %>% drop_na(wave5months)
Wave5MSK_MH <- Wave5MSK_MH %>%
  summarise(MEAN = weighted.mean(wave5months, w = LGWT))


#values of means from above:

#changing NAs:
#MSK1, MH1, MSK_MH1,


imputednasremoved <- imputed 

#wave2

#wave2MSK:2.653137
#wave2MH:2.667783
#wave2MSK_MH:2.62009

imputednasremoved <- imputednasremoved %>% mutate(wave2months = ifelse(is.na(wave2months) & Empl2 > 0.5 & MSK1 > 0.5, 2.653137, wave2months))

imputednasremoved <- imputednasremoved %>% mutate(wave2months = ifelse(is.na(wave2months) & Empl2 > 0.5 & MH1 > 0.5, 2.667783, wave2months))

imputednasremoved <- imputednasremoved %>% mutate(wave2months = ifelse(is.na(wave2months) & Empl2 > 0.5 & MSK_MH1 > 0.5, 2.62009, wave2months))


#wave3

#wave3MSK:2.62478
#wave3MH:2.63153
#wave3MSK_MH:2.620551

imputednasremoved <- imputednasremoved %>% mutate(wave3months = ifelse(is.na(wave3months) & Empl3 > 0.5 & MSK1 > 0.5, 2.62478, wave3months))

imputednasremoved <- imputednasremoved %>% mutate(wave3months = ifelse(is.na(wave3months) & Empl3 > 0.5 & MH1 > 0.5, 2.63153, wave3months))

imputednasremoved <- imputednasremoved %>% mutate(wave3months = ifelse(is.na(wave3months) & Empl3 > 0.5 & MSK_MH1 > 0.5, 2.620551, wave3months))


#wave4

#wave4MSK:2.736857
#wave4MH:2.730277
#wave4MSK_MH:2.763621

imputednasremoved <- imputednasremoved %>% mutate(wave4months = ifelse(is.na(wave4months) & Empl4 > 0.5 & MSK1 > 0.5, 2.736857, wave4months))

imputednasremoved <- imputednasremoved %>% mutate(wave4months = ifelse(is.na(wave4months) & Empl4 > 0.5 & MH1 > 0.5, 2.730277, wave4months))

imputednasremoved <- imputednasremoved %>% mutate(wave4months = ifelse(is.na(wave4months) & Empl4 > 0.5 & MSK_MH1 > 0.5, 2.763621, wave4months))


#wave5

#wave5MSK:2.920724
#wave5MH:2.920917
#wave5MSK_MH:2.943911

imputednasremoved <- imputednasremoved %>% mutate(wave5months = ifelse(is.na(wave5months) & Empl5 > 0.5 & MSK1 > 0.5, 2.920724, wave5months))

imputednasremoved <- imputednasremoved %>% mutate(wave5months = ifelse(is.na(wave5months) & Empl5 > 0.5 & MH1 > 0.5, 2.920917, wave5months))

imputednasremoved <- imputednasremoved %>% mutate(wave5months = ifelse(is.na(wave5months) & Empl5 > 0.5 & MSK_MH1 > 0.5, 2.943911, wave5months))



#it did work there's just still NAs from missing benefit group data. 
table(imputednasremoved$wave5months, useNA = 'always')







