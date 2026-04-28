# -------------------------------------------------------------------------
# Script 04: Simple Logistic Regression (Work-Life Balance Only)
# -------------------------------------------------------------------------

print("=== SIMPLE PRODUCTIVITY MODEL (WLB ONLY) ===")

setwd("E:/Y3S2/TPSM/Assignment/TPSM-WorkLife-Productivity-Analysis")
cleaned_data <- read.csv("data/processed/cleaned_hr_data_.csv")
head(cleaned_data)

# Ensure WorkLifeBalance is treated as a category
cleaned_data$WorkLifeBalance <- as.factor(cleaned_data$WorkLifeBalance)

# Run the model predicting Performance using ONLY WorkLifeBalance
simple_productivity_model <- glm(Performance_Binary ~ WorkLifeBalance, 
                                 data = cleaned_data, 
                                 family = "binomial")

# Print the standard results (Estimates, Z-values, and P-values)
print(summary(simple_productivity_model))

# Calculate and print the Odds Ratios
print("=== ODDS RATIOS ===")
print(exp(coef(simple_productivity_model)))