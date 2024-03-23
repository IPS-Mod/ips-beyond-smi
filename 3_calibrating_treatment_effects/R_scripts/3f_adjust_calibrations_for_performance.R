source("03_load_packages.R")

path <- "X:/HAR_PR/PR/IPS_beyond_SMI_NIHR202996/General/CBA Tool/Tool Template Drafts/"
file <- "IPS Tool user friendly"
health_condition <- c("MSK","MH","MSK + MH")[1]

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

multiplier <- -1

######################################################
### Read in the probabilities 

## Wave 1-2 probabilities
prob1 <- as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition), range = "G17:G17", col_names = FALSE))

## Wave 2-33 probabilities
prob2 <- as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition), range = "K12:K12", col_names = FALSE))
prob3 <- as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition), range = "K36:K36", col_names = FALSE))

## Wave 3-4 probabilities
prob4 <- as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition), range = "O9:O9", col_names = FALSE))
prob5 <- as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition), range = "O21:O21", col_names = FALSE))
prob6 <- as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition), range = "O33:O33", col_names = FALSE))
prob7 <- as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition), range = "O45:O45", col_names = FALSE))

## Wave 4-5 probabilities
prob8  <- as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition), range = "S7:S7", col_names = FALSE))
prob9  <- as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition), range = "S13:S13", col_names = FALSE))
prob10 <- as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition), range = "S19:S19", col_names = FALSE))
prob11 <- as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition), range = "S25:S25", col_names = FALSE))
prob12 <- as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition), range = "S31:S31", col_names = FALSE))
prob13 <- as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition), range = "S37:S37", col_names = FALSE))
prob14 <- as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition), range = "S43:S43", col_names = FALSE))
prob15 <- as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree ", health_condition), range = "S49:S49", col_names = FALSE))


## add to list 

probs <- c(prob1, prob2, prob3, prob4, prob5,
           prob6, prob7, prob8, prob9, prob10,
           prob11, prob12, prob13, prob14, prob15)

rm(prob1, prob2, prob3, prob4, prob5,
   prob6, prob7, prob8, prob9, prob10,
   prob11, prob12, prob13, prob14, prob15)

######################################################
### Read in the calibration factors

calib_U_trt <- as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree IPS ", health_condition), range = "AC36:AC36", col_names = FALSE))
calib_E1_trt <- as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree IPS ", health_condition), range = "AC37:AC37", col_names = FALSE))
calib_E2_trt <- as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree IPS ", health_condition), range = "AC38:AC38", col_names = FALSE))
calib_E3_trt <- as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree IPS ", health_condition), range = "AC39:AC39", col_names = FALSE))


calib_U_ctrl <- as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree Uptakers ", health_condition), range = "AC36:AC36", col_names = FALSE))
calib_E1_ctrl <- as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree Uptakers ", health_condition), range = "AC37:AC37", col_names = FALSE))
calib_E2_ctrl <- as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree Uptakers ", health_condition), range = "AC38:AC38", col_names = FALSE))
calib_E3_ctrl <- as.numeric(readxl::read_excel(paste0(path,file,".xlsx"), sheet = paste0("Tree Uptakers ", health_condition), range = "AC39:AC39", col_names = FALSE))

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

sum(out02_UUUUE, out04_UUUEE, out06_UUEUE, out08_UUEEE,
    out10_UEUUE, out12_UEUEE, out14_UEEUE, out16_UEEEE)

