source("03_load_packages.R")

#############################
### Plot comparisons between OOW and counterfactuals. label with sample sizes

#### read in sample sizes 

sample_size <- read.csv("5_ukmod_data_inputs/output/sampsize_matrix.csv") %>%
  filter(X != "In-work (1yr)") %>%
  pivot_longer(cols = c("MSK","MH","MSK.MH"), names_to = "health_cond", values_to = "N") %>%
  mutate(status = factor(X, 
                         levels = c("Out-of-work","In-work","In-work (1yr, nonemp)"),
                         labels = c("OOW","IW","IW (<1yr)"))) %>%
  select(status, health_cond, N) %>%
  mutate(group = paste0(health_cond,"\n ",status)) %>%
  mutate(group = factor(group,
                        levels = c("MSK\n OOW", "MSK\n IW", "MSK\n IW (<1yr)",
                                   "MH\n OOW", "MH\n IW", "MH\n IW (<1yr)",
                                   "MSK.MH\n OOW", "MSK.MH\n IW", "MSK.MH\n IW (<1yr)") ))

ggplot(sample_size) +
  aes(x = group, y = N, fill = group) +
  geom_col() +
  theme_classic() +
  scale_fill_manual(values = c("#415d43","#709775","#8fb996",
                               "#240046","#5a189a","#9d4edd",
                               "#f7cad0","#fbb1bd","#ff7096")) +
  theme(legend.position = "none") +
  labs(y = "Sample size",
       x = "",
       caption = "OOW: out of work, IW: in work, MSK: musculoskeletal, MH: mental health")

#### read in UKMOD output 

ukmod_data <- readxl::read_excel("output/UKMOD_output2.xlsx", range = "C5:M17") %>%
  select(Description, `All benefits`, `Earnings (part of original income)`, `disposable income`,
         `All benefits`, `direct tax (income tax + council tax)`) %>%
  rename(status = Description,
         income = `disposable income`,
         benefits = `All benefits`,
         earnings = `Earnings (part of original income)`,
         tax = `direct tax (income tax + council tax)`) %>%
  filter(status != "IW (1yr)") %>%
  mutate(status = ifelse(status == "IW (1yr) previously non-employed", "IW (<1yr)", status)) %>%
  mutate(status = factor(status, levels = c("OOW","IW","IW (<1yr)"))) %>%
  mutate(health_cond = c(rep("MSK",3), rep("MH",3), rep("MSK.MH",3)) ) %>%
  arrange(status, health_cond) %>%
  left_join(sample_size, by = c("status","health_cond"))

#############################
### PLOTS

### disposable income 

ggplot(ukmod_data) +
  aes(x = group, y = income, fill = group) +
  geom_col() +
  geom_text(aes(label = paste0("(n = " ,N,")") ), vjust = - 0.5, size = 2.8) +
  theme_classic() +
  scale_y_continuous(labels = scales::dollar_format(prefix = "£")) +
  scale_fill_manual(values = c("#415d43","#709775","#8fb996",
                               "#240046","#5a189a","#9d4edd",
                               "#f7cad0","#fbb1bd","#ff7096")) +
  theme(legend.position = "none") +
  labs(y = "Monthly average disposable income",
       x = "",
       caption = "OOW: out of work, IW: in work, MSK: musculoskeletal, MH: mental health \n\nSource: Family Resources Survey 2018/19 - 2021/22")

### earnings 

ggplot(ukmod_data) +
  aes(x = group, y = earnings, fill = group) +
  geom_col() +
  geom_text(aes(label = paste0("(n = " ,N,")") ), vjust = - 0.5, size = 2.8) +
  theme_classic() +
  scale_y_continuous(labels = scales::dollar_format(prefix = "£")) +
  scale_fill_manual(values = c("#415d43","#709775","#8fb996",
                               "#240046","#5a189a","#9d4edd",
                               "#f7cad0","#fbb1bd","#ff7096")) +
  theme(legend.position = "none") +
  labs(y = "Monthly average earnings",
       x = "",
       caption = "OOW: out of work, IW: in work, MSK: musculoskeletal, MH: mental health \n\nSource: Family Resources Survey 2018/19 - 2021/22")

