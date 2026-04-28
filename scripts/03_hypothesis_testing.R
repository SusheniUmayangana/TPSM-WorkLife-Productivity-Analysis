# -------------------------------------------------------------------------
# Script 03: Inferential Analysis & ANOVA
# Member: Navoda D G H (IT23265806)
# Goal: Perform correlation, hypothesis testing, ANOVA, and post-hoc analysis
# -------------------------------------------------------------------------

# 1. Load Data and Setup Factors
data <- read.csv("data/processed/cleaned_hr_data.csv")
data$WorkLifeBalance <- as.factor(data$WorkLifeBalance)