
source("5_ukmod_data_inputs/R_scripts/5d_UKMOD_model_file_paths.R")

## variables to retain from the microsimulation:
##
## ils_origy: original/market income
## ils_ben : all benefits (pensions + means-tested non-pension + non-means tested non_pension)
##                        (ils_pen + ils_benmt + ils_bennt)
## ils_tax : direct taxes (council tax and personal income tax)
## ils_sicdy : all employee/self-employed/other national insurance contributions
## ils_dispy : ils_origy + ils_ben - ils_tax - ils_sicdy

## ils_earns: (earnings from employment/self-employment, part of ils_origy)
## ils_sicer: employer national insurance contributions


######################
### MUSCULOSELETAL ###

MSK_OOW_data <- read_delim(file = paste0(path, path_msk_oow,    "Output/en_2023_std.txt")) %>%
  select(ils_origy, ils_ben, ils_pen, ils_benmt, ils_bennt, ils_tax, ils_sicdy, ils_sicer, ils_dispy, ils_earns, dwt) %>%
  summarise(ils_origy = weighted.mean(ils_origy, w = dwt),
            ils_ben = weighted.mean(ils_ben, w = dwt),
            ils_pen = weighted.mean(ils_pen, w = dwt),
            ils_benmt = weighted.mean(ils_benmt, w = dwt),
            ils_bennt = weighted.mean(ils_bennt, w = dwt),
            ils_tax = weighted.mean(ils_tax, w = dwt),
            ils_sicdy = weighted.mean(ils_sicdy, w = dwt),
            ils_dispy = weighted.mean(ils_dispy, w = dwt),
            ils_earns = weighted.mean(ils_earns, w = dwt),
            ils_sicer = weighted.mean(ils_sicer, w = dwt))


MSK_IW_data  <- read_delim(file = paste0(path, path_msk_iw,     "Output/en_2023_std.txt")) %>%
  select(ils_origy, ils_ben, ils_pen, ils_benmt, ils_bennt, ils_tax, ils_sicdy, ils_sicer, ils_dispy, ils_earns, dwt) %>%
  summarise(ils_origy = weighted.mean(ils_origy, w = dwt),
            ils_ben = weighted.mean(ils_ben, w = dwt),
            ils_pen = weighted.mean(ils_pen, w = dwt),
            ils_benmt = weighted.mean(ils_benmt, w = dwt),
            ils_bennt = weighted.mean(ils_bennt, w = dwt),
            ils_tax = weighted.mean(ils_tax, w = dwt),
            ils_sicdy = weighted.mean(ils_sicdy, w = dwt),
            ils_dispy = weighted.mean(ils_dispy, w = dwt),
            ils_earns = weighted.mean(ils_earns, w = dwt),
            ils_sicer = weighted.mean(ils_sicer, w = dwt))

MSK_IW_1yr_data  <- read_delim(file = paste0(path, path_msk_iw_1yr,     "Output/en_2023_std.txt")) %>%
  select(ils_origy, ils_ben, ils_pen, ils_benmt, ils_bennt, ils_tax, ils_sicdy, ils_sicer, ils_dispy, ils_earns, dwt) %>%
  summarise(ils_origy = weighted.mean(ils_origy, w = dwt),
            ils_ben = weighted.mean(ils_ben, w = dwt),
            ils_pen = weighted.mean(ils_pen, w = dwt),
            ils_benmt = weighted.mean(ils_benmt, w = dwt),
            ils_bennt = weighted.mean(ils_bennt, w = dwt),
            ils_tax = weighted.mean(ils_tax, w = dwt),
            ils_sicdy = weighted.mean(ils_sicdy, w = dwt),
            ils_dispy = weighted.mean(ils_dispy, w = dwt),
            ils_earns = weighted.mean(ils_earns, w = dwt),
            ils_sicer = weighted.mean(ils_sicer, w = dwt))

MSK_IW_1yr2_data  <- read_delim(file = paste0(path, path_msk_iw_1yr_n,     "Output/en_2023_std.txt")) %>%
  select(ils_origy, ils_ben, ils_pen, ils_benmt, ils_bennt, ils_tax, ils_sicdy, ils_sicer, ils_dispy, ils_earns, dwt) %>%
  summarise(ils_origy = weighted.mean(ils_origy, w = dwt),
            ils_ben = weighted.mean(ils_ben, w = dwt),
            ils_pen = weighted.mean(ils_pen, w = dwt),
            ils_benmt = weighted.mean(ils_benmt, w = dwt),
            ils_bennt = weighted.mean(ils_bennt, w = dwt),
            ils_tax = weighted.mean(ils_tax, w = dwt),
            ils_sicdy = weighted.mean(ils_sicdy, w = dwt),
            ils_dispy = weighted.mean(ils_dispy, w = dwt),
            ils_earns = weighted.mean(ils_earns, w = dwt),
            ils_sicer = weighted.mean(ils_sicer, w = dwt))

