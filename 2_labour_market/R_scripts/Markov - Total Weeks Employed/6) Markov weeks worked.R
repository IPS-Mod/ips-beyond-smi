rm(list=ls()[!ls() %in% c("totalweeksworked")])


markovtotalweeksworked <- totalweeksworked

##############finding average weeks worked for employed######################

#Wave 2

Wave2 <- filter(markovtotalweeksworked, Empl2 == 1) 

Wave2 <- Wave2 %>% rename_at('wave2months', ~'Emptotalmonthsworked') 

#Wave 3

Wave3 <- filter(markovtotalweeksworked, Empl3 == 1) 

Wave3 <- Wave3 %>% rename_at('wave3months', ~'Emptotalmonthsworked') 

#Wave 4

Wave4 <- filter(markovtotalweeksworked, Empl4 == 1) 

Wave4 <- Wave4 %>% rename_at('wave4months', ~'Emptotalmonthsworked') 

#Wave 5

Wave5 <- filter(markovtotalweeksworked, Empl5 == 1) 

Wave5 <- Wave5 %>% rename_at('wave5months', ~'Emptotalmonthsworked') 

#combine waves

Emptotalmonthsworked <- rbind(Wave2, Wave3, Wave4, Wave5, fill=TRUE)


##############finding average weeks worked for non employed######################

#Wave 2

Wave2 <- filter(markovtotalweeksworked, Empl2 == 0) 

Wave2 <- Wave2 %>% rename_at('wave2months', ~'NonEmptotalmonthsworked') 

#Wave 3

Wave3 <- filter(markovtotalweeksworked, Empl3 == 0) 

Wave3 <- Wave3 %>% rename_at('wave3months', ~'NonEmptotalmonthsworked') 

#Wave 4

Wave4 <- filter(markovtotalweeksworked, Empl4 == 0) 

Wave4 <- Wave4 %>% rename_at('wave4months', ~'NonEmptotalmonthsworked') 

#Wave 5

Wave5 <- filter(markovtotalweeksworked, Empl5 == 0) 

Wave5 <- Wave5 %>% rename_at('wave5months', ~'NonEmptotalmonthsworked') 

#combine waves

NonEmptotalmonthsworked <- rbind(Wave2, Wave3, Wave4, Wave5, fill=TRUE)



