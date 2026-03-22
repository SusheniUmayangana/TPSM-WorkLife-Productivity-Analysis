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




