## The aim of this code is to calculate Non-employment rates of people with MSK
## and MH conditions

## read in data produced using hseclean
data <- readRDS("1_populations/intermediate_data/hse_cleaned_2018.rds")

## Calculate Non-employment rate for:
## (i) people with MSK conditions and no mental health conditions
## (ii) people with mental health conditions and no MSK conditions
## (iii) people with both
## (iv) general population

## ignore other health conditions

## Non-employment rate definition: NEET (not in education or employment in the last week)

##################################################
### Non-employment rates (all sexes and age groups)

#### MSK conditions

msk_all <- data %>%
  filter(hse_muscskel == 1) %>%
  summarise(unemp = weighted.mean(unempl_lstweek, w = wt_int)) %>%
  mutate(sex = "All",
         age_cat_new = "All",
         population = "MSK")

### MH conditions

mh_all <- data %>%
  filter(hse_mental == 1) %>%
  summarise(unemp = weighted.mean(unempl_lstweek, w = wt_int)) %>%
  mutate(sex = "All",
         age_cat_new = "All",
         population = "MH")

### MH and MSK conditions

msk_mh_all <- data %>%
  filter(hse_mental == 1 & hse_muscskel == 1) %>%
  summarise(unemp = weighted.mean(unempl_lstweek, w = wt_int)) %>%
  mutate(sex = "All",
         age_cat_new = "All",
         population = "MSK + MH")

### full population

pop_all <- data %>%
  summarise(unemp = weighted.mean(unempl_lstweek, w = wt_int)) %>%
  mutate(sex = "All",
         age_cat_new = "All",
         population = "Pop")

### Append 

all <- bind_rows(list(pop_all, msk_all, mh_all, msk_mh_all))
rm(pop_all, msk_all, mh_all, msk_mh_all)

all %>%
  pivot_wider(id_cols = c("sex","age_cat_new"), names_from = "population",values_from = "unemp") %>%
  select(Pop,MSK,MH,`MSK + MH`) %>%
  write.csv("1_populations/output/non_employment_rates.csv")

##################################################
### Non-employment rates (by age group)

#### MSK conditions

msk_all <- data %>%
  filter(hse_muscskel == 1) %>%
  group_by(age_cat_new) %>%
  summarise(unemp = weighted.mean(unempl_lstweek, w = wt_int)) %>%
  mutate(sex = "All",
         population = "MSK")

### MH conditions

mh_all <- data %>%
  filter(hse_mental == 1) %>%
  group_by(age_cat_new) %>%
  summarise(unemp = weighted.mean(unempl_lstweek, w = wt_int)) %>%
  mutate(sex = "All",
         population = "MH")

### MH and MSK conditions

msk_mh_all <- data %>%
  filter(hse_mental == 1 & hse_muscskel == 1) %>%
  group_by(age_cat_new) %>%
  summarise(unemp = weighted.mean(unempl_lstweek, w = wt_int)) %>%
  mutate(sex = "All",
         population = "MSK + MH")

### full population

pop_all <- data %>%
  group_by(age_cat_new) %>%
  summarise(unemp = weighted.mean(unempl_lstweek, w = wt_int)) %>%
  mutate(sex = "All",
         population = "Pop")

### Append 

age_group <- bind_rows(list(pop_all, msk_all, mh_all, msk_mh_all))
rm(pop_all, msk_all, mh_all, msk_mh_all)

##################################################
### Non-employment rates (by sex)

#### MSK conditions

msk_all <- data %>%
  filter(hse_muscskel == 1) %>%
  group_by(sex) %>%
  summarise(unemp = weighted.mean(unempl_lstweek, w = wt_int)) %>%
  mutate(age_cat_new = "All",
         population = "MSK")

### MH conditions

mh_all <- data %>%
  filter(hse_mental == 1) %>%
  group_by(sex) %>%
  summarise(unemp = weighted.mean(unempl_lstweek, w = wt_int)) %>%
  mutate(age_cat_new = "All",
         population = "MH")

### MH and MSK conditions

