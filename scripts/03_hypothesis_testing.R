# -------------------------------------------------------------------------
# Script 03: Inferential Analysis & Hypothesis Testing
# Member: Navoda D G H (IT23265806)
# Project: TPSM Work-Life Productivity Analysis
# -------------------------------------------------------------------------

# --- Block 1: Setup & Data Ingestion ---
# Loading the "Single Source of Truth" dataset
data <- read.csv("data/processed/cleaned_hr_data.csv")

# Ensure Independent Variable (IV) is a factor for grouping
data$WorkLifeBalance <- as.factor(data$WorkLifeBalance)

# Ensure Dependent Variable (DV) is numeric (Re-coded from factor if necessary)
data$Performance_Binary <- as.numeric(as.character(data$Performance_Binary))

# Create directory structure for outputs
dir.create("results/tables", recursive = TRUE, showWarnings = FALSE)
dir.create("results/plots", recursive = TRUE, showWarnings = FALSE)


# --- Block 2: Spearman Correlation ---
# Method: Spearman Rank Correlation (Non-parametric)
# Note: exact = FALSE is used to handle 'ties' in the ordinal Likert scale data
correlation_result <- cor.test(as.numeric(data$WorkLifeBalance), 
                               data$Performance_Binary, 
                               method = "spearman", 
                               exact = FALSE)

print(correlation_result)
capture.output(correlation_result, file = "results/tables/correlation_results.txt")


# --- Block 3: ANOVA & Assumption Testing ---
# Modeling Performance probability across Work-Life Balance levels
anova_model <- aov(Performance_Binary ~ WorkLifeBalance, data = data)
print(summary(anova_model))
capture.output(summary(anova_model), file = "results/tables/anova_results.txt")

# Validating Homogeneity of Variance using Levene's Test
if(!require(car)) install.packages("car") 
library(car)
levene_res <- leveneTest(Performance_Binary ~ WorkLifeBalance, data = data)
print(levene_res)
capture.output(levene_res, file = "results/tables/levene_test.txt")


# --- Block 4: Post-Hoc & Probability Mapping ---
# Identifying pairwise differences between WLB groups
tukey_res <- TukeyHSD(anova_model)
print(tukey_res)
capture.output(tukey_res, file = "results/tables/tukey_results.txt")

# Calculating the probability of "Outstanding Performance" per WLB category
# In a binary (0/1) variable, the Mean represents the Probability (percentage)
prob_stats <- aggregate(Performance_Binary ~ WorkLifeBalance, data = data, mean)
colnames(prob_stats) <- c("WLB_Level", "Probability_of_Outstanding")

write.csv(prob_stats, "results/tables/performance_probabilities.csv", row.names = FALSE)


# --- Block 5: Diagnostic Visualizations ---
# Saving the 4-panel diagnostic plot for model validation evidence
png("results/plots/anova_diagnostics.png", width = 800, height = 800)
par(mfrow = c(2, 2)) # Arrange plots in a 2x2 grid
plot(anova_model)
dev.off()

print("Script 03: Inferential Analysis successfully completed and exported.")