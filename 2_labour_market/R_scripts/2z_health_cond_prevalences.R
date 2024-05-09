
source("03_load_packages.R")

data <- readRDS("2_labour_market/intermediate_data/lfs_cross_sectional_2015_2023_cleaned.rds")

### get regional prevalences using pooled data from 2020-23
### order by MSK prevalence adjust ordering of the factor variable

prevalences_region <- data %>%
  filter(d_age %in% 16:64,
         !(d_region %in% c("wales","scotland","northern_ireland")),
         year %in% 2020:2023) %>%
  mutate(h_msk_and_mh = ifelse(h_musculoskeletal == 1 & h_mental_health == 1, 1, 0)) %>%
  group_by(d_region) %>%
  summarise(prev_msk    = weighted.mean(h_musculoskeletal, w = pwt, na.rm = TRUE),
            prev_mh     = weighted.mean(h_mental_health, w = pwt, na.rm = TRUE),
            prev_msk_mh = weighted.mean(h_msk_and_mh, w = pwt, na.rm = TRUE)) %>%
  ungroup() %>%
  arrange(prev_msk)

prevalences <- data %>%
  filter(d_age %in% 16:64,
         !(d_region %in% c("wales","scotland","northern_ireland")),
         year %in% 2020:2023) %>%
  mutate(h_msk_and_mh = ifelse(h_musculoskeletal == 1 & h_mental_health == 1, 1, 0)) %>%
  summarise(prev_msk    = weighted.mean(h_musculoskeletal, w = pwt, na.rm = TRUE),
            prev_mh     = weighted.mean(h_mental_health, w = pwt, na.rm = TRUE),
            prev_msk_mh = weighted.mean(h_msk_and_mh, w = pwt, na.rm = TRUE)) %>%
  ungroup() 

prev_out <- rbindlist(list(prevalences, prevalences_region), fill = TRUE)


write.csv(prevalences_region,"2_labour_market/output/prevalence_region_2020to24.csv")

ordering <- as.character(prevalences_region$d_region)

### get prevalences by year, aggregate and by region.
### re-factorise the regions by the "ordering" object created above


# aggregate

prevalences_year <- data %>%
  filter(d_age %in% 16:64,
         !(d_region %in% c("wales","scotland","northern_ireland"))) %>%
  mutate(h_msk_and_mh = ifelse(h_musculoskeletal == 1 & h_mental_health == 1, 1, 0)) %>%
  group_by(year) %>%
  summarise(prev_msk    = weighted.mean(h_musculoskeletal, w = pwt, na.rm = TRUE),
            prev_mh     = weighted.mean(h_mental_health, w = pwt, na.rm = TRUE),
            prev_msk_mh = weighted.mean(h_msk_and_mh, w = pwt, na.rm = TRUE))  %>%
  ungroup() %>%
  pivot_longer(cols = c("prev_msk","prev_mh","prev_msk_mh"), 
               names_to = "condition", values_to = "prev_England") %>%
  mutate(condition = factor(condition,
                            levels = c("prev_msk","prev_mh","prev_msk_mh"),
                            labels = c("Musculoskeletal","Mental Health","Both"))) 

# by region

prevalences_region_year <- data %>%
  filter(d_age %in% 16:64,
         !(d_region %in% c("wales","scotland","northern_ireland"))) %>%
  mutate(h_msk_and_mh = ifelse(h_musculoskeletal == 1 & h_mental_health == 1, 1, 0)) %>%
  group_by(d_region, year) %>%
  summarise(prev_msk    = weighted.mean(h_musculoskeletal, w = pwt, na.rm = TRUE),
            prev_mh     = weighted.mean(h_mental_health, w = pwt, na.rm = TRUE),
            prev_msk_mh = weighted.mean(h_msk_and_mh, w = pwt, na.rm = TRUE)) %>%
  ungroup() %>%
  pivot_longer(cols = c("prev_msk","prev_mh","prev_msk_mh"), 
               names_to = "condition", values_to = "prev") %>%
  mutate(condition = factor(condition,
                            levels = c("prev_msk","prev_mh","prev_msk_mh"),
                            labels = c("Musculoskeletal","Mental Health","Both"))) %>%
  left_join(prevalences_year, by = c("year","condition")) %>%
  mutate(region_new = factor(d_region,
                             levels = ordering)) %>%
  arrange(region_new)
  
  
  




ggplot(prevalences_region_year) + 
  facet_wrap(~condition) +
  geom_line(aes(x = year, y = prev, color = region_new),linewidth = 1, linetype = 2) +
  geom_line(aes(x = year, y = prev_England), linewidth = 1.5) +
  theme_minimal() +
  scale_y_continuous(breaks = seq(0.03,0.21,0.02), labels = scales::percent) +
  scale_x_continuous(breaks = seq(2015,2023,2), minor_breaks = NULL) +
  labs(y = "Prevalence",
       x = "",
       color = "Region",
       caption = "Note: solid black line shows the overall England prevalence") +
  scale_color_manual(values = c("#184e77","#1e6091","#1a759f",
                                "#168aad","#34a0a4","#52b69a",
                                "#76c893","#99d98c","#b5e48c")) +
  theme(axis.text=element_text(size=6))
ggsave("2_labour_market/output/prevalence_year_region.jpg", width = 6, height = 4.5)








