###Creating of the base functions to compute the outcome of the simulation later on

# load the necessary libraries
library(ggplot2)
library(dplyr)
library(multcomp)

#' p1 Compute the contingency between input and outcome
#' 
#' @param CT number of people who are also viewed as targets of social pressure. Ranges from 0 to infinite (discrete)
#' 
#' @return (CON) contingency between input and outcome. Ranges from 0 to 1 (continuous)

get_CON <- function(CT) {
  n <- CT + 1
  CON <- 1/n
  return(CON)
}

# (example) check vectorized form:
CT <- c(0, 1, 5)
CON <- get_CON(CT)
CON

# (example) create data for CT 
plot_data_CON <- expand.grid(
  CT = c(0, 1, 5)
)

# (example) compute CON from the CT data
plot_data_CON$CON <- get_CON(
  CT = plot_data_CON$CT
)

# (example) plot a visual graph for the p1-function
plot_p1 <- ggplot(plot_data_CON, aes(x = CT, y = CON)) +
  geom_point(size = 3) +
  labs(title = "contingency between input and outcome", 
       subtitle = "Dependent on Cotargets", 
       y = "Contingency", 
       x = "Number of Cotargets") +
  scale_x_continuous(limits = c(0, 5), breaks = c(0, 1, 5)) +
  theme_bw() +
  geom_line()



#' p2 compute the social pressure on each given target member of the group
#' 
#' @param CT number of people who are also viewed as targets of social impact. Ranges from 0 to infinite (discrete)
#' @param S number of people viewed as source of social pressure. Ranges from 0 to infinite (discrete)
#' 
#' @return (P) social pressure. Ranges from 0 to 1 (continuous)

get_P <- function (CT, S) {
  P <- S/(S+CT+1)
  return(P)
}

# (example) check vectorized form:
CT <- c(0, 1, 5)
S <- c(1, 4, 7)
P <- get_P(CT, S)
P

# (example) create data for CT and S 
plot_data_P <- expand.grid(
  CT = c(0, 1, 5),
  S = c(1, 4, 7)
)

# (example) compute pressure from CT and S
plot_data_P$P <- get_P(
  CT = plot_data_P$CT,
  S = plot_data_P$S
)

# (example) create an extra column for the plotting
plot_data_P$S_label <- paste("Sources:", plot_data_P$S)

# (example) plot a visual graph for the p2-function
plot_p2 <-ggplot(plot_data_P, aes(x = CT, y = P)) +
  geom_point(shape = 8) +
  facet_wrap(~plot_data_P$S_label) +
  labs(title = "Pressure", subtitle = "Dependent on Cotargets", y = "Contingency (=Incentive)", x = "Number of Cotargets") +
  scale_x_continuous(limits = c(0, 5), breaks = c(0, 1, 5)) +
  theme_bw() +
  geom_line()



#' t1 compute the incentive to give full effort
#' 
#' @param CON number of people who are also viewed as targets of social impact. Ranges from 0 to infinite (discrete)
#' 
#' @return (INC) incentive to give full effort. Ranges from 0 to 1 (continuous)

#define the social loafing replication condition

get_INC <- function(CON) {
  INC = CON
  return(INC)
}

# (example) check vectorized form:
INC <- get_INC(CON)
INC

# (example) create data for CT 
plot_data_INC <- expand.grid(
  CON = CON
)

# (example) compute the incentive from CT 
plot_data_INC$INC <- get_INC(
  CON = plot_data_INC$CON
)
# (example) plot a visual graph for the t1-function
plot_t1 <- ggplot(plot_data_INC, aes(x = CON, y = INC)) +
  geom_point(shape = 8) +
  labs(title = "incentive to give full effort", y = "Incentive", x = "Contingency") +
  scale_x_continuous(limits = c(0, 1), breaks = c(round(CON, digits = 2))) +
  scale_y_continuous(limits = c(0, 1), breaks = c(round(INC, digits = 2))) +
  theme_bw() +
  geom_line()


#' t3 transform the EMC condition into loafing expectation
#' 
#' @param EMC Effort condition. ordinal variable with the values "1", "2" or "3"
#' 
#' @return (LE) loafing expectation. ordinal variable with possible values as followed: 
#' "match_low", "no_info", "match_high"

