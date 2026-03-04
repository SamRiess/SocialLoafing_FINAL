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
ggplot(plot_data_CON, aes(x = CT, y = CON)) +
  geom_point(shape = 8) +
  labs(title = "contingency between input and outcome", subtitle = "Dependent on Cotargets", y = "Contingency", x = "Number of Cotargets") +
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
ggplot(plot_data_P, aes(x = CT, y = P)) +
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

get_INC <- function(CON, LE) {
  INC <- CON + 3 * CON * (1- CON) * (LE - CON)
  return(INC)
}

# (example) check vectorized form:
LE <- c(0.9, 0.7, 0.5)
INC <- get_INC(CON, LE)
INC

# (example) create data for CT 
plot_data_INC <- expand.grid(
  CON = CON,
  LE = LE
)

# (example) compute the incentive from CT and LE 
plot_data_INC$INC <- get_INC(
  CON = plot_data_INC$CON,
  LE = plot_data_INC$LE
)

# (example) create an extra column for the plotting
plot_data_INC$LE_label <- paste("EM condition:", plot_data_INC$LE)

# (example) plot a visual graph for the t1-function
ggplot(plot_data_INC, aes(x = CON, y = INC)) +
  geom_point(shape = 8) +
  facet_wrap(~plot_data_INC$LE_label) +
  labs(title = "incentive to give full effort", y = "Incentive", x = "Contingency") +
  scale_x_continuous(limits = c(0, 1), breaks = c(round(CON, digits = 2))) +
  scale_y_continuous(limits = c(0, 1), breaks = c(round(INC, digits = 2))) +
  theme_bw() +
  geom_line()


#' p3 compute the individual effort 
#' 
#' @param INC incentive to give full effort. Ranges from 0 to 1 (continuous)
#' @param P social pressure. Ranges from 0 to 1 (continuous)
#' 
#' @return (IE) individual effort. Ranges from 0 to 1 (continuous)

get_IE <- function(INC, P) {
  IE <- 0.8 * INC + 0.2 * P
  return(IE)
}

# (example) check vectorized form:
IE <- get_IE(INC, P)
IE


# (example) create data for INC and P
plot_data_IE <- expand.grid(
  INC = INC,
  P = P
)

# (example) compute the individual effort from INC and P
plot_data_IE$IE <- get_IE(
  INC = plot_data_IE$INC,
  P = plot_data_IE$P
)

# (example) create an extra column for the plotting
plot_data_IE$P_label <- paste("Pressure:", round(plot_data_IE$P, digits = 2))

# (example) plot a visual graph for the p1-function
ggplot(plot_data_IE, aes(x = INC, y = IE)) +
  geom_point(shape = 8) +
  facet_wrap(~plot_data_IE$P_label) +
  labs(title = "Individual effort", subtitle = "Dependent on Pressure + Incentive", y = "Individual effort", x = "Incentive") +
  scale_x_continuous(limits = c(0, 1), breaks = c(round(INC, digits = 2))) +
  scale_y_continuous(limits = c(0, 1), breaks = c(round(IE, digits = 2))) +
  theme_bw() +
  geom_line()



#' Superfunction - compute the individual effort with some noise (through all the previous functions)
#' 
#' @param CT number of people who are also viewed as targets of social pressure. Ranges from 0 to infinite (discrete)
#' @param S number of people viewed as source of social pressure. Ranges from 0 to infinite (discrete)
#' 
#' @return (IE) individual effort. Ranges from 0 to 1 (continuous)

get_super_IE <- function(CT, S, LE) {
  CON <- get_CON(CT) 
  P <- get_P(CT, S)
  INC <- get_INC(CON, LE)
  IE <- get_IE(INC, P)
  IE <- IE + rnorm(1, mean = 0, sd = 0.3)
  IE[IE > 1] <- 1
  IE[IE < 0] <- 0
  return(IE)
}


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
IO <- get_IE(MC, IE)
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

# (example) plot a visual graph for the p1-function
ggplot(plot_data_IO, aes(x = MC, y = IO)) +
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

get_super_IO <- function(CT, S, MC, LE){
  IO <- get_super_IE(CT, S, LE) * MC 
  return (IO)
}

