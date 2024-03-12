## load the inputs and function to simulate outcomes

source("3_calibrating_treatment_effects/R_scripts/3a_read_calibration_inputs.R")
source("3_calibrating_treatment_effects/R_scripts/3b_function_EmpHistory_sim.R")

########## ----------- Set input parameters ------------- ###########

## Set outcomes to target (use pooled WMCA and SCR figures from the HLE trials)

IPS_PROB_13weeks_empl_TRT <- 0.22
IPS_PROB_at12mth_empl_TRT <- 0.2355
IPS_PROB_in12mth_empl_TRT <- 0.3697


IPS_PROB_13weeks_empl_CTRL <- 0.18
IPS_PROB_at12mth_empl_CTRL <- 0.1986
IPS_PROB_in12mth_empl_CTRL <- 0.3152

## Restrict the random draws from uniform (calibration for U -> U transitions
## always ends up being > 0.9, so restrict the random draw to these values)

U <- c(0.9,1)

n_sim <- 10000

pop_size <- 100000

seed <- 42

######################################################################

## Run four simulations - 
## (a) a calibration factor for U -> U transitions only
##      - (i) calibrate to HLE Treatment Arm outcomes
##      - (ii) calibrate to HLE Control Arm outcomes
## (b) identical calibration factors across health conditions (4 factors)
##      - (i) calibrate to HLE Treatment Arm outcomes
##      - (ii) calibrate to HLE Control Arm outcomes


####### OPTION A

simulate_ai <- EmpHistory_sim(n_sim = n_sim,
                              seed = seed,
                              U = c(0,1),
                              E1 = 1,
                              E2 = 1,
                              E3 = 1,
                              IPS_PROB_13weeks_empl = IPS_PROB_13weeks_empl_TRT,
                              IPS_PROB_at12mth_empl = IPS_PROB_at12mth_empl_TRT,
                              IPS_PROB_in12mth_empl = IPS_PROB_in12mth_empl_TRT,
                              health_cond_split = HLE,
                              prob_list = prob_list,
                              pop_size = pop_size,
                              nonemp_emprate = nonemp_emprate)

saveRDS(simulate_ai,"3_calibrating_treatment_effects/output/sim_output_MSK_MH_HLEtreat_a.rds")


simulate_aii <- EmpHistory_sim(n_sim = n_sim,
                               seed = seed,
                               U = c(0,1),
                               E1 = 1,
                               E2 = 1,
                               E3 = 1,
                               IPS_PROB_13weeks_empl = IPS_PROB_13weeks_empl_CTRL,
                               IPS_PROB_at12mth_empl = IPS_PROB_at12mth_empl_CTRL,
                               IPS_PROB_in12mth_empl = IPS_PROB_in12mth_empl_CTRL,
                               health_cond_split = HLE,
                               prob_list = prob_list,
                               pop_size = pop_size,
                               nonemp_emprate = nonemp_emprate)

saveRDS(simulate_aii,"3_calibrating_treatment_effects/output/sim_output_MSK_MH_HLEctrl_a.rds")

####### OPTION B

simulate_bi <- EmpHistory_sim(n_sim = n_sim,
                              seed = seed,
                              U = c(0,1),
                              E1 = c(0,1),
                              E2 = c(0,1),
                              E3 = c(0,1),
                              IPS_PROB_13weeks_empl = IPS_PROB_13weeks_empl_TRT,
                              IPS_PROB_at12mth_empl = IPS_PROB_at12mth_empl_TRT,
                              IPS_PROB_in12mth_empl = IPS_PROB_in12mth_empl_TRT,
                              health_cond_split = HLE,
                              prob_list = prob_list,
                              pop_size = pop_size,
                              nonemp_emprate = nonemp_emprate)

saveRDS(simulate_bi,"3_calibrating_treatment_effects/output/sim_output_MSK_MH_HLEtreat_b.rds")


simulate_bii <- EmpHistory_sim(n_sim = n_sim,
                               seed = seed,
                               U = c(0,1),
                               E1 = c(0,1),
                               E2 = c(0,1),
                               E3 = c(0,1),
                               IPS_PROB_13weeks_empl = IPS_PROB_13weeks_empl_CTRL,
                               IPS_PROB_at12mth_empl = IPS_PROB_at12mth_empl_CTRL,
                               IPS_PROB_in12mth_empl = IPS_PROB_in12mth_empl_CTRL,
                               health_cond_split = HLE,
                               prob_list = prob_list,
                               pop_size = pop_size,
                               nonemp_emprate = nonemp_emprate)

saveRDS(simulate_bii,"3_calibrating_treatment_effects/output/sim_output_MSK_MH_HLEctrl_b.rds")


