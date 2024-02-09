
### This code runs regression analyses of EQ5D = f(Employment, X) using 
### understanding society data to obtain coefficients of employment status
### to use to adjust the non-employment health utilities by employment status 
### in the health survey for england

source("03_load_packages.R")


usoc_data <- readRDS("4_eq5d_health_utilities/intermediate_data/USoc_w1_to_w13.rds")

usoc_data[, employed := ifelse(l_econ_stat_7cat %in% c("education","employed","self_employed"), 1, 0)]

usoc_data[, employed := factor(employed,
                          levels = 0:1,
                          labels = c("not_employed","employed"))]

##################
### linear model 

lm1 <- lm(h_eq5d_score ~ employed + d_age + d_sex + d_marital + d_hiqual + s_current_smoker +
            d_imd_quintile + h_disability + wave_no,
          data = usoc_data)

####################
### fixed effects 

usoc_data_plm <- pdata.frame(usoc_data, index = c("id","wave"))

usoc_data_plm$l.h_eq5d_score <- plm::lag(usoc_data_plm$h_eq5d_score)
usoc_data_plm$empl_eq5d <- usoc_data_plm$l.h_eq5d_score * usoc_data_plm$employed


plm1 <- plm(h_eq5d_score ~ employed + d_age + d_sex + d_marital + d_hiqual +
              d_imd_quintile + h_disability + wave_no,
            data = usoc_data_plm,
            model = "within") 

plm2 <- plm(h_eq5d_score ~ employed + d_age + d_sex + d_marital + d_hiqual +
              d_imd_quintile + h_disability + wave_no,
            subset = h_eq5d_score < 0.5,
            data = usoc_data_plm,
            model = "within") 

plm3 <- plm(h_eq5d_score ~ employed + l.h_eq5d_score + l.h_eq5d_score:employed + 
              d_age + d_sex + d_marital + d_hiqual +
              d_imd_quintile + h_disability + wave_no,
            data = usoc_data_plm,
            model = "within") 

usoc_coefs <- c(coef(lm1)["employedemployed"] , 
                coef(plm1)["employedemployed"], 
                coef(plm2)["employedemployed"])

usoc_se <- c(sqrt(diag(vcov(lm1)))["employedemployed"],
             sqrt(diag(vcov(plm1)))["employedemployed"],
             sqrt(diag(vcov(plm2)))["employedemployed"])

usoc_regs <- matrix(c(usoc_coefs, usoc_se), 
                    nrow = 3, 
                    byrow = FALSE,
                    dimnames = list(c("OLS","Fixed Effects","Fixed Effects (EQ5D<0.5)"),
                                    c("b","se")))

usoc_interaction_reg <- c(coef(plm3)["employedemployed"],coef(plm3)["employedemployed:l.h_eq5d_score"])


saveRDS(usoc_regs, "4_eq5d_health_utilities/intermediate_data/USoc_eq5d_empl_coefs.rds")
saveRDS(usoc_interaction_reg, "4_eq5d_health_utilities/intermediate_data/USoc_eq5d_empl_coefs_interaction.rds")









######################################################################
### Arellano-Bond GMM - for dynamic panel data models (y = f(y_t-1))

gmm1 <- pdynmc(
        ### data 
        dat = usoc_data,
        ### identifier variables
        varname.i = "id",
        varname.t = "wave_no",
        ### moment conditions 
        use.mc.diff = TRUE,
        use.mc.lev = FALSE,
        use.mc.nonlin = FALSE,
        ### moment conditions for the dependent variable 
        include.y = TRUE,
        varname.y = "h_eq5d_score",
        lagTerms.y = 1, 
        ### moment conditions for further explanatory variables 
        fur.con = TRUE,
        fur.con.diff = TRUE,
        fur.con.lev = FALSE,
        varname.reg.fur = c("employed","d_age","d_sex","d_marital","d_hiqual","d_imd_quintile","h_disability"),
        lagTerms.reg.fur = rep(0, 7),
        ### time dummies 
        include.dum = TRUE,
        dum.diff = TRUE,
        dum.lev = FALSE,
        varname.dum = "wave_no",
        ### other
        w.mat = "iid.err",
        std.err = "corrected",
        estimation = "twostep",
        opt.meth = "none")
saveRDS(gmm1, "4_eq5d_health_utilities/intermediate_data/gmm_model1.rds")



