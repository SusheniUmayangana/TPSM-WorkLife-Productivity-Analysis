
setwd("E:/Y3S2/TPSM/Assignment/TPSM-WorkLife-Productivity-Analysis")
hr_data <- read.csv("data/processed/cleaned_hr_data.csv")
head(cleaned_data)

# Ensure target and categorical variables are treated as factors
hr_data$Attrition <- as.factor(hr_data$Attrition)
hr_data$OverTime <- as.factor(hr_data$OverTime)
hr_data$WorkLifeBalance <- as.factor(hr_data$WorkLifeBalance)

print("=== MULTIPLE LINEAR REGRESSION MODEL ===")

# We are predicting the Salary Hike based on Work-Life Balance, Distance, and Overtime
linear_model <- lm(PercentSalaryHike ~ WorkLifeBalance + DistanceFromHome + OverTime, 
                   data = hr_data)

print(summary(linear_model))
print(confint(linear_model))

print("=== LOGISTIC REGRESSION MODEL ===")

# We are predicting the probability of an employee quitting (Attrition = Yes)
# family = "binomial" is required for logistic regression in R
logistic_model <- glm(Attrition ~ WorkLifeBalance + DistanceFromHome + OverTime, 
                      data = hr_data, 
                      family = "binomial")

# Print the results
print(summary(logistic_model))



print("=== LOGISTIC REGRESSION MODEL ===")
print("=== PerformanceRating as target ===")

# 1. Create a binary target variable (1 = Outstanding, 0 = Excellent)
hr_data$TopPerformer <- ifelse(hr_data$PerformanceRating == 4, 1, 0)

# Ensure WorkLifeBalance is still treated as a category
hr_data$WorkLifeBalance <- as.factor(hr_data$WorkLifeBalance)

# 2. Run the standard logistic regression model
productivity_model <- glm(TopPerformer ~ WorkLifeBalance + DistanceFromHome + OverTime, 
                          family = "binomial", 
                          data = hr_data)

# 3. View the results
summary(productivity_model)

# 4. View the Odds Ratios (to see the exact multipliers)
exp(coef(productivity_model))
