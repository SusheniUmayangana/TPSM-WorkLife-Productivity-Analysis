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