get_LE <- function(EMC) {
  LE <- case_match(EMC,
                    1 ~ "match_low",
                    2 ~ "no_info",
                    3 ~ "match_high"
  )
  return(LE)
}

# (example) check vectorized form:
EMC <- c(1, 2, 3)
LE <- get_LE(EMC)
LE

# no example plot is computed, cause there's nothing to show - with the execution of LE we can see the 
# function is working with vectors 


#' p3 compute the individual effort 
#' 
#' @param INC incentive to give full effort. Ranges from 0 to 1 (continuous)
#' @param P social pressure. Ranges from 0 to 1 (continuous)
#' @param LE loafing expectation. ordinal variable with possible values as followed: 
#' "match_low", "no_info", "match_high"
#' 
#' @return (IE) individual effort. Ranges from 0 to 1 (continuous)

get_IE <- function(INC, P, LE) {
  # the Social Loafing baseline (Latané)
  # whilst CT increases, the output decreases
  loafing_effort <- 0.5 * INC + 0.5 * P
  
  # the effort matching logic
  # we're definign fix values which represent the expectation for the "alone"-
  # condition of other subjects (independent of the current group size)
  final_IE <- case_when(
    # condition: co-Target is not loafing in its "alone"-condition
    LE == "match_high" ~ 0.9, 
    
    # condition: Co-Target is loafing in its "alone"-condition
    LE == "match_low"  ~ 0.4, 
    
    # In der no_info Bedingung greift das klassische Modell (Loafing)
    LE == "no_info"    ~ loafing_effort,
    
    TRUE                ~ loafing_effort
  )
  
  return(final_IE)
}

# (example) check vectorized form:
LE <- c("match_high", "match_low", "no_info")
IE <- get_IE(INC, P, LE)
IE


# (example) create data for INC, P and LE
plot_data_IE <- expand.grid(
  INC = INC,
  P = P,
  LE = c("match_high", "match_low", "no_info")
)

# (example) compute the individual effort from INC, P and LE
plot_data_IE$IE <- get_IE(
  INC = plot_data_IE$INC,
  P = plot_data_IE$P, 
  LE = plot_data_IE$LE
)

# (example) create an extra column for the plotting
plot_data_IE$P_label <- paste("Pressure:", round(plot_data_IE$P, digits = 2))

# (example) plot a visual graph for the p3-function
plot_p3 <- ggplot(plot_data_IE, aes(x = INC, y = IE, color = LE, group = LE)) +
  geom_point(shape = 8) +
  facet_wrap(~P_label) +
  labs(title = "Individual effort", 
       subtitle = "Dependent on Pressure + Incentive", 
       y = "Individual effort", 
       x = "Incentive", 
       color = "Bedingung (LE)") +
  scale_x_continuous(limits = c(0, 1), breaks = c(round(INC, digits = 2))) +
  scale_y_continuous(limits = c(0, 1), breaks = c(round(IE, digits = 2))) +
  theme_bw() +
  geom_line()



#' Superfunction - compute the individual effort with some noise (through all the previous functions)
#' 
#' @param CT number of people who are also viewed as targets of social pressure. Ranges from 0 to infinite (discrete)
#' @param S number of people viewed as source of social pressure. Ranges from 0 to infinite 
#' @param EMC Effort condition. ordinal variable with the values "1", "2" or "3"
#' 
#' @return (IE) individual effort. Ranges from 0 to 1 (continuous)

get_super_IE <- function(CT, S, EMC) {
  LE <- get_LE(EMC)
  CON <- get_CON(CT) 
  P <- get_P(CT, S)
  INC <- get_INC(CON)
  IE <- get_IE(INC, P, LE)
  
  IE <- IE + rnorm(length(IE), mean = 0, sd = 0.3)
  IE[IE > 1] <- 1
  IE[IE < 0] <- 0
  return(IE)
}

# note: we dont need plots for our superfunctions, cause they are not directly labeled in the VAST
# note2: this applies for a check of vectorized forms too... we did that earlier

#' t2-function (manifest) - compute the individual outcome
#' 
#' @param MC maximum capacity to scream. Ranges from 0 to 15 (continuous)
#' @param IE individual effort Ranges from 0 to 1 (continuous)
#' 
#' @return (IO) individual outcome. Ranges from 0 to inf. (continuous)

