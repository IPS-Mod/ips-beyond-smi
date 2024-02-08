##Benefit group

tree <- filter(datacomplete, nobenefits1 == 1)

tree %>% count(Empl1)

##Wave 2 probabilities  

jobstartprob23 <- filter(tree, Empl1 == 0) 

jobstartprob23 %>% count(Empl2)

##Wave 3 probabilities 

jobstartprob45 <- filter(tree, Empl1 == 0, Empl2 == 0) 

jobstartprob45 %>% count(Empl3)

jobstartprob67 <- filter(tree, Empl1 == 0, Empl2 == 1) 

jobstartprob67 %>% count(Empl3)


##Wave 4 probabilities 

jobstartprob89 <- filter(tree, Empl1 == 0, Empl2 == 0, Empl3 == 0) 

jobstartprob89 %>% count(Empl4)

jobstartprob1011 <- filter(tree, Empl1 == 0, Empl2 == 0, Empl3 == 1) 

jobstartprob1011 %>% count(Empl4)

jobstartprob1213 <- filter(tree, Empl1 == 0, Empl2 == 1, Empl3 == 0) 

jobstartprob1213 %>% count(Empl4)

jobstartprob1415 <- filter(tree, Empl1 == 0, Empl2 == 1, Empl3 == 1) 

jobstartprob1415 %>% count(Empl4)

##Wave 5 probabilities 

jobstartprob1617 <- filter(tree, Empl1 == 0, Empl2 == 0, Empl3 == 0, Empl4 == 0) 

jobstartprob1617 %>% count(Empl5)

jobstartprob1819 <- filter(tree, Empl1 == 0, Empl2 == 0, Empl3 == 0, Empl4 == 1) 

jobstartprob1819 %>% count(Empl5)

jobstartprob2021 <- filter(tree, Empl1 == 0, Empl2 == 0, Empl3 == 1, Empl4 == 0) 

jobstartprob2021 %>% count(Empl5)

jobstartprob2223 <- filter(tree, Empl1 == 0, Empl2 == 0, Empl3 == 1, Empl4 == 1) 

jobstartprob2223 %>% count(Empl5)

jobstartprob2425 <- filter(tree, Empl1 == 0, Empl2 == 1, Empl3 == 0, Empl4 == 0) 

jobstartprob2425 %>% count(Empl5)

jobstartprob2627 <- filter(tree, Empl1 == 0, Empl2 == 1, Empl3 == 0, Empl4 == 1)

jobstartprob2627 %>% count(Empl5)

jobstartprob2829 <- filter(tree, Empl1 == 0, Empl2 == 1, Empl3 == 1, Empl4 == 0)

jobstartprob2829 %>% count(Empl5)

jobstartprob3031 <- filter(tree, Empl1 == 0, Empl2 == 1, Empl3 == 1, Empl4 == 1) 

jobstartprob3031 %>% count(Empl5)
