### Final Simulation

## Simulate virtual experiments from the model.
# ---------------------------------------------------------------------------
# We assume that the model is the true data generating model.
# As it is a deterministic model, any virtual participant
# will have on average the same individual effort based on 
# the number of Co-targets (CT) and Sources of Social Pressure (S)
# (note: more input Data is generated for we have EMC as a predictor aswell, but this is only needed later on when we replicate Jackson & Harkins' research)

# Variability comes into the experiment by:
# (a) Different trait values for the maximum noise each person can produce
# (b) Randomness from the noise we compute in the superfunction - due to e.g. 
#     fatigue, personality, mental state etc.  during the experiment

# You can run the script repeatedly to simulate new replication studies
# and observe the variability in outcomes due to sampling variability.
# not: if you're planning this, make sure you don't execute the seed

#set seed if you want to get the same results as presented in our report
set.seed(324)

# set sample size of participants (we assume a within-person design)
# derived  from experiment 2 - the pseudo-groups (Latané et al.)
n <- 36
# experimental design: Latané et al. (1979) in combination with Jackson & Harkins (1985)

# create data for CT and S and necessarily for EMC too (only relevant for the 2nd analysis)
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
  theme_minimal() +
  geom_line()
plot_final



## Replicate Latané et al. (1979)

# Variance analysis 
# we have to set the EMC condition to 2, cause Effort Matching wasn't integrated in this paper
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

# descriptives: Boxplot
boxplot_latane <- ggplot(df_Latane, aes(x = CT_factor, y = IO, fill = CT_factor)) +
  geom_boxplot(outlier.color = "red", alpha = 0.7) +
  stat_summary(fun = mean, geom = "point", shape = 18, size = 3, color = "black") + # Zeigt den Mittelwert
  labs(
    title = "distribution of Individual Outcomes (replication Latané)",
    subtitle = "Variability based on the CT-condition (EMC fixed to SLR)",
    x = "number of Co-Targets",
    y = "Sound Pressure (dyn/cm^2)"
  ) +
  theme_minimal() +
  scale_fill_brewer(palette = "Set2") +
  theme(legend.position = "none")

boxplot_latane



## Replicate Jackson & Harkins (1985)

#statistical Analysis for the replication of the Harkins & Jackson Findings - comparison between groups of 1 and 2 persons, computed for every condition of EMC

# We use the same model as for the analysis of Latané et al, but now we're taking a closer look on the EMC conditions and their effects
# we use all three conditions: the Number of Cotargets (CT), the Effort Matching condition (EMC) 
# (which transforms into LE) and the sources of social impact (this is still fixed to 2, cause it wasn't varied in this research either)

# we have to replicate the table 1 of the Analysis and test to see if the 3 pairs of conditions (Alone vs. Pair, for each of the three LE conditions)
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

# extract the p-values
p_low  <- p_values_harkins[1]
p_slr  <- p_values_harkins[2]
p_high <- p_values_harkins[3]

# execute a confidence interval for Harkins & Jackson (1985)
confint_harkins <- confint(fit_final_harkins)

#descriptives: Boxplot 
boxplot_harkins <- ggplot(df_harkins, aes(x = EMC_factor, y = IO, fill = CT_factor)) +
  geom_boxplot(alpha = 0.8) +
  labs(
    title = "Individual Outcome: Alone vs. Pair, grouped by EMC-condition",
    subtitle = "replication Jackson & Harkins (1985)",
    x = "Effort Matching Condition (EMC)",
    y = "Sound Pressure (dyn/cm^2)",
    fill = "condition"
  ) +
  theme_minimal() +
  scale_fill_manual(values = c("Alone" = "#69b3a2", "Pair" = "#404080")) +
  theme(legend.position = "top")

boxplot_harkins