#####################
### MENTAL HEALTH ###

MH_OOW_data <- read_delim(file = paste0(path, path_mh_oow,    "Output/en_2023_std.txt")) %>%
  select(ils_origy, ils_ben, ils_pen, ils_benmt, ils_bennt, ils_tax, ils_sicdy, ils_sicer, ils_dispy, ils_earns, dwt) %>%
  summarise(ils_origy = weighted.mean(ils_origy, w = dwt),
            ils_ben = weighted.mean(ils_ben, w = dwt),
            ils_pen = weighted.mean(ils_pen, w = dwt),
            ils_benmt = weighted.mean(ils_benmt, w = dwt),
            ils_bennt = weighted.mean(ils_bennt, w = dwt),
            ils_tax = weighted.mean(ils_tax, w = dwt),
            ils_sicdy = weighted.mean(ils_sicdy, w = dwt),
            ils_dispy = weighted.mean(ils_dispy, w = dwt),
            ils_earns = weighted.mean(ils_earns, w = dwt),
            ils_sicer = weighted.mean(ils_sicer, w = dwt))


MH_IW_data  <- read_delim(file = paste0(path, path_mh_iw,     "Output/en_2023_std.txt")) %>%
  select(ils_origy, ils_ben, ils_pen, ils_benmt, ils_bennt, ils_tax, ils_sicdy, ils_sicer, ils_dispy, ils_earns, dwt) %>%
  summarise(ils_origy = weighted.mean(ils_origy, w = dwt),
            ils_ben = weighted.mean(ils_ben, w = dwt),
            ils_pen = weighted.mean(ils_pen, w = dwt),
            ils_benmt = weighted.mean(ils_benmt, w = dwt),
            ils_bennt = weighted.mean(ils_bennt, w = dwt),
            ils_tax = weighted.mean(ils_tax, w = dwt),
            ils_sicdy = weighted.mean(ils_sicdy, w = dwt),
            ils_dispy = weighted.mean(ils_dispy, w = dwt),
            ils_earns = weighted.mean(ils_earns, w = dwt),
            ils_sicer = weighted.mean(ils_sicer, w = dwt))

MH_IW_1yr_data  <- read_delim(file = paste0(path, path_mh_iw_1yr,     "Output/en_2023_std.txt")) %>%
  select(ils_origy, ils_ben, ils_pen, ils_benmt, ils_bennt, ils_tax, ils_sicdy, ils_sicer, ils_dispy, ils_earns, dwt) %>%
  summarise(ils_origy = weighted.mean(ils_origy, w = dwt),
            ils_ben = weighted.mean(ils_ben, w = dwt),
            ils_pen = weighted.mean(ils_pen, w = dwt),
            ils_benmt = weighted.mean(ils_benmt, w = dwt),
            ils_bennt = weighted.mean(ils_bennt, w = dwt),
            ils_tax = weighted.mean(ils_tax, w = dwt),
            ils_sicdy = weighted.mean(ils_sicdy, w = dwt),
            ils_dispy = weighted.mean(ils_dispy, w = dwt),
            ils_earns = weighted.mean(ils_earns, w = dwt),
            ils_sicer = weighted.mean(ils_sicer, w = dwt))

MH_IW_1yr2_data  <- read_delim(file = paste0(path, path_mh_iw_1yr_n,     "Output/en_2023_std.txt")) %>%
  select(ils_origy, ils_ben, ils_pen, ils_benmt, ils_bennt, ils_tax, ils_sicdy, ils_sicer, ils_dispy, ils_earns, dwt) %>%
  summarise(ils_origy = weighted.mean(ils_origy, w = dwt),
            ils_ben = weighted.mean(ils_ben, w = dwt),
            ils_pen = weighted.mean(ils_pen, w = dwt),
            ils_benmt = weighted.mean(ils_benmt, w = dwt),
            ils_bennt = weighted.mean(ils_bennt, w = dwt),
            ils_tax = weighted.mean(ils_tax, w = dwt),
            ils_sicdy = weighted.mean(ils_sicdy, w = dwt),
            ils_dispy = weighted.mean(ils_dispy, w = dwt),
            ils_earns = weighted.mean(ils_earns, w = dwt),
            ils_sicer = weighted.mean(ils_sicer, w = dwt))

#########################################
### MUSCULOSKELETAL AND MENTAL HEALTH ###

