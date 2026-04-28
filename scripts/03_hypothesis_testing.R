# -------------------------------------------------------------------------
# Script 03: Inferential Analysis & ANOVA
# Member: Navoda D G H (IT23265806)
# Goal: Perform correlation, hypothesis testing, ANOVA, and post-hoc analysis
# -------------------------------------------------------------------------

# 1. Load Data and Setup Factors
data <- read.csv("data/processed/cleaned_hr_data.csv")

# 2. Ensure IV is a factor and DV is numeric for the correlation
data$WorkLifeBalance <- as.factor(data$WorkLifeBalance)
data$Performance_Binary <- as.numeric(as.character(data$Performance_Binary))

# 3. Spearman Rank Correlation (Non-parametric test)
correlation_result <- cor.test(as.numeric(data$WorkLifeBalance), 
                               data$Performance_Binary, 
                               method = "spearman")
print(correlation_result)

# Save output for Viva evidence
dir.create("results/tables", recursive = TRUE, showWarnings = FALSE)
capture.output(correlation_result, file = "results/tables/correlation_binary_results.txt")

# 4. One-Way ANOVA 
# Testing the statement validity: Does WLB impact Performance?
anova_model <- aov(Performance_Binary ~ WorkLifeBalance, data = data)
print(summary(anova_model))
capture.output(summary(anova_model), file = "results/tables/anova_binary_results.txt")

# 5. Assumption Testing (Levene's Test for Homogeneity)
if(!require(car)) install.packages("car") 
library(car)
levene_result <- leveneTest(Performance_Binary ~ WorkLifeBalance, data = data)
capture.output(levene_result, file = "results/tables/levene_test.txt")

# --- 6. NORMALITY TEST (RESIDUALS) ---
# Required for LO2: Ensuring the ANOVA residuals are normally distributed
shapiro_result <- shapiro.test(residuals(anova_model))
print(shapiro_result)
capture.output(shapiro_result, file = "results/tables/shapiro_test.txt")

# --- 7. TUKEY POST-HOC TEST ---
# Comparing specific groups (e.g., Level 1 vs Level 4)
tukey_result <- TukeyHSD(anova_model)
print(tukey_result)
capture.output(tukey_result, file = "results/tables/tukey_results.txt")

# --- 8. GROUP MEANS TABLE ---
# Descriptive summary to support your inferential findings
group_stats <- aggregate(Performance_Binary ~ WorkLifeBalance, data = data, 
                         FUN = function(x) c(mean = mean(x), sd = sd(x)))
write.csv(group_stats, "results/tables/group_stats_summary.csv")