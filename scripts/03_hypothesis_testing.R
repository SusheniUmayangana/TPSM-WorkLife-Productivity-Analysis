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