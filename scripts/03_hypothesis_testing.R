# -------------------------------------------------------------------------
# Script 03: Inferential Analysis & ANOVA
# Member: Navoda D G H (IT23265806)
# Goal: Perform correlation, hypothesis testing, ANOVA, and post-hoc analysis
# -------------------------------------------------------------------------

# 1. Load Data and Setup Factors
data <- read.csv("data/processed/cleaned_hr_data.csv")

# Ensure IV is a factor and DV is numeric for the correlation
data$WorkLifeBalance <- as.factor(data$WorkLifeBalance)
data$Performance_Binary <- as.numeric(as.character(data$Performance_Binary))