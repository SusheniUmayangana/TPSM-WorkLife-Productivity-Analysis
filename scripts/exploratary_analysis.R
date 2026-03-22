library(tidyverse) # Includes ggplot2 for charts and dplyr for tables
library(corrplot)  # heatmap
library(scales) #format chart axes

#install packages
install.packages(c("tidyverse", "corrplot", "scales"))

#load the preprocessed dataset
df <- read.csv("data/processed/cleaned_hr_data.csv")
head(df)

#view dimensions and columns and check data types
dim(df)
colnames(df)
str(df)

#check missing values
sum(is.na(df))

#univarate analysis
#summary of independent variable
summary(df$WorkLifeBalance)
sd(df$WorkLifeBalance)

#frequency table
wlb_table <- table(df$WorkLifeBalance)
print(wlb_table)

#propotions
prop.table(wlb_table) * 100

#univarate visualizations
#bar chart for work life balance
# Visualizing Work-Life Balance Distribution (LO2)
ggplot(df, aes(x = as.factor(WorkLifeBalance), fill = as.factor(WorkLifeBalance))) +
  geom_bar() +
  scale_fill_brewer(palette = "Blues") +
  theme_minimal() +
  labs(title = "Distribution of Work-Life Balance Levels",
       subtitle = "Visualizing the spread of the Independent Variable",
       x = "Work-Life Balance Level (1=Bad, 4=Best)", 
       y = "Count of Employees",
       fill = "WLB Level")

#histogram for monthly income distribution
ggplot(df, aes(x = MonthlyIncome)) +
  geom_histogram(bins = 30, fill = "midnightblue", color = "white") +
  theme_light() +
  labs(title = "Distribution of Monthly Income",
       subtitle = "Checking for Skewness in Employee Salary",
       x = "Monthly Income ($)", 
       y = "Number of Employees")

# Bivariate Analysis
# box plot for Monthly Income vs. Work-Life Balance (LO2)
ggplot(df, aes(x = as.factor(WorkLifeBalance), y = MonthlyIncome, fill = as.factor(WorkLifeBalance))) +
  geom_boxplot(outlier.colour = "red", outlier.shape = 16, outlier.size = 2) +
  theme_light() +
  scale_fill_brewer(palette = "Blues") +
  labs(title = "Monthly Income Distribution by Work-Life Balance Level",
       subtitle = "A traditional boxplot showing Medians, Quartiles, and Outliers",
       x = "Work-Life Balance Level (1-4)", 
       y = "Monthly Income ($)",
       fill = "WLB Level")


#stacked bar chart for proportions work-life balance vs. performance rating
ggplot(df, aes(x = as.factor(WorkLifeBalance), fill = as.factor(PerformanceRating))) +
  geom_bar(position = "fill") +
  scale_y_continuous(labels = scales::percent) +
  scale_fill_manual(values = c("#A1D99B", "#238B45"), name = "Performance") + 
  theme_classic() +
  labs(title = "Proportion of Performance Ratings by WLB Level",
       x = "Work-Life Balance Level (1-4)", 
       y = "Percentage of Employees (%)")