### Final Simulation

## Replicate the original Study of Latané et al. 

# Simulate virtual experiments from the model.
# ---------------------------------------------------------------------------
# We assume that the model is the true data generating model.
# As it is a deterministic (IS IT???) model, any virtual participant
# will have on average the same individual effort based on 
# the number of Cotargets (CT) and Sources of Social Pressure (S)
# (note: more input Data is generated for we have LE as an predictor aswell, but this is only needed later on when we replicate Harkin's research)


# Variability comes into the experiment by:
# (a) Different trait values for the maximum noise each person can produce
# (b) Randomness from the noise we compute in the superfuncion - due to e.g. 
#     faitque, personality, mental state etc.  during the experiment

# You can run the script repeatedly to simulate new replication studies,
# and observe the variability in outcomes due to sampling variability.

set.seed(324)

# set sample size of participants (we assume a within-person design)
# derived  from experiment 2 - the pseudo-groups (Latané et al.)
n <- 36

# experimental design: Latané et al. (1979)
# create data for CT and S

df <- expand.grid(
  id = 1:n, 
  CT = c(0, 1, 5),
  S = c(1),
  LE = c(0.9, 0.7, 0.5) # HE, SLR, LE
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
  LE = df$LE
)

# compute the manifest outcome variable (IO)
df$IO <- get_super_IO(
  CT = df$CT,
  S = df$S,
  MC = df$maximum, 
  LE = df$LE
)

# look at the simulated data 
# View(df)

#compute the means of IO for each experimental group
data_final <- df %>%
  group_by(CT, LE) %>%
  summarise(means = mean(IO), .groups = "drop")


plot_final <- ggplot(data_final, aes(x = CT, y = means, color = factor(LE))) +
  geom_point(shape = 8) +
  labs(
    title = "Mean Individual Outcome (dyn/cm^2)", 
    subtitle = "Dependent on experimental group (S = 1)", 
    y = "Sound Pressure in dyn percm^2", 
    x = "conditions (Number of Cotargets)",
    color = "LE"
  ) +
  scale_x_continuous(limits = c(0, 5), breaks = c(0, 1, 5)) +
  theme_bw() +
  geom_line()
plot_final

## Variance analysis for the replication of Latanße (1979)
# we have to set the LE condition to 0.7, cause Effort Matching wasn't integrated in this paper
df_Latane <- subset(df, LE == 0.7)

df_Latane$CT_factor <- factor(df_Latane$CT,
                       levels = c(0,1,5),
                       labels = c("CT0","CT1","CT5"))

fit_aov <- aov(IO ~ CT_factor, data = df_Latane)

hyp1 <- "CT1 - CT5 <= 0"
hyp2 <- "CT0 - CT1 <= 0"
hyps <- c(hyp1, hyp2)

kontraste <- mcp(CT_factor = hyps)

fit <- glht(fit_aov, linfct = kontraste)

confint(fit, level = 0.95, calpha = univariate_calpha())
summary(fit, test = univariate())


##statistical Analysis for the replication of the Harkin Findings - comparison between groups of 1 and 2 persons, computated for every condition of LE alone

# We use the same model as for the analysis of Latané et al, but now we're taking a closer look on the LE conditions and their effets
# now we use all three conditions: the Number of Cotargets (CT), the Effort Matching condition 
# (which transforms into LE) and the sources of social impact (this is still fixed to 1, cause it wasn't varied in this research either)

# we replicate the table 1 of the Analysis and test, if the 3 pairs of conditions (Alone vs. Pair, for each of the three LE conditions)
# create significant p-values


# prepare the data for the Harkings ANOVA

df_harkins <- subset(df, CT %in% c(0, 1))

#define the CT-factor
df_harkins$CT_factor <- factor(df_harkins$CT,
                               levels = c(0, 1),
                               labels = c("Alone", "Pair"))

#define the LE-factor
df_harkins$LE_factor <- factor(df_harkins$LE,
                               levels = c(0.5, 0.7, 0.9),
                               labels = c("Low", "SLR", "High"))

fit_harkins <- aov(IO ~ CT_factor * LE_factor, data = df_harkins)
summary(fit_harkins)


