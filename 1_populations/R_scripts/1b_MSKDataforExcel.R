#	Percentage reporting a long-term Musculoskeletal (MSK) problem for CBA model

rm(list = ls())

## read in full list of UTLAs (Dec 2022)

source("1_populations/R_scripts/1a_read_local_authorities.R")

############################################
### search area and parent area mappings ###

areaTypes <- area_types()

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
government <- 6

################## get data 


IndicatorID_93377ex<- fingertips_data(IndicatorID = 93377,
                                    AreaTypeID = 402,
                                    ParentAreaTypeID = parent)

##Only keeping Observations that are Counties and UAs

IndicatorID_93377ex = filter(IndicatorID_93377ex, AreaType== 'Counties & UAs (2021/22-2022/23)') %>%
  full_join(utla_data, by = c("AreaCode")) %>%
  arrange(UTLA22NM) %>% relocate(UTLA22NM)

##Only keeping data from most recent year

IndicatorID_93377ex <- filter(IndicatorID_93377ex, Timeperiod=='2022')


##Only keeping columns of 'AreaName, AreaCode, Value'

IndicatorID_93377ex = subset(IndicatorID_93377ex, select = c(AreaName, AreaCode, Value))


##Save Data 

saveRDS(IndicatorID_93377ex,"1_populations/intermediate_data/Percentage_reporting_a_longterm_MSK_problem_93377ex.rds")

write.csv(IndicatorID_93377ex, "1_populations/output/MSK_IndicatorID_93377ex.csv", row.names = FALSE)