BOTH_OOW_data <- read_delim(file = paste0(path, path_msk_mh_oow,    "Output/en_2023_std.txt")) %>%
  select(ils_origy, ils_ben, ils_pen, ils_benmt, ils_bennt, ils_tax, ils_sicdy, ils_sicer, ils_dispy, ils_earns, dwt) %>%
  summarise(ils_origy = weighted.mean(ils_origy, w = dwt),
            ils_ben = weighted.mean(ils_ben, w = dwt),
            ils_pen = weighted.mean(ils_pen, w = dwt),
            ils_benmt = weighted.mean(ils_benmt, w = dwt),
            ils_bennt = weighted.mean(ils_bennt, w = dwt),
            ils_tax = weighted.mean(ils_tax, w = dwt),
            ils_sicdy = weighted.mean(ils_sicdy, w = dwt),
            ils_dispy = weighted.mean(ils_dispy, w = dwt),
            ils_earns = weighted.mean(ils_earns, w = dwt),
            ils_sicer = weighted.mean(ils_sicer, w = dwt))


BOTH_IW_data  <- read_delim(file = paste0(path, path_msk_mh_iw,     "Output/en_2023_std.txt")) %>%
  select(ils_origy, ils_ben, ils_pen, ils_benmt, ils_bennt, ils_tax, ils_sicdy, ils_sicer, ils_dispy, ils_earns, dwt) %>%
  summarise(ils_origy = weighted.mean(ils_origy, w = dwt),
            ils_ben = weighted.mean(ils_ben, w = dwt),
            ils_pen = weighted.mean(ils_pen, w = dwt),
            ils_benmt = weighted.mean(ils_benmt, w = dwt),
            ils_bennt = weighted.mean(ils_bennt, w = dwt),
            ils_tax = weighted.mean(ils_tax, w = dwt),
            ils_sicdy = weighted.mean(ils_sicdy, w = dwt),
            ils_dispy = weighted.mean(ils_dispy, w = dwt),
            ils_earns = weighted.mean(ils_earns, w = dwt),
            ils_sicer = weighted.mean(ils_sicer, w = dwt))

BOTH_IW_1yr_data  <- read_delim(file = paste0(path, path_msk_mh_iw_1yr,     "Output/en_2023_std.txt")) %>%
  select(ils_origy, ils_ben, ils_pen, ils_benmt, ils_bennt, ils_tax, ils_sicdy, ils_sicer, ils_dispy, ils_earns, dwt) %>%
  summarise(ils_origy = weighted.mean(ils_origy, w = dwt),
            ils_ben = weighted.mean(ils_ben, w = dwt),
            ils_pen = weighted.mean(ils_pen, w = dwt),
            ils_benmt = weighted.mean(ils_benmt, w = dwt),
            ils_bennt = weighted.mean(ils_bennt, w = dwt),
            ils_tax = weighted.mean(ils_tax, w = dwt),
            ils_sicdy = weighted.mean(ils_sicdy, w = dwt),
            ils_dispy = weighted.mean(ils_dispy, w = dwt),
            ils_earns = weighted.mean(ils_earns, w = dwt),
            ils_sicer = weighted.mean(ils_sicer, w = dwt))

BOTH_IW_1yr2_data  <- read_delim(file = paste0(path, path_msk_mh_iw_1yr_n,     "Output/en_2023_std.txt")) %>%
  select(ils_origy, ils_ben, ils_pen, ils_benmt, ils_bennt, ils_tax, ils_sicdy, ils_sicer, ils_dispy, ils_earns, dwt) %>%
  summarise(ils_origy = weighted.mean(ils_origy, w = dwt),
            ils_ben = weighted.mean(ils_ben, w = dwt),
            ils_pen = weighted.mean(ils_pen, w = dwt),
            ils_benmt = weighted.mean(ils_benmt, w = dwt),
            ils_bennt = weighted.mean(ils_bennt, w = dwt),
            ils_tax = weighted.mean(ils_tax, w = dwt),
            ils_sicdy = weighted.mean(ils_sicdy, w = dwt),
            ils_dispy = weighted.mean(ils_dispy, w = dwt),
            ils_earns = weighted.mean(ils_earns, w = dwt),
            ils_sicer = weighted.mean(ils_sicer, w = dwt))

##### bind data together and write out to template

out_data <- rbindlist(list(MSK_OOW_data, MSK_IW_data, MSK_IW_1yr_data, MSK_IW_1yr2_data,
                           MH_OOW_data, MH_IW_data, MH_IW_1yr_data, MH_IW_1yr2_data,
                           BOTH_OOW_data, BOTH_IW_data, BOTH_IW_1yr_data, BOTH_IW_1yr2_data))

wb <- openxlsx::loadWorkbook("5_ukmod_data_inputs/intermediate_data/UKMOD_output_template.xlsx")

openxlsx::writeData(wb,
                    x = out_data,
                    sheet = "UKMOD",
                    startCol = 4,
                    startRow = 6,
                    colNames = FALSE)

saveWorkbook(wb,paste0("5_ukmod_data_inputs/output/UKMOD_output.xlsx"), overwrite = T)

