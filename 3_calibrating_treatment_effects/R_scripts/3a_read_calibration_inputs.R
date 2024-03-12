### load input parameters for the simulation

path <- "X:/HAR_PR/PR/IPS_beyond_SMI_NIHR202996/General/CBA Tool/Tool Template Drafts"
file <- "/tree with health condition split"

##############################################################################
## read in the probabilities from the BAU individual benefit group trees 
## and put into a list to pass into the simulation function

## loop over benefit groups 

health_condition <- c("MSK","MH","MSK + MH")

prob_list <- list()

for (b in 1:length(health_condition)){
  
  print(paste0("Reading probabilities: ", health_condition[b]))
  
  
  ## Wave 1-2 probabilities
  prob1 <- as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition[b]), range = "G17:G17", col_names = FALSE))
  
  ## Wave 2-33 probabilities
  prob2 <- as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition[b]), range = "K12:K12", col_names = FALSE))
  prob3 <- as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition[b]), range = "K36:K36", col_names = FALSE))
  
  ## Wave 3-4 probabilities
  prob4 <- as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition[b]), range = "O9:O9", col_names = FALSE))
  prob5 <- as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition[b]), range = "O21:O21", col_names = FALSE))
  prob6 <- as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition[b]), range = "O33:O33", col_names = FALSE))
  prob7 <- as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition[b]), range = "O45:O45", col_names = FALSE))
  
  ## Wave 4-5 probabilities
  prob8  <- as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition[b]), range = "S7:S7", col_names = FALSE))
  prob9  <- as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition[b]), range = "S13:S13", col_names = FALSE))
  prob10 <- as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition[b]), range = "S19:S19", col_names = FALSE))
  prob11 <- as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition[b]), range = "S25:S25", col_names = FALSE))
  prob12 <- as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition[b]), range = "S31:S31", col_names = FALSE))
  prob13 <- as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition[b]), range = "S37:S37", col_names = FALSE))
  prob14 <- as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition[b]), range = "S43:S43", col_names = FALSE))
  prob15 <- as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition[b]), range = "S49:S49", col_names = FALSE))
  
  
  ## add to list 
  
  prob_list[[b]] <- c(prob1, prob2, prob3, prob4, prob5,
                      prob6, prob7, prob8, prob9, prob10,
                      prob11, prob12, prob13, prob14, prob15)
  
  rm(prob1, prob2, prob3, prob4, prob5,
     prob6, prob7, prob8, prob9, prob10,
     prob11, prob12, prob13, prob14, prob15)
}

#######################################################
### Set the health condition split to match HLE


### HLE Trial

HLE        <- as.vector(as.matrix(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Health Condition Group Size"), range = "B14:D14", col_names = FALSE)))


########################################################
### From the tool read in the HLE trial outcomes overall 
### and by benefit group 

### HLE trial outcomes

IPS_PROB_13weeks_empl = as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree IPS Total Health Condition"), range = "AD29:AD29", col_names = FALSE))
IPS_PROB_at12mth_empl = as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree IPS Total Health Condition"), range = "AD23:AD23", col_names = FALSE))
IPS_PROB_in12mth_empl = as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree IPS Total Health Condition"), range = "AD17:AD17", col_names = FALSE))

### BAU outcomes (for checking the simulation reproduces BAU)

BAU_PROB_13weeks_empl = as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree Total Health Condition"), range = "AC29:AC29", col_names = FALSE))
BAU_PROB_at12mth_empl = as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree Total Health Condition"), range = "AC23:AC23", col_names = FALSE))
BAU_PROB_in12mth_empl = as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree Total Health Condition"), range = "AC17:AC17", col_names = FALSE))


### Proportion of people never in employed at the LFS survey data who did work in between
### interview dates

nonemp_emprate = c(as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree MSK"),      range = "AE5:AE5", col_names = FALSE)),
                   as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree MH"),       range = "AE5:AE5", col_names = FALSE)),
                   as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree MSK + MH"), range = "AE5:AE5", col_names = FALSE)))
