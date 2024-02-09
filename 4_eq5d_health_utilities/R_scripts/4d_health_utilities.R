## read in data produced using hseclean and calculate the health utilities by 
## health condition for those not in employment. Then calculate the health 
## utilities in employment using the coefficients from the Understanding Society analysis

source("03_load_packages.R")

data <- readRDS("4_eq5d_health_utilities/intermediate_data/hse_cleaned_2018.rds")

################################################################
## construct EQ-5D utilities for health survey for england data

scores.df <- data.frame(
  MO = data$MO_3l,
  SC = data$SC_3l,
  UA = data$UA_3l,
  PD = data$PA_3l,
  AD = data$AD_3l)

eq5d_3l_utility <- eq5d::eq5d(scores.df, 
                              version = "3L",
                              type = "TTO", 
                              country = "UK",
                              ignore.invalid = TRUE)

scores.df <- data.frame(
  MO = data$MO_5l,
  SC = data$SC_5l,
  UA = data$UA_5l,
  PD = data$PA_5l,
  AD = data$AD_5l)

eq5d_5l_utility <- eq5d::eq5d(scores.df, 
                              version = "5L",
                              type = "CW", 
                              country = "UK",
                              ignore.invalid = TRUE)

data <- data %>%
  mutate(eq5d_3l = eq5d_3l_utility,
         eq5d_5l = eq5d_5l_utility)

rm(scores.df)

data %>%
  select(hse_id,eq5d_3l,eq5d_5l) %>%
  pivot_longer(cols = c("eq5d_3l","eq5d_5l"), names_to = "EQ5D", values_to = "utility") %>%
  mutate(EQ5D = factor(EQ5D, levels = c("eq5d_3l","eq5d_5l"), labels = c("EQ-5D-3L","EQ-5D-5L"))) %>%
ggplot() +
  geom_density(aes(x = utility, fill = EQ5D), alpha = 0.2) +
  theme_classic() +
  labs(y = "", x = "EQ-5D Utility", fill = "EQ-5D version")

#######################################################
### Calculate mean EQ-5D utility for the non-employed

msk <- data %>%
  filter(hse_muscskel == 1 & unempl_lstweek == 1) %>%
  summarise(eq5d_3l = weighted.mean(eq5d_3l, w = wt_int, na.rm = TRUE),
            eq5d_5l = weighted.mean(eq5d_5l, w = wt_int, na.rm = TRUE)) %>%
  mutate(population = "MSK")

mh <- data %>%
  filter(hse_mental == 1 & unempl_lstweek == 1) %>%
  summarise(eq5d_3l = weighted.mean(eq5d_3l, w = wt_int, na.rm = TRUE),
            eq5d_5l = weighted.mean(eq5d_5l, w = wt_int, na.rm = TRUE)) %>%
  mutate(population = "MH")

mh_msk <- data %>%
  filter(hse_mental == 1 & hse_muscskel == 1 & unempl_lstweek == 1) %>%
  summarise(eq5d_3l = weighted.mean(eq5d_3l, w = wt_int, na.rm = TRUE),
            eq5d_5l = weighted.mean(eq5d_5l, w = wt_int, na.rm = TRUE)) %>%
  mutate(population = "MH+MSK")

################################################################################
## Combine datasets and apply USoc regression coefficients for in-work utilities

usoc_regs <- readRDS("4_eq5d_health_utilities/intermediate_data/USoc_eq5d_empl_coefs.rds")
usoc_regs_interaction <- readRDS("4_eq5d_health_utilities/intermediate_data/USoc_eq5d_empl_coefs_interaction.rds")

### use plm1 from the regression script

beta <- usoc_regs["Fixed Effects","b"]

utilities_5l <- rbind(msk ,mh, mh_msk) %>%
  select(population, eq5d_5l) %>%
  rename(`oow` = `eq5d_5l`) %>%
  mutate(iw = oow + beta)

utilities_3l <- rbind(msk ,mh, mh_msk) %>%
  select(population, eq5d_3l) %>%
  rename(`oow` = `eq5d_3l`) %>%
  mutate(iw = oow + beta)


write.csv(utilities_5l,"4_eq5d_health_utilities/output/eq5d5l-health-utilities-v1.csv")
write.csv(utilities_3l,"4_eq5d_health_utilities/output/eq5d3l-health-utilities-v1.csv")

### use plm3 from the regression script - allows beta to depend on level of EQ5D

beta1 <- as.numeric(usoc_regs_interaction["employedemployed"])
beta2 <- as.numeric(usoc_regs_interaction["employedemployed:l.h_eq5d_score"])

utilities_5l <- rbind(msk ,mh, mh_msk) %>%
  select(population, eq5d_5l) %>%
  rename(`oow` = `eq5d_5l`) %>%
  mutate(iw = oow + (beta1 + beta2*oow))

utilities_3l <- rbind(msk ,mh, mh_msk) %>%
  select(population, eq5d_3l) %>%
  rename(`oow` = `eq5d_3l`) %>%
  mutate(iw = oow + (beta1 + beta2*oow))


write.csv(utilities_5l,"4_eq5d_health_utilities/output/eq5d5l-health-utilities-v2.csv")
write.csv(utilities_3l,"4_eq5d_health_utilities/output/eq5d3l-health-utilities-v2.csv")

