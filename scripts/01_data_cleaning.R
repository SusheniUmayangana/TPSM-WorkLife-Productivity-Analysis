# -------------------------------------------------------------------------
# Script 01: Data Cleaning and Feature Selection
# Member: Kalubowila K S U (IT23256378)
# Goal: Prepare the 'Single Source of Truth' for the team.
# -------------------------------------------------------------------------

setwd("C:/Users/acer/Desktop/Statbits")

# 1. Import Raw Data
raw_data <- read.csv("data/raw/WA_Fn-UseC_-HR-Employee-Attrition_dataset.csv")
head(raw_data)


# 2. Check for missing values 
print("Missing values count:")
print(sum(is.na(raw_data)))


# 3. PRE-PROCESSING: Multi-Strategy Imputation
# A: Median Imputation for Numeric/Ordinal (WorkLifeBalance)
wlb_median <- median(raw_data$WorkLifeBalance, na.rm = TRUE)
raw_data$WorkLifeBalance[is.na(raw_data$WorkLifeBalance)] <- wlb_median

# B: Mode Imputation for Categorical (OverTime)
# Since 'OverTime' is Yes/No, we fill NAs with the most frequent value
get_mode <- function(x) {
  ux <- unique(na.omit(x))
  ux[which.max(tabulate(match(x, ux)))]
}
ot_mode <- get_mode(raw_data$OverTime)
raw_data$OverTime[is.na(raw_data$OverTime)] <- ot_mode


# 4. Feature Selection (Removing Zero-Variance Variables)
# These columns have the same value for every row, so they are useless for modeling.
cols_to_remove <- c("EmployeeCount", "Over18", "StandardHours", "EmployeeNumber")
cleaned_data <- raw_data[, !(names(raw_data) %in% cols_to_remove)]

# 5. Data Transformation
# Ensure Performance and WorkLifeBalance are numbers for the model
cleaned_data$WorkLifeBalance <- as.numeric(cleaned_data$WorkLifeBalance)
cleaned_data$PerformanceRating <- as.numeric(cleaned_data$PerformanceRating)


# Convert Categories to Factors (Important for Regression)
cleaned_data$OverTime <- as.factor(cleaned_data$OverTime)
cleaned_data$BusinessTravel <- as.factor(cleaned_data$BusinessTravel)
cleaned_data$Department <- as.factor(cleaned_data$Department)


# 6. Export Cleaned Data
write.csv(cleaned_data, "data/processed/cleaned_hr_data.csv", row.names = FALSE)

print("SUCCESS: Cleaned data exported to data/processed/cleaned_hr_data.csv")

#Check Data Types
str(cleaned_data)
