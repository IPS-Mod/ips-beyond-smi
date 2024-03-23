### version of EmpHistory_sim that models each benefit group separately. The purpose is to 
### simulate the impact of different calibration factors for the probability of non-employment
### and compare the 12 month outcomes with those in the IPS trials, to impute a treatment effect 
### in the model

# n_sim = number of simulation runs
# seed = random number seed
# U = range from which to draw non-employment probabilities for the non-employed
# E1 = range from which to draw non-employment probabilities for the employed 1 quarter
# E2 = range from which to draw non-employment probabilities for the employed 2 quarters
# E3 = range from which to draw non-employment probabilities for the employed 3 quarters
# IPS_PROB_13weeks_empl = calibration target, P(employed for at least 13 weeks out of 52)
# IPS_PROB_at12mth_empl = calibration target, P(employed at week 52 / month 12)
# IPS_PROB_in12mth_empl = calibration target, P(employed at any point in the 12 months)
# ben_group_split = vector of proportions for splitting the total population among benefit groups
# prob_list = non-employment probabilities between quarter t-1 and t, for each transition and benefit group
# pop_size = size of the synthetic population
# nonemp_emprate = the proportion of those in the UUUUU tree branch who did have a spell of employment between fence posts

EmpHistory_sim <- function(n_sim = n_sim,
                           seed = 0,
                           U = c(0,1),
                           E1 = c(0,1),
                           E2 = c(0,1),
                           E3 = c(0,1),
                           IPS_PROB_13weeks_empl = 0.22,
                           IPS_PROB_at12mth_empl = 0.2355,
                           IPS_PROB_in12mth_empl = 0.3697,
                           health_cond_split = c(0.0732, 0.2686, 0.6582),
                           prob_list = NULL,
                           pop_size = 100000,
                           nonemp_emprate = c(0, 0, 0, 0, 0),
                           unrestricted = FALSE){
  
  set.seed(seed)
  
  ###############################################################
  ### Create a matrix to save simulation results to - with 
  ### n_sim rows and 8 columns - one for each parameter simulating
  
  simulation_data <- matrix(rep(NA, n_sim*10), 
                            ncol = 10, 
                            dimnames = list(NULL,
                                            c("calib_U","calib_E1","calib_E2","calib_E3",
                                              "PROB_13weeks_empl", "PROB_at12mth_empl", "PROB_in12mth_empl",
                                              "diff_13weeks_empl", "diff_at12mth_empl", "diff_in12mth_empl")))
  
  
  #### Probability that someone in the non-employed pathway found work at some point
  #### within the 12 month window of LFS participation (i.e was not
  #### employed at the fence posts, but was employed in between), by benefit group
  
  if(is.null(nonemp_emprate)){
    nonemp_emprate <- c(0, 0, 0)
  }
  
  #### Split the synthetic population size by distribution of individuals across
  #### health conditions in the HLE trial
  
  health_condition_label <- c("MSK","MH","MSK_MH")
  pop_size_split <- pop_size * health_cond_split
  
  #### loop over the specified number of simulation
  for (i in 1:n_sim){
    
    if (n_sim < 10000){
    cat(paste0("Simulation progress: ",round(i/n_sim,4)*100,"%"), "               \r")
    utils::flush.console()
    } else {
    cat(paste0("Simulation progress (make a cuppa, this'll take a while): ",round(i/n_sim,4)*100,"%"), "               \r")
    utils::flush.console()  
    }
    
    ############################################################
    ### Draw a random calibration factor from a uniform 
    ### distribution for this round of the simulation (which will
    ### be applied across each benefit group) and fill in the matrix
    
      calib_U   <- rep(runif(1,min(U),max(U)), 1)
      calib_E1  <- rep(runif(1,min(E1),max(E1)), 1)
      calib_E2  <- rep(runif(1,min(E2),max(E2)), 1)
      calib_E3  <- rep(runif(1,min(E3),max(E3)), 1)
    
    simulation_data[i, "calib_U"] <- calib_U
    simulation_data[i, "calib_E1"] <- calib_E1
    simulation_data[i, "calib_E2"] <- calib_E2
    simulation_data[i, "calib_E3"] <- calib_E3
    
    ###########################################################
    ### Business-as-usual probabilities of unemployment multiplied 
    ### by the randomly drawn calibration factor
    
    n_categories <- length(health_cond_split)
    
    for (b in 1:n_categories){
      
      probs <- prob_list[[b]]
    
      ######################################################
      ### Apply calibration factors to each probabilitiy
    ### Wave 2 
    
    prob_U <- probs[1] * calib_U
    
    ### Wave 3 
    
    prob_UU <- probs[2] * calib_U
    prob_UE <- probs[3] * calib_E1
    
    ### Wave 4 
    
    prob_UUU <- probs[4] * calib_U
    prob_UUE <- probs[5] * calib_E1
    prob_UEU <- probs[6] * calib_U
    prob_UEE <- probs[7] * calib_E2
    
    ### Wave 5 
    
    prob_UUUU <- probs[8]  * calib_U
    prob_UUUE <- probs[9]  * calib_E1
    prob_UUEU <- probs[10] * calib_U
    prob_UUEE <- probs[11] * calib_E2
    prob_UEUU <- probs[12] * calib_U
    prob_UEUE <- probs[13] * calib_E1
    prob_UEEU <- probs[14] * calib_U
    prob_UEEE <- probs[15] * calib_E3

    #############################################################
    #### Calculate business-as-usual probabilities of each possible 
    #### employment pathway based on probabilities adjusted for the 
    #### randomly drawn calibration factor
    
    #### Then multiply this by benefit group size 
    
    out01_UUUUU <- ((prob_U) * (prob_UU) * (prob_UUU) * (prob_UUUU) ) * pop_size_split[b]
    out02_UUUUE <- ((prob_U) * (prob_UU) * (prob_UUU) * (1-prob_UUUU) ) * pop_size_split[b]
    
    out03_UUUEU <- ((prob_U) * (prob_UU) * (1 - prob_UUU) * (prob_UUUE) ) * pop_size_split[b]
    out04_UUUEE <- ((prob_U) * (prob_UU) * (1 - prob_UUU) * (1 - prob_UUUE) ) * pop_size_split[b]
    
    out05_UUEUU <- ((prob_U) * (1 - prob_UU) * (prob_UUE) * (prob_UUEU) ) * pop_size_split[b]
    out06_UUEUE <- ((prob_U) * (1 - prob_UU) * (prob_UUE) * (1 - prob_UUEU) ) * pop_size_split[b]
    
    out07_UUEEU <- ((prob_U) * (1 - prob_UU) * (1 - prob_UUE) * (prob_UUEE) ) * pop_size_split[b]
    out08_UUEEE <- ((prob_U) * (1 - prob_UU) * (1 - prob_UUE) * (1 - prob_UUEE) ) * pop_size_split[b]
    
    out09_UEUUU <- ((1 - prob_U) * (prob_UE) * (prob_UEU) * (prob_UEUU) ) * pop_size_split[b]
    out10_UEUUE <- ((1 - prob_U) * (prob_UE) * (prob_UEU) * (1 - prob_UEUU) ) * pop_size_split[b]
    
    out11_UEUEU <- ((1 - prob_U) * (prob_UE) * (1 - prob_UEU) * (prob_UEUE) ) * pop_size_split[b]
    out12_UEUEE <- ((1 - prob_U) * (prob_UE) * (1 - prob_UEU) * (1 - prob_UEUE) ) * pop_size_split[b] 
    
    out13_UEEUU <- ((1 - prob_U) * (1 - prob_UE) * (prob_UEE) * (prob_UEEU) )  * pop_size_split[b]
    out14_UEEUE <- ((1 - prob_U) * (1 - prob_UE) * (prob_UEE) * (1 - prob_UEEU) )  * pop_size_split[b]  
    
    out15_UEEEU <- ((1 - prob_U) * (1 - prob_UE) * (1 - prob_UEE) * (prob_UEEE) )  * pop_size_split[b]
    out16_UEEEE <- ((1 - prob_U) * (1 - prob_UE) * (1 - prob_UEE) * (1 - prob_UEEE) )   * pop_size_split[b]
    
    ### make a dataset of benefit group level simulation result
    
    pathway <- 1:16
    number <- c(out01_UUUUU, out02_UUUUE, out03_UUUEU, out04_UUUEE,
                out05_UUEUU, out06_UUEUE, out07_UUEEU, out08_UUEEE,
                out09_UEUUU, out10_UEUUE, out11_UEUEU, out12_UEUEE,
                out13_UEEUU, out14_UEEUE, out15_UEEEU, out16_UEEEE)
    h_cond <- rep(health_condition_label[b], 16)
    prob_empl <- c(nonemp_emprate[b], rep(1,15))
    
    data <- data.frame(pathway, number, h_cond, prob_empl)
    
    ##############################################################
    ### Append each health condition tree results to each other 
    
    if (b == 1){
      final_data <- copy(data)
    } else {
      final_data <- rbind(final_data, data)
    }
    
    } ### finish loop over health conditions
    
    #####################################################################
    #### Aggregate the numbers from each employment pathway across the 
    #### benefit groups and create dummies for a) 13 weeks empl, b) empl @ 12mths
    
    final_data_sum <- final_data %>%
      group_by(pathway) %>%
      summarise(number_total = sum(number),
                number_ever_empl = sum(number*prob_empl)) %>%
      ungroup() %>%
      mutate(empl13wks = ifelse(pathway %in% c(2:16), 1, 0 ),
             empl_at12mth = ifelse(pathway %in% c(2,4,6,8,10,12,14,16), 1, 0 ),
             n_13wks = sum(number_total*empl13wks),
             n_at12mth = sum(number_total*empl_at12mth),
             n_in12mth = sum(number_ever_empl))
    
    ## collapse across pathways
    
    empl_13wks <- mean(final_data_sum$n_13wks)
    empl_at12mth <- mean(final_data_sum$n_at12mth)
    empl_in12mth <- mean(final_data_sum$n_in12mth)
    
    #####################################################################
    #### Generate the trial outcomes:
    
    ## a) probability of being in work for 13 or more weeks 
    ## b) probability of being in work at the 12 month point
    
    PROB_13weeks_empl <- empl_13wks / pop_size
    PROB_at12mth_empl <- empl_at12mth / pop_size
    PROB_in12mth_empl <- empl_in12mth / pop_size
    
    ### Simulated outcome minus trial outcome
    
    diff_13weeks_empl = PROB_13weeks_empl - IPS_PROB_13weeks_empl
    diff_at12mth_empl = PROB_at12mth_empl - IPS_PROB_at12mth_empl
    diff_in12mth_empl = PROB_in12mth_empl - IPS_PROB_in12mth_empl
    
    ######################################################################
    #### Save the outcome for this iteration of the simulation
    
    simulation_data[i, "PROB_13weeks_empl"] <- PROB_13weeks_empl
    simulation_data[i, "PROB_at12mth_empl"] <- PROB_at12mth_empl
    simulation_data[i, "PROB_in12mth_empl"] <- PROB_in12mth_empl
    simulation_data[i, "diff_13weeks_empl"] <- diff_13weeks_empl
    simulation_data[i, "diff_at12mth_empl"] <- diff_at12mth_empl
    simulation_data[i, "diff_in12mth_empl"] <- diff_in12mth_empl
    
  } ## finish the loop over the simulation iterations
  
  simulation_data <- as_tibble(simulation_data)
  
  return(simulation_data)
  
}