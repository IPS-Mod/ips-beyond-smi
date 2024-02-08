##########################
## Create datasets to be used as UKMOD inputs - limit to the out of work (unemployed, sick, inactive)
## with specific health conditions, and reconstruct the weights so they sum to 1

source("03_load_packages.R")

#data <- readRDS("data/processed/frsclean_2020-22.rds")
data <- readRDS("5_ukmod_data_inputs/intermediate_data/frsclean_2018-22.rds")

data[is.na(bdimbwa), bdimbwa := 0]
data[is.na(bdiscwa), bdiscwa := 0]

#### MSK 

MSK_OOW_data <- data %>%
  filter(hcond3 == 1 | hcond4 == 1) %>%
  filter(les %in% c(5,7,8)) 

MSK_IW_data <- data %>%
  filter(hcond3 == 1 | hcond4 == 1) %>%
  filter(les %in% c(2,3)) 

MSK_IW_1yr_data <- data %>%
  filter(hcond3 == 1 | hcond4 == 1) %>%
  filter(les %in% c(2,3)) %>%
  filter(ldayswrk < 365) 

MSK_IW_1yr2_data <- data %>%
  filter(hcond3 == 1 | hcond4 == 1) %>%
  filter(les %in% c(2,3)) %>%
  filter(ldayswrk < 365) %>%
  filter(lprev == 2)

#### MH 

MH_OOW_data <- data %>%
  filter(hcond7 == 1) %>%
  filter(les %in% c(5,7,8)) 

MH_IW_data <- data %>%
  filter(hcond7 == 1) %>%
  filter(les %in% c(2,3)) 

MH_IW_1yr_data <- data %>%
  filter(hcond7 == 1) %>%
  filter(les %in% c(2,3)) %>%
  filter(ldayswrk < 365)

MH_IW_1yr2_data <- data %>%
  filter(hcond7 == 1) %>%
  filter(les %in% c(2,3)) %>%
  filter(ldayswrk < 365) %>%
  filter(lprev == 2)

#### MSK + MH

MSK_MH_OOW_data <- data %>%
  filter((hcond3 == 1 | hcond4 == 1) & hcond7 == 1) %>%
  filter(les %in% c(5,7,8)) 

MSK_MH_IW_data <- data %>%
  filter((hcond3 == 1 | hcond4 == 1) & hcond7 == 1) %>%
  filter(les %in% c(2,3)) 

MSK_MH_IW_1yr_data <- data %>%
  filter((hcond3 == 1 | hcond4 == 1) & hcond7 == 1) %>%
  filter(les %in% c(2,3))  %>%
  filter(ldayswrk < 365)

MSK_MH_IW_1yr2_data <- data %>%
  filter((hcond3 == 1 | hcond4 == 1) & hcond7 == 1) %>%
  filter(les %in% c(2,3))  %>%
  filter(ldayswrk < 365) %>%
  filter(lprev == 2)

##########################
## write out data files - a separate UKMOD model for each scenario, save directly to the Inputs 
## folder of the relevant model and name the data UK_2021_a1. Must write out as tab-delimited text
## files for UKMOD to be able to read the input

source("5_ukmod_data_inputs/R_scripts/5d_UKMOD_model_file_paths.R")

write_delim(MSK_OOW_data,     file = paste0(path, path_msk_oow,    "Input/UK_2021_a1.txt"), delim = "\t")
write_delim(MSK_IW_data,      file = paste0(path, path_msk_iw,     "Input/UK_2021_a1.txt"), delim = "\t")
write_delim(MSK_IW_1yr_data,  file = paste0(path, path_msk_iw_1yr, "Input/UK_2021_a1.txt"), delim = "\t")
write_delim(MSK_IW_1yr2_data, file = paste0(path, path_msk_iw_1yr_n, "Input/UK_2021_a1.txt"), delim = "\t")

write_delim(MH_OOW_data,      file = paste0(path, path_mh_oow,     "Input/UK_2021_a1.txt"), delim = "\t")
write_delim(MH_IW_data,       file = paste0(path, path_mh_iw,      "Input/UK_2021_a1.txt"), delim = "\t")
write_delim(MH_IW_1yr_data,   file = paste0(path, path_mh_iw_1yr,  "Input/UK_2021_a1.txt"), delim = "\t")
write_delim(MH_IW_1yr2_data,  file = paste0(path, path_mh_iw_1yr_n,  "Input/UK_2021_a1.txt"), delim = "\t")

