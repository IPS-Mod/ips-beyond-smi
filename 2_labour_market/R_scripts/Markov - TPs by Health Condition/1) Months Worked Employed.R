#finding variable for months worked (for those who said 'YES' to being in work in INCAC05 variable)

monthsworked <- health_condition_data

monthsworked <- mutate(monthsworked,
                      wave2months = MONTHw2 - CONMON2,
                      wave3months = MONTHw3 - CONMON3,
                      wave4months = MONTHw4 - CONMON4,
                      wave5months = MONTHw5 - CONMON5)

#Take absolute values to account for 'impossible' job starts 

monthsworked <- mutate(monthsworked,
                      wave2months = abs(wave2months),
                      wave3months = abs(wave3months),
                      wave4months = abs(wave4months),
                      wave5months = abs(wave5months))

#Add 1 so if working in same month started it counts as 1 month worked.

monthsworked <- mutate(monthsworked,
                      wave2months = wave2months + 1,
                      wave3months = wave3months + 1,
                      wave4months = wave4months + 1,
                      wave5months = wave5months + 1)


#Make maximum value 3 so it only counts that wave.

monthsworked <- monthsworked %>% mutate(wave2months = ifelse(wave2months > 3, 3, wave2months))

monthsworked <- monthsworked %>% mutate(wave3months = ifelse(wave3months > 3, 3, wave3months))

monthsworked <- monthsworked %>% mutate(wave4months = ifelse(wave4months > 3, 3, wave4months))

monthsworked <- monthsworked %>% mutate(wave5months = ifelse(wave5months > 3, 3, wave5months))






