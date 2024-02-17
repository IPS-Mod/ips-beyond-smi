#	Percentage reporting a long-term Musculoskeletal (MSK) problem for CBA model

rm(list = ls())

## read in full list of UTLAs (Dec 2022)

source("1_populations/R_scripts/1a_read_local_authorities.R")

#################################
### find the indicators we want

### opens an interactive window to search indicators with indicatorIDs:
#inds <- select_indicators()

### manually put into a vector (just to store the selected indicators)

indicators <- c(93495)  #Estimated prevalence of common mental disorders: % of population aged 16 and over
     

############################################
### search area and parent area mappings ###

#areaTypes <- area_types()

### AREATYPEID to use:
### LOCAL AREAS
# 102 - Upper tier local authorities (pre 4/19)
# 202 - Upper tier local authorities (4/19 - 3/20)
# 302 - Upper tier local authorities (4/20-3/21)
# 402 - Upper tier local authorities (post 4/21)

### PARENTAREATYPEID to use:
### REGIONS
# 6 - Government Office Region
# 15 - England

parent <- 15

###########################################
################## get data 

IndicatorID_93495_102 <- fingertips_data(IndicatorID = 93495,
                                         AreaTypeID = 102,
                                         ParentAreaTypeID = parent) %>%
  subset(select = c(IndicatorID, IndicatorName, AreaName, AreaCode, AreaType, 
                    Sex, Age, Timeperiod, Value, LowerCI95.0limit, UpperCI95.0limit, Count, Denominator)) %>%
  filter(AreaType== 'Counties & UAs (pre Apr 2019)') %>%
  arrange(AreaName)


IndicatorID_93495_101 <- fingertips_data(IndicatorID = 93495,
                                         AreaTypeID = 101,
                                         ParentAreaTypeID = parent) %>%
  subset(select = c(IndicatorID, IndicatorName, AreaName, AreaCode, AreaType, 
                    Sex, Age, Timeperiod, Value, LowerCI95.0limit, UpperCI95.0limit, Count, Denominator)) %>%
  filter(AreaType== 'Districts & UAs (pre Apr 2019)') %>% 
  arrange(AreaName)

####################################
##### Adjust to the post 2021 local authorities 
  
  ### ----- Bournemouth, Christchurch, and Poole --------###

        # take the mean prevalence in the ltla data
  
bcp <- IndicatorID_93495_101 %>%
  filter(AreaName %in% c("Bournemouth","Christchurch","Poole")) %>%
  summarize(bcp = mean(Value)) %>%
  as.numeric()

        # in the UTLA data, drop Poole, apply the overall prevalence to Bournemouth,
        # then rename and recode

IndicatorID_93495 = IndicatorID_93495_102 %>%
  filter(AreaName != "Poole") %>%
  mutate(Value = ifelse(AreaName == "Bournemouth", bcp, Value)) %>%
  mutate(AreaName = ifelse(AreaName == "Bournemouth", "Bournemouth, Christchurch and Poole", AreaName)) %>%
  mutate(AreaCode = ifelse(AreaCode == "E06000028", "E06000058", AreaCode)) %>%
  arrange(AreaName)

  ### ------- Update Buckinghamshire and Dorset -------- ###

IndicatorID_93495 = IndicatorID_93495 %>%
  mutate(AreaName = ifelse(AreaName == "Buckinghamshire", "Buckinghamshire UA", AreaName)) %>%
  mutate(AreaCode = ifelse(AreaCode == "E10000002", "E06000060", AreaCode)) %>%
  mutate(AreaName = ifelse(AreaName == "Dorset (Cty)", "Dorset", AreaName)) %>%
  mutate(AreaCode = ifelse(AreaCode == "E10000009", "E06000059", AreaCode)) %>%
  arrange(AreaName)

  ### ------- North and West Northamptonshire -------- ###

  ## take Northamptonshire, create a duplicate to create North and West Northamptonshire
  ##, then delete Northamptonshire from the original dataset and bind the new two areas

Northamptonshire <- IndicatorID_93495 %>%
  filter(AreaName == "Northamptonshire")

Northamptonshire2 <- Northamptonshire %>%
  mutate(AreaName = "North Northamptonshire") %>%
  mutate(AreaCode = "E06000061") %>%
  rbind(Northamptonshire) %>%
  mutate(AreaName = ifelse(AreaName == "Northamptonshire","West Northamptonshire",AreaName)) %>%
  mutate(AreaCode = ifelse(AreaCode == "E10000021", "E06000062", AreaCode))
  
IndicatorID_93495 <- IndicatorID_93495 %>%
  filter(AreaName != "Northamptonshire") %>%
  rbind(Northamptonshire2) %>%
  arrange(AreaName)


saveRDS(IndicatorID_93495,"1_populations/intermediate_data/Estimated_prevalence_of_common_mental_disorders_aged_16_93495.rds")

##########################
### Check the data merges properly to local authorities


IndicatorID_93495ex <- readRDS("1_populations/intermediate_data/Estimated_prevalence_of_common_mental_disorders_aged_16_93495.rds") %>%
  select(AreaName, AreaCode, Value) %>%
  rename(UTLA22NM = AreaName) %>%
  full_join(utla_data, by = c("AreaCode"))

IndicatorID_93495ex <- IndicatorID_93495ex %>%
  select(`UTLA22NM.x`,`AreaCode`,`Value`) %>%
  rename(UTLA22NM = `UTLA22NM.x`) %>%
  mutate(Value = Value/100)


write.csv(IndicatorID_93495ex, "1_populations/output/MH_IndicatorID_93495ex.csv", row.names = FALSE)

rm(list = ls())


