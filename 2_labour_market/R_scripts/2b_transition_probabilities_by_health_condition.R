
#############################
#### Read in data ###########


tree_msk <- readRDS("2_labour_market/intermediate_data/lfs_longitudinal_cleaned_health_cond.rds") %>%
  filter(Empl1 == 0 & MSK1 == 1)

tree_mh <- readRDS("2_labour_market/intermediate_data/lfs_longitudinal_cleaned_health_cond.rds") %>%
  filter(Empl1 == 0 & MH1 == 1)

tree_msk_mh <- readRDS("2_labour_market/intermediate_data/lfs_longitudinal_cleaned_health_cond.rds") %>%
  filter(Empl1 == 0 & MSK_MH1 == 1)

### put datasets in a list 
data_list <- list(tree_msk, tree_mh, tree_msk_mh)

#############################################
### Get probabilities by health condition

for (i in 1:length(data_list)){ 
  
  tree <- data_list[[i]]
##Wave 2 probabilities  

jobstartprob23 <- filter(tree, Empl1 == 0) %>%
  summarise(jobstartprob23 = weighted.mean(Empl2, w = LGWT)) %>% as.numeric()

##Wave 3 probabilities 

jobstartprob45 <- filter(tree, Empl1 == 0, Empl2 == 0) %>%
  summarise(jobstartprob45 = weighted.mean(Empl3, w = LGWT)) %>% as.numeric()

jobstartprob67 <- filter(tree, Empl1 == 0, Empl2 == 1) %>%
  summarise(jobstartprob67 = weighted.mean(Empl3, w = LGWT)) %>% as.numeric()


##Wave 4 probabilities 

jobstartprob89 <- filter(tree, Empl1 == 0, Empl2 == 0, Empl3 == 0) %>%
  summarise(jobstartprob89 = weighted.mean(Empl4, w = LGWT)) %>% as.numeric()

jobstartprob1011 <- filter(tree, Empl1 == 0, Empl2 == 0, Empl3 == 1) %>%
  summarise(jobstartprob1011 = weighted.mean(Empl4, w = LGWT)) %>% as.numeric()

jobstartprob1213 <- filter(tree, Empl1 == 0, Empl2 == 1, Empl3 == 0) %>%
  summarise(jobstartprob1213 = weighted.mean(Empl4, w = LGWT)) %>% as.numeric()

jobstartprob1415 <- filter(tree, Empl1 == 0, Empl2 == 1, Empl3 == 1) %>%
  summarise(jobstartprob1415 = weighted.mean(Empl4, w = LGWT)) %>% as.numeric()

##Wave 5 probabilities 

jobstartprob1617 <- filter(tree, Empl1 == 0, Empl2 == 0, Empl3 == 0, Empl4 == 0) %>%
  summarise(jobstartprob1617 = weighted.mean(Empl5, w = LGWT)) %>% as.numeric()

jobstartprob1819 <- filter(tree, Empl1 == 0, Empl2 == 0, Empl3 == 0, Empl4 == 1) %>%
  summarise(jobstartprob1819 = weighted.mean(Empl5, w = LGWT)) %>% as.numeric()

jobstartprob2021 <- filter(tree, Empl1 == 0, Empl2 == 0, Empl3 == 1, Empl4 == 0) %>%
  summarise(jobstartprob2021 = weighted.mean(Empl5, w = LGWT)) %>% as.numeric()

jobstartprob2223 <- filter(tree, Empl1 == 0, Empl2 == 0, Empl3 == 1, Empl4 == 1) %>%
  summarise(jobstartprob2223 = weighted.mean(Empl5, w = LGWT)) %>% as.numeric()

jobstartprob2425 <- filter(tree, Empl1 == 0, Empl2 == 1, Empl3 == 0, Empl4 == 0) %>%
  summarise(jobstartprob2425 = weighted.mean(Empl5, w = LGWT)) %>% as.numeric()

jobstartprob2627 <- filter(tree, Empl1 == 0, Empl2 == 1, Empl3 == 0, Empl4 == 1) %>%
  summarise(jobstartprob2627 = weighted.mean(Empl5, w = LGWT)) %>% as.numeric()

jobstartprob2829 <- filter(tree, Empl1 == 0, Empl2 == 1, Empl3 == 1, Empl4 == 0) %>%
  summarise(jobstartprob2829 = weighted.mean(Empl5, w = LGWT)) %>% as.numeric()

jobstartprob3031 <- filter(tree, Empl1 == 0, Empl2 == 1, Empl3 == 1, Empl4 == 1) %>%
  summarise(jobstartprob3031 = weighted.mean(Empl5, w = LGWT)) %>% as.numeric()

#### put into a data frame 

probs <- data.frame(jobstartprob23,
                    jobstartprob45,
                    jobstartprob67,
                    jobstartprob89,
                    jobstartprob1011,
                    jobstartprob1213,
                    jobstartprob1415,
                    jobstartprob1617,
                    jobstartprob1819,
                    jobstartprob2021,
                    jobstartprob2223,
                    jobstartprob2425,
                    jobstartprob2627,
                    jobstartprob2829,
                    jobstartprob3031)


}