# Impact of Work-Life Balance on Employee Productivity: A Statistical Modelling Approach

## 📌 Project Overview
This project investigates the stochastic relationship between **Work-Life Balance** and **Employee Productivity** (measured via Performance Ratings) using the **IBM HR Analytics Attrition & Performance** dataset. 

Developed as part of the **Theory and Practices in Statistical Modelling (TPSM)** module, the study utilizes **R** to move beyond descriptive statistics into inferential and predictive modeling. We explore how personal life harmony, alongside factors like overtime and job satisfaction, influences measurable organizational outcomes.

## 📊 Dataset Details
* **Source:** IBM HR Analytics Employee Attrition & Performance (Secondary Data).
* **Sample Size:** 1,470 observations.
* **Key Variables:**
    * **Dependent (Response):** `PerformanceRating`
    * **Independent (Explanatory):** `WorkLifeBalance` (Ordinal: 1-4)
    * **Control Variables:** `Age`, `OverTime`, `TotalWorkingYears`, `JobSatisfaction`.

## 🛠️ Statistical Methodology
We applied the following statistical workflow in **R**:

1.  **Data Cleaning:** Feature selection to remove zero-variance variables (e.g., `StandardHours`, `EmployeeCount`) and handling categorical factors.
2.  **Exploratory Data Analysis (EDA):** Visualizing distributions and identifying outliers using Boxplots and Histograms to understand data spread.
3.  **Inferential Analysis:** * **Correlation:** Measuring the strength of the linear relationship between balance and performance.
    * **ANOVA:** Comparing performance means across the four levels of Work-Life Balance.
4.  **Predictive Modelling:** * **Multiple Linear Regression:** Using the **Ordinary Least Squares (OLS)** algorithm to estimate coefficients.
5.  **Assumption Testing:** Validating Linearity, Independence, Normality, and Homoscedasticity (the **LINE** assumptions) using residual plots.

## 🚀 Key Findings
* Our model identifies **Work-Life Balance** as a statistically significant predictor of performance ($p < 0.05$).
* Employees with higher balance scores demonstrate more consistent performance ratings, even when controlling for high-stress factors like `OverTime`.
* Diagnostic plots (Q-Q plots and Residuals vs Fitted) confirm the reliability of the OLS estimator for this dataset.

## 📂 Repository Structure

```text
worklife-productivity-analysis/
|
├── data/
│   ├── raw/            # Original IBM HR dataset (read-only)
│   └── processed/      # Cleaned data after feature selection
|
├── scripts/
│   ├── 01_data_cleaning.R        # Handling factors and zero-variance columns
│   ├── 02_exploratory_analysis.R # Descriptive stats and distributions
│   ├── 03_hypothesis_testing.R   # ANOVA and Correlation tests
│   ├── 04_visualizations.R       # ggplot2 script for final charts
│   └── 05_model_summary.R        # Multiple Linear Regression & Residuals
|
├── results/
│   ├── plots/          # Exported visualizations (.png)
│   ├── tables/         # ANOVA and Coefficient outputs (.csv)
│   └── summary/        # Executive statistical findings
|
└── report/             # Final project documentation and Viva notes

```

## 💻 Technical Requirements
* **Language:** R
* **Libraries:** `tidyverse`, `ggplot2`, `caret`, `corrplot`, `broom`

---
## 👥 Team Members
|IT Number| Name | Role |
| :---| :--- | :--- |
| IT23256378 | Kalubowila K S U |... |
| IT23265806 | Navoda D G H | .... |
| IT23242340 | Perera N R S D | ... |
| IT23150102 | Hapugoda H K D S | ... |

---
**Module:** Theory and Practices in Statistical Modelling (TPSM)  
**Academic Year:** 2026
