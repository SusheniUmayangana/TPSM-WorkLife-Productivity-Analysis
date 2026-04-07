# -------------------------------------------------------------------------
# Script 03: Inferential Analysis & ANOVA
# Member: Navoda D G H (IT23265806)
# Goal: Perform correlation, hypothesis testing, ANOVA, and post-hoc analysis
# -------------------------------------------------------------------------

# Load cleaned dataset - Using relative paths
data <- read.csv("data/processed/cleaned_hr_data.csv")

# Convert WorkLifeBalance to factor for ANOVA
data$WorkLifeBalance <- as.factor(data$WorkLifeBalance)

# 1. Correlation Test
correlation_result <- cor.test(
  as.numeric(data$WorkLifeBalance), 
  data$PerformanceRating, 
  method = "spearman"
)
print(correlation_result)

# Save output
capture.output(correlation_result, file = "results/tables/correlation_results.txt")

# 2. ANOVA Test
# Testing if mean PerformanceRating differs across WorkLifeBalance groups
anova_model <- aov(PerformanceRating ~ WorkLifeBalance, data = data)
anova_summary <- summary(anova_model)
print(anova_summary)

# Save output
capture.output(anova_summary, file = "results/tables/anova_results.txt")

# 3. Normality Test (Residuals)
shapiro_result <- shapiro.test(residuals(anova_model))
print(shapiro_result)
capture.output(shapiro_result, file = "results/tables/shapiro_test.txt")

# 4. Homogeneity of Variance
if(!require(car)) install.packages("car") 
library(car)

# Ensure it is a factor (This fixes the error)
data$WorkLifeBalance <- as.factor(data$WorkLifeBalance)

levene_result <- leveneTest(PerformanceRating ~ WorkLifeBalance, data = data)
print(levene_result)

# Save output
capture.output(levene_result, file = "results/tables/levene_test.txt")