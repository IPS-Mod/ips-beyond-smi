#if emplx = 0, then wavexmonths = 0. 

monthsworked2 <- monthsworked 

monthsworked2 <- monthsworked2 %>% mutate(wave2months = ifelse(Empl2 < 0.5, 0, wave2months))
monthsworked2 <- monthsworked2 %>% mutate(wave3months = ifelse(Empl3 < 0.5, 0, wave3months))
monthsworked2 <- monthsworked2 %>% mutate(wave4months = ifelse(Empl4 < 0.5, 0, wave4months))
monthsworked2 <- monthsworked2 %>% mutate(wave5months = ifelse(Empl5 < 0.5, 0, wave5months))