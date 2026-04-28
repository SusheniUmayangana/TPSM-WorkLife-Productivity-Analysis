# ==========================================
# Script: 02_exploratory_analysis.R
# Project: TPSM Work-Life Productivity Analysis
# Goal: Comprehensive Univariate & Multivariate Visualization
# ==========================================

# --- 1. SETUP ---
library(tidyverse) 
library(corrplot)  
library(scales)    

# Load the "Single Source of Truth" dataset
df <- read.csv("data/processed/cleaned_hr_data_.csv")

# --- 2. UNIVARIATE ANALYSIS ---

# Plot 1: Work-Life Balance (Independent Variable)
ggplot(df, aes(x = as.factor(WorkLifeBalance), fill = as.factor(WorkLifeBalance))) +
  geom_bar() +
  scale_fill_brewer(palette = "Blues") +
  theme_minimal() +
  labs(title = "Distribution of Work-Life Balance Levels",
       subtitle = "Audit of Independent Variable (Ordinal 1-4)",
       x = "Work-Life Balance Level", y = "Count of Employees")
ggsave("results/plots/01_wlb_distribution.png", width = 8, height = 6, dpi = 300)

# Plot 2: Monthly Income Distribution
ggplot(df, aes(x = MonthlyIncome)) +
  geom_histogram(bins = 30, fill = "midnightblue", color = "white") +
  theme_light() +
  labs(title = "Distribution of Monthly Income", 
       subtitle = "Checking for Skewness in Employee Salary",
       x = "Monthly Income ($)", y = "Number of Employees")
ggsave("results/plots/02_income_distribution.png", width = 8, height = 6, dpi = 300)


# --- 3. BIVARIATE ANALYSIS ---

# Plot 3: Boxplot for Monthly Income vs. Work-Life Balance
ggplot(df, aes(x = as.factor(WorkLifeBalance), y = MonthlyIncome, fill = as.factor(WorkLifeBalance))) +
  geom_boxplot(outlier.colour = "red", outlier.shape = 16, outlier.size = 2) +
  theme_light() +
  scale_fill_brewer(palette = "Blues") +
  labs(title = "Monthly Income Distribution by WLB Level",
       subtitle = "Identifying Medians and Outliers across Balance Categories",
       x = "Work-Life Balance Level (1-4)", y = "Monthly Income ($)")
ggsave("results/plots/03_income_boxplot.png", width = 8, height = 6, dpi = 300)

# Plot 4: Performance Binary Proportions (Re-coded Dependent Variable)
# Uses your engineered Performance_Binary (0 = Excellent, 1 = Outstanding)
ggplot(df, aes(x = as.factor(WorkLifeBalance), fill = as.factor(Performance_Binary))) +
  geom_bar(position = "fill") +
  scale_y_continuous(labels = scales::percent) +
  scale_fill_manual(values = c("#99d8c9", "#2ca25f"), 
                    name = "Performance", 
                    labels = c("0: Excellent", "1: Outstanding")) +
  theme_minimal() +
  labs(title = "Performance Proportions by Work-Life Balance",
       subtitle = "Proportional distribution of re-coded binary outcome",
       x = "Work-Life Balance Level (1 = Low, 4 = High)", y = "Percentage (%)")
ggsave("results/plots/04_performance_proportions.png", width = 8, height = 6, dpi = 300)


# 1. Run the Binary Logistic Model (Multivariate)
# We add Age and Income so that dots have different probability 'heights'
log_model_final <- glm(Performance_Binary ~ WorkLifeBalance + MonthlyIncome + Age, 
                       data = df, family = binomial)

# 2. Generate the Probabilities (The continuous Y-axis values)
df$prob_outstanding <- predict(log_model_final, type = "response")

# 3. Create the Scatter Plot
ggplot(df, aes(x = WorkLifeBalance, y = prob_outstanding)) +
  
  # geom_jitter: width spreads dots horizontally; height spreads them slightly vertically
  geom_jitter(color = "midnightblue", alpha = 0.2, width = 0.3, height = 0.01) + 
  
  # geom_smooth: This is the 'trend line' from your reference photo
  geom_smooth(method = "lm", color = "darkred", linewidth = 1.2) + 
  
  theme_minimal() +
  labs(title = "Logistic Regression: Probability of Outstanding Performance",
       subtitle = "Cloud distribution showing likelihood of Rating 4 based on WLB",
       x = "Work-Life Balance Level (1-4)",
       y = "Predicted Probability (0.0 - 1.0)")

# 4. Save the high-resolution version
ggsave("results/plots/final_logistic_scatter.png", width = 8, height = 6, dpi = 300)


# --- 5. CORRELATION HEATMAP ---

numeric_data <- df %>% select_if(is.numeric)
cor_matrix <- cor(numeric_data, use = "complete.obs")

# Saving Heatmap with high resolution for report
png(height=2400, width=2400, res=300, file="results/plots/06_correlation_heatmap.png")
corrplot(cor_matrix, 
         method = "color", 
         type = "upper", 
         order = "hclust", 
         addCoef.col = "black", 
         number.cex = 0.6, 
         tl.col = "black", 
         tl.srt = 45, 
         diag = FALSE, 
         title = "Correlation Heatmap of Employee Features",
         mar = c(0,0,1,0))
dev.off()