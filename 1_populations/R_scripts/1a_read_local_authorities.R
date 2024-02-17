source("03_load_packages.R")

## Read in full list of upper tier local authorities (as of Dec 2022)
## Obtained from:
## https://geoportal.statistics.gov.uk/datasets/ons::upper-tier-local-authorities-dec-2022-names-and-codes-in-the-united-kingdom/explore

utla_data <- read.csv("data/local_authorities/Upper_Tier_Local_Authorities_(Dec_2022)_Names_and_Codes_in_the_United_Kingdom.csv")

## filter English local authorities by dropping any codes that don't start with "E"
## select only area code and name variables
## arrange rows by area name

utla_data <- utla_data %>%
  filter(substr(UTLA22CD,1,1) == "E") %>%
  select(UTLA22CD,UTLA22NM) %>%
  arrange(UTLA22NM) %>%
  rename(AreaCode = UTLA22CD)

saveRDS(utla_data, "1_populations/intermediate_data/local_authorities.rds")
write.csv(utla_data, "1_populations/intermediate_data/local_authorities.csv")