msk_mh_all <- data %>%
  filter(hse_mental == 1 & hse_muscskel == 1) %>%
  group_by(sex) %>%
  summarise(unemp = weighted.mean(unempl_lstweek, w = wt_int)) %>%
  mutate(age_cat_new = "All",
         population = "MSK + MH")

### full population

pop_all <- data %>%
  group_by(sex) %>%
  summarise(unemp = weighted.mean(unempl_lstweek, w = wt_int)) %>%
  mutate(age_cat_new = "All",
         population = "Pop")

### Append 

sex_group <- bind_rows(list(pop_all, msk_all, mh_all, msk_mh_all))
rm(pop_all, msk_all, mh_all, msk_mh_all)

##################################################
### Non-employment rates (by imd_quintile)

#### MSK conditions

msk_all <- data %>%
  filter(hse_muscskel == 1) %>%
  group_by(imd_quintile) %>%
  summarise(unemp = weighted.mean(unempl_lstweek, w = wt_int)) %>%
  mutate(age_cat = "All",
         population = "MSK")

### MH conditions

mh_all <- data %>%
  filter(hse_mental == 1) %>%
  group_by(imd_quintile) %>%
  summarise(unemp = weighted.mean(unempl_lstweek, w = wt_int)) %>%
  mutate(age_cat = "All",
         population = "MH")

### MH and MSK conditions

msk_mh_all <- data %>%
  filter(hse_mental == 1 & hse_muscskel == 1) %>%
  group_by(imd_quintile) %>%
  summarise(unemp = weighted.mean(unempl_lstweek, w = wt_int)) %>%
  mutate(age_cat = "All",
         population = "MSK + MH")

### full population

pop_all <- data %>%
  group_by(imd_quintile) %>%
  summarise(unemp = weighted.mean(unempl_lstweek, w = wt_int)) %>%
  mutate(age_cat = "All",
         population = "Pop")

### Append 

imd_quintile_group <- bind_rows(list(pop_all, msk_all, mh_all, msk_mh_all))
rm(pop_all, msk_all, mh_all, msk_mh_all)

##################################################
### Non-employment rates (by ethnicity_2cat)

#### MSK conditions

msk_all <- data %>%
  filter(hse_muscskel == 1) %>%
  group_by(ethnicity_2cat) %>%
  summarise(unemp = weighted.mean(unempl_lstweek, w = wt_int)) %>%
  mutate(age_cat = "All",
         population = "MSK")

### MH conditions

mh_all <- data %>%
  filter(hse_mental == 1) %>%
  group_by(ethnicity_2cat) %>%
  summarise(unemp = weighted.mean(unempl_lstweek, w = wt_int)) %>%
  mutate(age_cat = "All",
         population = "MH")

### MH and MSK conditions

msk_mh_all <- data %>%
  filter(hse_mental == 1 & hse_muscskel == 1) %>%
  group_by(ethnicity_2cat) %>%
  summarise(unemp = weighted.mean(unempl_lstweek, w = wt_int)) %>%
  mutate(age_cat = "All",
         population = "MSK + MH")

### full population

pop_all <- data %>%
  group_by(ethnicity_2cat) %>%
  summarise(unemp = weighted.mean(unempl_lstweek, w = wt_int)) %>%
  mutate(age_cat = "All",
         population = "Pop")

### Append 

ethnicity_2cat_group <- bind_rows(list(pop_all, msk_all, mh_all, msk_mh_all))
rm(pop_all, msk_all, mh_all, msk_mh_all)

##########################################################
##### Plot the non-employment rates ######################


######################################
## Plot the overall Non-employment rates

all %>% 
  mutate(population = factor(population,
                             levels = c("Pop","MSK","MH","MSK + MH"))) %>%
  ggplot() +
  aes(x = population, y = unemp, fill = population) +
  geom_bar(stat = "identity", position = "dodge") +
  theme_classic() +
  labs(y = "Non-employment rate",
       x = "Population",
       fill = "",
       caption = "Pop = All population, MSK = Musculoskeletal conditions, MH = Mental health conditions") +
  scale_y_continuous(breaks = seq(0,1,0.05), 
                     minor_breaks = NULL,
                     labels = scales::percent_format(scale = 100)) +
  scale_fill_manual(values = c("#001219","#219ebc","#fca311","#9a031e")) +
  theme(legend.position = "none")