get_IO <- function(MC, IE) {
  IO <- MC * IE   
  return (IO)
}

# (example) check vectorized form:
MC <- c(9, 10, 13)
IO <- get_IO(MC, IE)
IO

# (example) create data for MC and IE
plot_data_IO <- expand.grid(
  MC = c(9, 10, 13),
  IE = IE
)

# (example) compute the individual effort from MC and IE
plot_data_IO$IO <- get_IO(
  MC = plot_data_IO$MC,
  IE = plot_data_IO$IE
)

# (example) create an extra column for the plotting
plot_data_IO$IE_label <- paste("Individual Effort:", round(plot_data_IO$IE, digits = 2))

# (example) plot a visual graph for the t2-function
plot_IO <- ggplot(plot_data_IO, aes(x = MC, y = IO)) +
  geom_point(shape = 8) +
  facet_wrap(~plot_data_IO$IE_label) +
  labs(title = "Individual outcome", subtitle = "Dependent on Maximum + Individual effort", y = "Individual outcome", x = "Individual Maximum") +
  scale_x_continuous(limits = c(min(MC), max(MC)), breaks = c(round(MC, digits = 2))) +
  scale_y_continuous(limits = c(min(plot_data_IO$IO), max(plot_data_IO$IO)), breaks = pretty(plot_data_IO$IO)) +
  theme_bw() +
  geom_line()


#' Superfunction - compute the individual outcome  (through all the previous functions)
#' 
#' @param CT number of people who are also viewed as targets of social pressure. Ranges from 0 to infinite (discrete)
#' @param S number of people viewed as source of social pressure. Ranges from 0 to infinite (discrete)
#' @param MC maximum capacity to scream. Ranges from 0 to 15 (continuous)
#' 
#' @return (IO) individual outcome. Ranges from 0 to inf (continuous)

get_super_IO <- function(CT, S, MC, EMC){
  IO <- get_super_IE(CT, S, EMC) * MC 
  return (IO)
}

# note: we dont need plots for our superfunctions, cause they are not directly labeled in the VAST
# note2: this applies for a check of vectorized forms too... we did that earlier



### Final Simulation

## Simulate virtual experiments from the model.
# ---------------------------------------------------------------------------
# We assume that the model is the true data generating model.
# As it is a deterministic model, any virtual participant
# will have on average the same individual effort based on 
# the number of Co-targets (CT) and Sources of Social Pressure (S)
# (note: more input Data is generated for we have EMC as a predictor aswell, but this is only needed later on when we replicate Harkins' research)

# Variability comes into the experiment by:
# (a) Different trait values for the maximum noise each person can produce
# (b) Randomness from the noise we compute in the superfunction - due to e.g. 
#     fatigue, personality, mental state etc.  during the experiment

# You can run the script repeatedly to simulate new replication studies
# and observe the variability in outcomes due to sampling variability.
# not: if you're planning this, make sure you don't execute the seed

#set seed if you want to get the same results as presented in our report
set.seed(324)


## Replicate the original Study of Latané et al.

# set sample size of participants (we assume a within-person design)
# derived  from experiment 2 - the pseudo-groups (Latané et al.)
n <- 36

# experimental design: Latané et al. (1979)
# create data for CT and S and necessarily for EMC too (but not relevant for our analysis)

df <- expand.grid(
  id = 1:n, 
  CT = c(0, 1, 5),
  S = c(2),
  EMC = c(1, 2, 3) # LE, SLR, HE
)

# determine the variables for a simulation of the exogenous variables
phi <- 5
alpha <- 0.922*phi
beta <- (1-0.922)*phi

scale_factor <- 12.29 / 0.922

# interindividual variability in exogenous variable ("maximum capacity")
max_per_person <- data.frame(
  id = 1:n,
  maximum = scale_factor * rbeta(n, alpha, beta)
)

mean(max_per_person$maximum)

# merge into df
df <- merge(df, max_per_person, by = "id")

# compute the psychological outcome variable (IE)
df$IE <- get_super_IE(
  CT = df$CT,
  S = df$S, 
  EMC = df$EMC
)

