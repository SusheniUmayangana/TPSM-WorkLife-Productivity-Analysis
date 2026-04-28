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