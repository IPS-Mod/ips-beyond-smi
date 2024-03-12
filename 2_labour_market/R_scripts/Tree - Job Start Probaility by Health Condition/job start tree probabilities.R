##Benefit group

tree <- filter(datacomplete, nobenefits1 == 1)



##Wave 2 probabilities  

jobstartprob23 <- filter(tree, Empl1 == 0) %>%
  summarise(jobstartprob23 = weighted.mean(Empl2, w = LGWT))

##Wave 3 probabilities 

jobstartprob45 <- filter(tree, Empl1 == 0, Empl2 == 0) %>%
  summarise(jobstartprob45 = weighted.mean(Empl3, w = LGWT))

jobstartprob67 <- filter(tree, Empl1 == 0, Empl2 == 1) %>%
  summarise(jobstartprob67 = weighted.mean(Empl3, w = LGWT))


##Wave 4 probabilities 

jobstartprob89 <- filter(tree, Empl1 == 0, Empl2 == 0, Empl3 == 0) %>%
  summarise(jobstartprob89 = weighted.mean(Empl4, w = LGWT))

jobstartprob1011 <- filter(tree, Empl1 == 0, Empl2 == 0, Empl3 == 1) %>%
  summarise(jobstartprob1011 = weighted.mean(Empl4, w = LGWT))

jobstartprob1213 <- filter(tree, Empl1 == 0, Empl2 == 1, Empl3 == 0) %>%
  summarise(jobstartprob1213 = weighted.mean(Empl4, w = LGWT))

jobstartprob1415 <- filter(tree, Empl1 == 0, Empl2 == 1, Empl3 == 1) %>%
  summarise(jobstartprob1415 = weighted.mean(Empl4, w = LGWT))

##Wave 5 probabilities 

jobstartprob1617 <- filter(tree, Empl1 == 0, Empl2 == 0, Empl3 == 0, Empl4 == 0) %>%
  summarise(jobstartprob1617 = weighted.mean(Empl5, w = LGWT))

jobstartprob1819 <- filter(tree, Empl1 == 0, Empl2 == 0, Empl3 == 0, Empl4 == 1) %>%
  summarise(jobstartprob1819 = weighted.mean(Empl5, w = LGWT))

jobstartprob2021 <- filter(tree, Empl1 == 0, Empl2 == 0, Empl3 == 1, Empl4 == 0) %>%
  summarise(jobstartprob2021 = weighted.mean(Empl5, w = LGWT))

jobstartprob2223 <- filter(tree, Empl1 == 0, Empl2 == 0, Empl3 == 1, Empl4 == 1) %>%
  summarise(jobstartprob2223 = weighted.mean(Empl5, w = LGWT))

jobstartprob2425 <- filter(tree, Empl1 == 0, Empl2 == 1, Empl3 == 0, Empl4 == 0) %>%
  summarise(jobstartprob2425 = weighted.mean(Empl5, w = LGWT))

jobstartprob2627 <- filter(tree, Empl1 == 0, Empl2 == 1, Empl3 == 0, Empl4 == 1) %>%
  summarise(jobstartprob2627 = weighted.mean(Empl5, w = LGWT))

jobstartprob2829 <- filter(tree, Empl1 == 0, Empl2 == 1, Empl3 == 1, Empl4 == 0) %>%
  summarise(jobstartprob2829 = weighted.mean(Empl5, w = LGWT))

jobstartprob3031 <- filter(tree, Empl1 == 0, Empl2 == 1, Empl3 == 1, Empl4 == 1) %>%
  summarise(jobstartprob3031 = weighted.mean(Empl5, w = LGWT))

