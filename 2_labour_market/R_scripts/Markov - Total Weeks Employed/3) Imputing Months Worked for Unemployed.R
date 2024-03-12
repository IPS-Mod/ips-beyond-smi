#Impute values for '1s' in 'everworked' column, varying by Health Condition

imputed <- monthsworked2 

##Change values for weeks worked based on Health Condition group specified above
#MSK1, MH1, MSK_MH1
#Value of means found in UEU scenarios. Limited observations. 

#MSK1 2.599179
#MH1 2.692393
#MSK_MH1 3



#wave2

imputed <- imputed %>% mutate(everworkedw2 = ifelse(everworkedw2 > 0.5 & MSK1 > 0.5, 2.599179, everworkedw2))
imputed <- imputed %>% mutate(everworkedw2 = ifelse(everworkedw2 > 0.5 & MH1 > 0.5, 2.692393, everworkedw2))
imputed <- imputed %>% mutate(everworkedw2 = ifelse(everworkedw2 > 0.5 & MSK_MH1 > 0.5, 3, everworkedw2))


#wave3

imputed <- imputed %>% mutate(everworkedw3 = ifelse(everworkedw3 > 0.5 & MSK1 > 0.5, 2.599179, everworkedw3))
imputed <- imputed %>% mutate(everworkedw3 = ifelse(everworkedw3 > 0.5 & MH1 > 0.5, 2.692393, everworkedw3))
imputed <- imputed %>% mutate(everworkedw3 = ifelse(everworkedw3 > 0.5 & MSK_MH1 > 0.5, 3, everworkedw3))


#wave4

imputed <- imputed %>% mutate(everworkedw4 = ifelse(everworkedw4 > 0.5 & MSK1 > 0.5, 2.599179, everworkedw4))
imputed <- imputed %>% mutate(everworkedw4 = ifelse(everworkedw4 > 0.5 & MH1 > 0.5, 2.692393, everworkedw4))
imputed <- imputed %>% mutate(everworkedw4 = ifelse(everworkedw4 > 0.5 & MSK_MH1 > 0.5, 3, everworkedw4))

#wave5

imputed <- imputed %>% mutate(everworkedw5 = ifelse(everworkedw5 > 0.5 & MSK1 > 0.5, 2.599179, everworkedw5))
imputed <- imputed %>% mutate(everworkedw5 = ifelse(everworkedw5 > 0.5 & MH1 > 0.5, 2.692393, everworkedw5))
imputed <- imputed %>% mutate(everworkedw5 = ifelse(everworkedw5 > 0.5 & MSK_MH1 > 0.5, 3, everworkedw5))


#add this into "wavemonths"

imputed <- imputed %>% mutate(wave2months = ifelse(everworkedw2 > 0.5, everworkedw2, wave2months))
imputed <- imputed %>% mutate(wave3months = ifelse(everworkedw3 > 0.5, everworkedw3, wave3months))
imputed <- imputed %>% mutate(wave4months = ifelse(everworkedw4 > 0.5, everworkedw4, wave4months))
imputed <- imputed %>% mutate(wave5months = ifelse(everworkedw5 > 0.5, everworkedw5, wave5months))
