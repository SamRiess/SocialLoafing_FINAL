###Creating of the base functions to compute the outcome of the simulation later on

# load the necessary libraries (these command are executed in the Quarto Script too, but they remain in this section for better traceability)
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
       color = "expectation (LE)") +
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

# (example) check vectorized form
IE <- get_super_IE(INC, P, LE)
IE

# (example) create data for INC, P and LE (all variables were defined earlier in the code)
plot_data_super_IE <- expand.grid(
  Ct = CT,
  S = S,
  EMC = c(1, 2, 3)
)

# (example) compute the individual effort from CT, S and EMC
plot_data_IE$IE <- get_IE(
  CT = plot_data_super_IE$CT,
  S = plot_data_super_IE$S, 
  EMC = plot_data_super_IE$EMC
)

# (example) create an extra column for the plotting
plot_data_super_IE$S_label <- paste("Sources:", plot_data_super_IE$S)

# (example) plot a visual graph for the p3-function
plot_super <- ggplot(plot_data_super_IE, aes(x = CT, y = IE, color = EMC, group = EMC)) +
  geom_point(shape = 8) +
  facet_wrap(~S_label) +
  labs(title = "Individual effort", 
       subtitle = "Dependent on Cotargets + Sources", 
       y = "Individual effort", 
       x = "number of Co-Targets", 
       color = "condition (EMC)") +
  scale_x_continuous(limits = c(0, 1), breaks = c(round(CT, digits = 2))) +
  scale_y_continuous(limits = c(0, 1), breaks = c(round(IE, digits = 2))) +
  theme_bw() +
  geom_line()


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
plot_t2 <- ggplot(plot_data_IO, aes(x = MC, y = IO)) +
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

# note: we dont need plots for this superfunctions, cause it is shown in the "Evaluation" section later on.
# note2: this applies for a check of vectorized forms too... we did that earlier in checking the isolated functions.

# the final simulation for this model can be seen in 02_simulation.R 