### benefits 

ggplot(ukmod_data) +
  aes(x = group, y = benefits, fill = group) +
  geom_col() +
  geom_text(aes(label = paste0("(n = " ,N,")") ), vjust = - 0.5, size = 2.8) +
  theme_classic() +
  scale_y_continuous(labels = scales::dollar_format(prefix = "£")) +
  scale_fill_manual(values = c("#415d43","#709775","#8fb996",
                               "#240046","#5a189a","#9d4edd",
                               "#f7cad0","#fbb1bd","#ff7096")) +
  theme(legend.position = "none") +
  labs(y = "Monthly average benefit payments",
       x = "",
       caption = "OOW: out of work, IW: in work, MSK: musculoskeletal, MH: mental health \n\nSource: Family Resources Survey 2018/19 - 2021/22")

### tax 

ggplot(ukmod_data) +
  aes(x = group, y = tax, fill = group) +
  geom_col() +
  geom_text(aes(label = paste0("(n = " ,N,")") ), vjust = - 0.5, size = 2.8) +
  theme_classic() +
  scale_y_continuous(labels = scales::dollar_format(prefix = "£")) +
  scale_fill_manual(values = c("#415d43","#709775","#8fb996",
                               "#240046","#5a189a","#9d4edd",
                               "#f7cad0","#fbb1bd","#ff7096")) +
  theme(legend.position = "none") +
  labs(y = "Monthly average benefit payments",
       x = "",
       caption = "OOW: out of work, IW: in work, MSK: musculoskeletal, MH: mental health \n\nSource: Family Resources Survey 2018/19 - 2021/22")

###########################
## Combined plot 

plot_data <- ukmod_data %>%
  select(-income) %>%
  pivot_longer(cols = c("benefits","earnings","tax"), names_to = "variable", values_to = "value") %>%
  mutate(label = paste0("(n = " ,N,")")) %>%
  mutate(group2 = paste0(group, "\n", label)) %>%
  mutate(group2 = factor(group2,
                         levels = c("MSK\n OOW\n(n = 5138)","MSK\n IW\n(n = 3967)","MSK\n IW (<1yr)\n(n = 97)",
                                    "MH\n OOW\n(n = 4556)", "MH\n IW\n(n = 3652)", "MH\n IW (<1yr)\n(n = 176)",
                                    "MSK.MH\n OOW\n(n = 2186)", "MSK.MH\n IW\n(n = 736)", "MSK.MH\n IW (<1yr)\n(n = 23)") )) %>%
  mutate(vjust = 1) %>%
  mutate(vjust = ifelse(value < 50, -0.5, vjust)) %>%
  mutate(variable = factor(variable,
                           levels = c("earnings","tax","benefits"),
                           labels = c("Labour Market Earnings","Income Tax + Council Tax Receipts","Benefit Payments")))
  


ggplot(plot_data) +
  aes(x = group2, y = value, fill = group2) +
  facet_wrap(~variable, ncol = 1, scales = "free_y") +
  geom_col() +
  geom_text(aes(label = paste0("£",round(value)), vjust = vjust ), size = 2) +
  theme_classic() +
  scale_y_continuous(labels = scales::dollar_format(prefix = "£")) +
  scale_fill_manual(values = c("#57cc99","#80ed99","#c7f9cc",
                               "#ff7b00","#ffc300","#ffea00",
                               "#00b4d8","#90e0ef","#caf0f8")) +
  theme(legend.position = "none",
        axis.text=element_text(size=6, face = "bold")) +
  labs(y = "",
       x = "",
       caption = "OOW: out of work, IW: in work, MSK: musculoskeletal, MH: mental health \n\nSource: Family Resources Survey 2018/19 - 2021/22")

ggsave("output/taxben_summary_plot.png")