ggsave("1_populations/output/nonemp_rate_all.jpg")

######################################
## Plot the unemployment rates by sex

sex_group %>% 
  mutate(population = factor(population,
                             levels = c("Pop","MSK","MH","MSK + MH"))) %>%
  ggplot() +
  aes(x = sex, y = unemp, fill = population) +
  geom_bar(stat = "identity", position = "dodge") +
  theme_classic() +
  labs(y = "Non-employment rate",
       x = "",
       fill = "",
       caption = "Pop = All population, MSK = Musculoskeletal conditions, MH = Mental health conditions") +
  scale_y_continuous(breaks = seq(0,1,0.05), 
                     minor_breaks = NULL,
                     labels = scales::percent_format(scale = 100)) +
  scale_fill_manual(values = c("#001219","#219ebc","#fca311","#9a031e"))
  ggsave("1_populations/output/nonemp_rate_sex.jpg")


######################################
## Plot the unemployment rates by age

age_group %>% 
  mutate(population = factor(population,
                             levels = c("Pop","MSK","MH","MSK + MH"))) %>%
  ggplot() +
  aes(x = age_cat_new, y = unemp, fill = population) +
  geom_bar(stat = "identity", position = "dodge") +
  theme_classic() +
  labs(y = "Non-employment rate",
       x = "Age category",
       fill = "",
       caption = "Pop = All population, MSK = Musculoskeletal conditions, MH = Mental health conditions") +
  scale_y_continuous(breaks = seq(0,1,0.05), 
                     minor_breaks = NULL,
                     labels = scales::percent_format(scale = 100)) +
  scale_fill_manual(values = c("#001219","#219ebc","#fca311","#9a031e"))
  ggsave("1_populations/output/nonemp_rate_age.jpg")

######################################
## Plot the unemployment rates by imd_quintile

imd_quintile_group['imd_quintile'][imd_quintile_group['imd_quintile'] == '1_least_deprived'] <- '1 \n(least)'

imd_quintile_group['imd_quintile'][imd_quintile_group['imd_quintile'] == '5_most_deprived'] <- '5 \n(most)'

imd_quintile_group %>% 
  mutate(population = factor(population,
                             levels = c("Pop","MSK","MH","MSK + MH"))) %>%
  ggplot() +
  aes(x = imd_quintile, y = unemp, fill = population) +
  geom_bar(stat = "identity", position = "dodge") +
  theme_classic() +
  labs(y = "Non-employment rate",
       x = "",
       fill = "",
       caption = "Pop = All population, MSK = Musculoskeletal conditions, MH = Mental health conditions") +
  scale_y_continuous(breaks = seq(0,1,0.05), 
                     minor_breaks = NULL,
                     labels = scales::percent_format(scale = 100)) +
  scale_fill_manual(values = c("#001219","#219ebc","#fca311","#9a031e")) 
  ggsave("1_populations/output/nonemp_rate_imd_quintile.jpg")


#######################################################
## Plot the non-employment rates by ethnicity_2cat

ethnicity_2cat_group <- ethnicity_2cat_group %>% drop_na(ethnicity_2cat)

ethnicity_2cat_group['ethnicity_2cat'][ethnicity_2cat_group['ethnicity_2cat'] == 'non_white'] <- 'non white'


ethnicity_2cat_group %>% 
  mutate(population = factor(population,
                             levels = c("Pop","MSK","MH","MSK + MH"))) %>%
  ggplot() +
  aes(x = ethnicity_2cat, y = unemp, fill = population) +
  geom_bar(stat = "identity", position = "dodge") +
  theme_classic() +
  labs(y = "Non-employment rate",
       x = "",
       fill = "",
       caption = "Pop = All population, MSK = Musculoskeletal conditions, MH = Mental health conditions") +
  scale_y_continuous(breaks = seq(0,1,0.05), 
                     minor_breaks = NULL,
                     labels = scales::percent_format(scale = 100)) +
  scale_fill_manual(values = c("#001219","#219ebc","#fca311","#9a031e")) 
  ggsave("1_populations/output/nonemp_rate_ethnicity_2cat.jpg")
