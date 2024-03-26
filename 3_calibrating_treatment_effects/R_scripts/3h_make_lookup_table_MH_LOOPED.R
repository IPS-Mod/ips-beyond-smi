source("03_load_packages.R")

start <- Sys.time()

health <- c("MSK","MH","MSK + MH")

path <- "X:/HAR_PR/PR/IPS_beyond_SMI_NIHR202996/General/CBA Tool/Tool Template Drafts/performance multiplier by disability/"
health_condition <- health[2]

for (j in 0:100){


print(paste0("Disability percentage ",j," of 100"))
  
  
  file <- paste0("IPS Tool user friendly ", j)
  
  
  ######################################################
  ### Read in the probabilities 
  
  ## Wave 1-2 probabilities
  prob1 <- suppressMessages( as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition), range = "G17:G17", col_names = FALSE)) )
  
  ## Wave 2-33 probabilities
  prob2 <- suppressMessages( as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition), range = "K12:K12", col_names = FALSE)) )
  prob3 <- suppressMessages( as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition), range = "K36:K36", col_names = FALSE)) )
  
  ## Wave 3-4 probabilities
  prob4 <- suppressMessages( as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition), range = "O9:O9", col_names = FALSE)) )
  prob5 <- suppressMessages( as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition), range = "O21:O21", col_names = FALSE)) )
  prob6 <- suppressMessages( as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition), range = "O33:O33", col_names = FALSE)) )
  prob7 <- suppressMessages( as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition), range = "O45:O45", col_names = FALSE)) )
  
  ## Wave 4-5 probabilities
  prob8  <- suppressMessages( as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition), range = "S7:S7", col_names = FALSE)) )
  prob9  <- suppressMessages( as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition), range = "S13:S13", col_names = FALSE)) )
  prob10 <- suppressMessages( as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition), range = "S19:S19", col_names = FALSE)) )
  prob11 <- suppressMessages( as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition), range = "S25:S25", col_names = FALSE)) )
  prob12 <- suppressMessages( as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition), range = "S31:S31", col_names = FALSE)) )
  prob13 <- suppressMessages( as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition), range = "S37:S37", col_names = FALSE)) )
  prob14 <- suppressMessages( as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition), range = "S43:S43", col_names = FALSE)) )
  prob15 <- suppressMessages( as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition), range = "S49:S49", col_names = FALSE)) )
  
  
  ## add to list 
  
  probs <- c(prob1, prob2, prob3, prob4, prob5,
             prob6, prob7, prob8, prob9, prob10,
             prob11, prob12, prob13, prob14, prob15)
  
  rm(prob1, prob2, prob3, prob4, prob5,
     prob6, prob7, prob8, prob9, prob10,
     prob11, prob12, prob13, prob14, prob15)
  
  
  ######################################################
  ### Read in the calibration factors
  
  calib_U_trt <-  suppressMessages( as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree IPS ", health_condition), range = "AC36:AC36", col_names = FALSE)) )
  calib_E1_trt <- suppressMessages( as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree IPS ", health_condition), range = "AC37:AC37", col_names = FALSE)) )
  calib_E2_trt <- suppressMessages( as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree IPS ", health_condition), range = "AC38:AC38", col_names = FALSE)) )
  calib_E3_trt <- suppressMessages( as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree IPS ", health_condition), range = "AC39:AC39", col_names = FALSE)) )
  


multiplier_vector <- seq(-1,1,0.01)


for (i in 1:length(multiplier_vector)){
  
multiplier <- multiplier_vector[i]

### Increase the calibration factor (c) by a multiplier (m) to produce different

### The multiplier is applied to the difference between 1 and the calibration 
### factor if the multiplier is positive (produces a worse outcome than the HLE treatment arm).
### It is applied to the difference between the calibration factor and zero if the 
### multiplier is negative (produces a better outcome than the HLE treatment arm)

### c' = c + (1 - c)m (if 1 >= m >= 0)
### c' = c + (c - 0)m (if -1 <= m < 0)

### Multiplier can range between 1 and -1 
### 0 - no adjustment, produces the HLE treatment arm outcome 
### 1 - adjusts for the full difference of (1 - c), BAU outcome
### -1 - adjusts for the full difference of (c - 0), full employment 

####################################################
#### Apply the multiplier to the calibration factor

if (multiplier >= 0){
  
  calib_U  <- calib_U_trt  + (1 - calib_U_trt)*multiplier
  calib_E1 <- calib_E1_trt + (1 - calib_E1_trt)*multiplier
  calib_E2 <- calib_E2_trt + (1 - calib_E2_trt)*multiplier
  calib_E3 <- calib_E3_trt + (1 - calib_E3_trt)*multiplier
  
} else if (multiplier < 0) {
  
  calib_U  <- calib_U_trt  + (calib_U_trt)*multiplier
  calib_E1 <- calib_E1_trt + (calib_E1_trt)*multiplier
  calib_E2 <- calib_E2_trt + (calib_E2_trt)*multiplier
  calib_E3 <- calib_E3_trt + (calib_E3_trt)*multiplier  
  
}


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

out01_UUUUU <- ((prob_U) * (prob_UU) * (prob_UUU) * (prob_UUUU) ) 
out02_UUUUE <- ((prob_U) * (prob_UU) * (prob_UUU) * (1-prob_UUUU) ) 

out03_UUUEU <- ((prob_U) * (prob_UU) * (1 - prob_UUU) * (prob_UUUE) ) 
out04_UUUEE <- ((prob_U) * (prob_UU) * (1 - prob_UUU) * (1 - prob_UUUE) ) 

out05_UUEUU <- ((prob_U) * (1 - prob_UU) * (prob_UUE) * (prob_UUEU) ) 
out06_UUEUE <- ((prob_U) * (1 - prob_UU) * (prob_UUE) * (1 - prob_UUEU) ) 

out07_UUEEU <- ((prob_U) * (1 - prob_UU) * (1 - prob_UUE) * (prob_UUEE) ) 
out08_UUEEE <- ((prob_U) * (1 - prob_UU) * (1 - prob_UUE) * (1 - prob_UUEE) ) 

out09_UEUUU <- ((1 - prob_U) * (prob_UE) * (prob_UEU) * (prob_UEUU) ) 
out10_UEUUE <- ((1 - prob_U) * (prob_UE) * (prob_UEU) * (1 - prob_UEUU) ) 

out11_UEUEU <- ((1 - prob_U) * (prob_UE) * (1 - prob_UEU) * (prob_UEUE) ) 
out12_UEUEE <- ((1 - prob_U) * (prob_UE) * (1 - prob_UEU) * (1 - prob_UEUE) )

out13_UEEUU <- ((1 - prob_U) * (1 - prob_UE) * (prob_UEE) * (prob_UEEU) )  
out14_UEEUE <- ((1 - prob_U) * (1 - prob_UE) * (prob_UEE) * (1 - prob_UEEU) )   

out15_UEEEU <- ((1 - prob_U) * (1 - prob_UE) * (1 - prob_UEE) * (prob_UEEE) )  
out16_UEEEE <- ((1 - prob_U) * (1 - prob_UE) * (1 - prob_UEE) * (1 - prob_UEEE) )  

### make a dataset of benefit group level simulation result

EmpAt12mth <- sum(out02_UUUUE, out04_UUUEE, out06_UUEUE, out08_UUEEE,
                  out10_UEUUE, out12_UEUEE, out14_UEEUE, out16_UEEEE)

data <- data.table(calib_U,calib_E1,calib_E2,calib_E3,multiplier,EmpAt12mth)

if (i == 1){
  data_out <- copy(data)
} else {
  data_out <- rbindlist(list(data_out, data))
}

}

##############################################################################################
##### create lookup table, remove duplicate employment rate observations (when rounded to 0)

lkup <- data_out %>%
  mutate(EmpAt12mth = round(EmpAt12mth,2)) %>%
  select(multiplier, EmpAt12mth) %>%
  distinct(EmpAt12mth, .keep_all = TRUE)

ref <- data.table(EmpAt12mth = seq(min(lkup$EmpAt12mth),1,0.01))

lkup_table <- merge(ref, lkup, by = "EmpAt12mth", all.x = TRUE)  %>%
  mutate(multiplier_imp = round(na.approx(multiplier),3)) %>%
  select(EmpAt12mth,multiplier_imp) %>%
  mutate(disability_rate = j/100)

if (j == 0){
  lkup_table_out <- copy(lkup_table)
} else {
  lkup_table_out <- rbindlist(list(lkup_table_out, lkup_table))
}
  
}

end <- Sys.time()

paste0(print((end - start)/101)," per disability % point")


saveRDS(lkup_table_out,"3_calibrating_treatment_effects/intermediate_data/performance_multipliers_mh_by_disability.rds")