# compute the manifest outcome variable (IO)
df$IO <- get_super_IO(
  CT = df$CT,
  S = df$S,
  MC = df$maximum, 
  EMC = df$EMC
)

# look at the simulated data 
# View(df)

#compute the means of IO for each experimental group
data_final <- df %>%
  group_by(CT, EMC) %>%
  summarise(means = mean(IO), .groups = "drop")


plot_final <- ggplot(data_final, aes(x = CT, y = means, color = factor(EMC))) +
  geom_point(shape = 8) +
  labs(
    title = "Mean Individual Outcome (dyn/cm^2)", 
    subtitle = "Dependent on experimental group (S = 1)", 
    y = "Sound Pressure in dyn percm^2", 
    x = "conditions (Number of Cotargets)",
    color = "EMC"
  ) +
  scale_x_continuous(limits = c(0, 5), breaks = c(0, 1, 5)) +
  theme_bw() +
  geom_line()
plot_final

## Variance analysis for the replication of Latané (1979)
# we have to set the LE condition to 0.7, cause Effort Matching wasn't integrated in this paper
df_Latane <- subset(df, EMC == 2)

#define the CT-factor
df_Latane$CT_factor <- factor(df_Latane$CT,
                       levels = c(0,1,5),
                       labels = c("CT0","CT1","CT5"))

fit_aov <- aov(IO ~ CT_factor, data = df_Latane)

#define the hypothesis
hyp1 <- "CT1 - CT5 <= 0"
hyp2 <- "CT0 - CT1 <= 0"
hyps <- c(hyp1, hyp2)

kontraste <- mcp(CT_factor = hyps)

#execute the ANOVA
fit <- glht(fit_aov, linfct = kontraste)

confint(fit, level = 0.95, calpha = univariate_calpha())
summary(fit, test = univariate())




## Replicate the original Study of Harkins & Jackson

#statistical Analysis for the replication of the Harkins & Jackson Findings - comparison between groups of 1 and 2 persons, computated for every condition of EMC

# We use the same model as for the analysis of Latané et al, but now we're taking a closer look on the LE conditions and their effets
# now we use all three conditions: the Number of Cotargets (CT), the Effort Matching condition 
# (which transforms into LE) and the sources of social impact (this is still fixed to 1, cause it wasn't varied in this research either)

# we replicate the table 1 of the Analysis and test, if the 3 pairs of conditions (Alone vs. Pair, for each of the three LE conditions)
# create significant p-values


# prepare the data for the Jackson & Harkins ANOVA
df_harkins <- subset(df, CT %in% c(0,1))

# look at the simulated data subset 
# View(df_harkins)

#define the CT-factor
df_harkins$CT_factor <- factor(df_harkins$CT,
                               levels = c(0, 1),
                               labels = c("Alone", "Pair"))

#define the LE-factor
df_harkins$EMC_factor <- factor(df_harkins$EMC,
                               levels = c(1, 2, 3),
                               labels = c("Low", "SLR", "High"))

fit_harkins <- aov(IO ~ CT_factor * EMC_factor, data = df_harkins)
summary(fit_harkins)

#testing each pair between 0 and 1 Cotarget for each EMC condition

#preparation: create a combined group for contrasts
df_harkins$group <- interaction(df_harkins$CT_factor, df_harkins$EMC_factor)

#new model, based on the new groups
fit_harkins_uni <- aov(IO ~ group, data = df_harkins)

#define a hypothesis for each pair
hyp_low    <- "Alone.Low - Pair.Low = 0"
hyp_noinfo <- "Alone.SLR - Pair.SLR = 0"
hyp_high   <- "Alone.High - Pair.High = 0"

hyps_harkins <- c(hyp_low, hyp_noinfo, hyp_high)

kontraste_harkins <- mcp(group = hyps_harkins)
fit_final_harkins <- glht(fit_harkins_uni, linfct = kontraste_harkins)

#show results
summary_harkins <- summary(fit_final_harkins, test = univariate())
p_values_harkins <- summary_harkins$test$pvalues

# extract 
p_low  <- p_values_harkins[1]
p_slr  <- p_values_harkins[2]
p_high <- p_values_harkins[3]

# execute a confidence interval for Harkins & Jackson (1985)
confint(fit_final_harkins)
