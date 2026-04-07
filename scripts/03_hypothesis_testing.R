# -------------------------------------------------------------------------
# Script 03: Inferential Analysis & ANOVA
# Member: Navoda D G H (IT23265806)
# Goal: Perform correlation, hypothesis testing, ANOVA, and post-hoc analysis
# -------------------------------------------------------------------------

# Load cleaned dataset - Using relative paths
data <- read.csv("data/processed/cleaned_hr_data.csv")

# Convert WorkLifeBalance to factor for ANOVA
data$WorkLifeBalance <- as.factor(data$WorkLifeBalance)