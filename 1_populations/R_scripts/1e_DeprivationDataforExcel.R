
### get UTLA deprivation deciles

dep <- deprivation_decile(AreaTypeID = 402, Year = 2019, proxy_settings = "default")

dep <- dep %>%
  mutate(quintile = case_match(decile,
                           c(1,2) ~ 1,
                           c(3,4) ~ 2,
                           c(5,6) ~ 3,
                           c(7,8) ~ 4,
                           c(9,10) ~ 5)) %>%
  mutate(quintile = case_match(quintile,
                               1 ~ 5,
                               2 ~ 4,
                               3 ~ 3,
                               4 ~ 2,
                               5 ~ 1)) %>%
  mutate(decile = case_match(decile,
                             1 ~ 10,
                             2 ~ 9,
                             3 ~ 8,
                             4 ~ 7,
                             5 ~ 6,
                             6 ~ 5,
                             7 ~ 4,
                             8 ~ 3,
                             9 ~ 2,
                             10 ~ 1))

saveRDS(dep,"1_populations/intermediate_data/IMD_deprivation_scores_UTLA.rds")

###########################################
## Plot heat maps of deprivation decile 

dep <- readRDS("1_populations/intermediate_data/IMD_deprivation_scores_UTLA.rds")


## map data

shapefile <- read_sf(dsn = "data/local_authorities/england_utla_shapefile/",
                     layer = "england_utla_2022")

deprivation <- dep %>% 
  rename("utla22cd" = "AreaCode") %>%
  mutate(quintile = factor(quintile, 
                           levels = 1:5,
                           labels = c("1 \n(least)","2","3","4","5 \n(most)")))

plot_data <- left_join(shapefile, deprivation, by = c("utla22cd")) 


imd <- ggplot(data = plot_data) +
  geom_sf(aes(geometry = geometry, fill = as.factor(quintile))) +
  theme_void() +
  scale_fill_manual(values = c("#4f000b","#720026","#ce4257","#ff7f51","#ff9b54")) +
  labs(fill = "IMD \nQuintile",
       subtitle = "")

##########################################################
### combine deprivation heatmap with prevalence heatmaps

### MSK prevalence

MSK_plot_data <- readRDS("1_populations/intermediate_data/Percentage_reporting_a_longterm_MSK_problem_93377ex.rds")

MSK_plot_data <- rename(MSK_plot_data, "utla22cd" = "AreaCode")

MSK_plot_data <- left_join(shapefile, MSK_plot_data, by = c("utla22cd")) 

msk <- ggplot(data = MSK_plot_data) +
  geom_sf(aes(geometry = geometry, fill = Value)) +
  theme_void() +
  scale_fill_gradient2(low = "#f07167", mid = "#fdfcdc", high = "#0081a7", 
                       na.value = "white", midpoint = median(MSK_plot_data$Value,na.rm = TRUE)) +
  labs(fill = "Prevalence \n(%)",
       subtitle = "")

### MH prevalence

MH_plot_data <- readRDS("1_populations/intermediate_data/Estimated_prevalence_of_common_mental_disorders_aged_16_93495.rds")

MH_plot_data <- rename(MH_plot_data, "utla22cd" = "AreaCode")

MH_plot_data <- left_join(shapefile, MH_plot_data, by = c("utla22cd")) 

mh <- ggplot(data = MH_plot_data) +
  geom_sf(aes(geometry = geometry, fill = Value)) +
  theme_void() +
  scale_fill_gradient2(low = "#f07167", mid = "#fdfcdc", high = "#0081a7", 
                       na.value = "white", midpoint = median(MH_plot_data$Value,na.rm = TRUE)) +
  labs(fill = "Prevalence \n(%)",
       subtitle = "")


### MSK and MH prevalence


both_plot_data <- readRDS("1_populations/intermediate_data/Estimated_prevalence_reporting_longterm_MSK_also_report_depression_anxiety_93372.rds")

both_plot_data <- rename(both_plot_data, "utla22cd" = "AreaCode")

both_plot_data <- left_join(shapefile, both_plot_data, by = c("utla22cd")) 

both <- ggplot(data = both_plot_data) +
  geom_sf(aes(geometry = geometry, fill = Value)) +
  theme_void() +
  scale_fill_gradient2(low = "#f07167", mid = "#fdfcdc", high = "#0081a7", 
                       na.value = "white", midpoint = median(both_plot_data$Value,na.rm = TRUE)) +
  labs(fill = "Prevalence \n(%)",
       subtitle = "")


### combine plot

ggarrange(msk, mh, both, imd,labels = c("Musculoskeletal (MSK)", 
                                        "Mental health (MH)",
                                        "Both (MSK + MH)",
                                        "Deprivation quintile"),
          ncol = 2, nrow = 2,  common.legend = FALSE, legend = "bottom")
ggsave("1_populations/output/all_conditions_imd.jpg", dpi = 600, units = "mm", width = 180)

