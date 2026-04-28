library(tidyverse) # Includes ggplot2 for charts and dplyr for tables
library(corrplot)  # heatmap
library(scales) #format chart axes

#install packages
install.packages(c("tidyverse", "corrplot", "scales"))

#load the preprocessed dataset
df <- read.csv("data/processed/cleaned_hr_data_.csv")
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
       x = "Work-Life Balance Level (1-4)", y = "Count of Employees")
ggsave("results/plots/01_wlb_distribution.png", width = 8, height = 6)

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
# Proportional Bar Chart
ggplot(df, aes(x = as.factor(WorkLifeBalance), fill = as.factor(PerformanceRating))) +
  geom_bar(position = "fill") +
  scale_y_continuous(labels = percent) +
  scale_fill_manual(values = c("#99d8c9", "#2ca25f")) +
  theme_minimal() +
  labs(title = "Performance Rating Proportions by Work-Life Balance",
       x = "Work-Life Balance Level (1-4)", 
       y = "Percentage (%)", 
       fill = "Performance Rating")


#create correlation heatmap
# 1. Select only the numeric columns (correlation doesn't work on text)
numeric_data <- df %>% select_if(is.numeric)

# 2. Create the matrix (the object R says is missing)
cor_matrix <- cor(numeric_data, use = "complete.obs")

# 3. NOW run your corrplot command
corrplot(cor_matrix, 
         method = "color", 
         type = "upper", 
         order = "hclust", 
         addCoef.col = "black", 
         number.cex = 0.7, 
         tl.col = "black", 
         tl.srt = 45, 
         diag = FALSE, 
         title = "\n\n Correlation Heatmap of Employee Features",
         mar = c(0,0,1,0))

# This will find the existing file and replace its contents with the new plot
png(height=800, width=800, file="results/plots/05_correlation_heatmap.png")

corrplot(cor_matrix, 
         method="color", 
         type="upper", 
         order="hclust", 
         addCoef.col="black", 
         tl.col="black", 
         tl.srt=45, 
         diag=FALSE)

dev.off() # This "closes" the file and saves the changes