write_delim(MSK_MH_OOW_data,     file = paste0(path, path_msk_mh_oow,     "Input/UK_2021_a1.txt"), delim = "\t")
write_delim(MSK_MH_IW_data,      file = paste0(path, path_msk_mh_iw,      "Input/UK_2021_a1.txt"), delim = "\t")
write_delim(MSK_MH_IW_1yr_data,  file = paste0(path, path_msk_mh_iw_1yr,  "Input/UK_2021_a1.txt"), delim = "\t")
write_delim(MSK_MH_IW_1yr2_data, file = paste0(path, path_msk_mh_iw_1yr_n,  "Input/UK_2021_a1.txt"), delim = "\t")

### get sample sizes 

MSK_OOW_sampsize     <- nrow(MSK_OOW_data)
MSK_IW_sampsize      <- nrow(MSK_IW_data)
MSK_IW_1yr_sampsize  <- nrow(MSK_IW_1yr_data)
MSK_IW_1yr2_sampsize <- nrow(MSK_IW_1yr2_data)

MH_OOW_sampsize      <- nrow(MH_OOW_data)
MH_IW_sampsize       <- nrow(MH_IW_data)
MH_IW_1yr_sampsize   <- nrow(MH_IW_1yr_data)
MH_IW_1yr2_sampsize  <- nrow(MH_IW_1yr2_data)

MSK_MH_OOW_sampsize     <- nrow(MSK_MH_OOW_data)
MSK_MH_IW_sampsize      <- nrow(MSK_MH_IW_data)
MSK_MH_IW_1yr_sampsize  <- nrow(MSK_MH_IW_1yr_data)
MSK_MH_IW_1yr2_sampsize <- nrow(MSK_MH_IW_1yr2_data)

sampsize_matrix <- matrix(c(MSK_OOW_sampsize, MSK_IW_sampsize, MSK_IW_1yr_sampsize, MSK_IW_1yr2_sampsize,
                            MH_OOW_sampsize,  MH_IW_sampsize,  MH_IW_1yr_sampsize, MH_IW_1yr2_sampsize,
                            MSK_MH_OOW_sampsize, MSK_MH_IW_sampsize, MSK_MH_IW_1yr_sampsize, MSK_MH_IW_1yr2_sampsize),
                          byrow = FALSE,
                          nrow = 4,
                          dimnames = list(c("Out-of-work","In-work","In-work (1yr)","In-work (1yr, nonemp)"),
                                          c("MSK","MH","MSK+MH")))

write.csv(sampsize_matrix, "5_ukmod_data_inputs/output/sampsize_matrix.csv")

### get population sizes 

MSK_OOW_popsize    <- sum(MSK_OOW_data$dwt)
MSK_IW_popsize     <- sum(MSK_IW_data$dwt)
MSK_IW_1yr_popsize <- sum(MSK_IW_1yr_data$dwt)

MH_OOW_popsize     <- sum(MH_OOW_data$dwt)
MH_IW_popsize      <- sum(MH_IW_data$dwt)
MH_IW_1yr_popsize  <- sum(MH_IW_1yr_data$dwt)

MSK_MH_OOW_popsize <- sum(MSK_MH_OOW_data$dwt)
MSK_MH_IW_popsize  <- sum(MSK_MH_IW_data$dwt)
MSK_MH_IW_1yr_popsize  <- sum(MSK_MH_IW_1yr_data$dwt)


popsize_matrix <- matrix(c(MSK_OOW_popsize, MSK_IW_popsize, MSK_IW_1yr_popsize,
                            MH_OOW_popsize,  MH_IW_popsize,  MH_IW_1yr_popsize,
                            MSK_MH_OOW_popsize, MSK_MH_IW_popsize, MSK_MH_IW_1yr_popsize),
                          byrow = FALSE,
                          nrow = 3,
                          dimnames = list(c("Out-of-work","In-work","In-work (1yr)"),
                                          c("MSK","MH","MSK+MH")))

rm(MSK_OOW_data, MSK_IW_data, MH_OOW_data, MH_IW_data, MSK_MH_OOW_data, MSK_MH_IW_data)

write.csv(popsize_matrix, "5_ukmod_data_inputs/output/popsize_matrix.csv")

rm(list = ls())
