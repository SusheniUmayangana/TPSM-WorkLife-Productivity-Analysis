# 🧹 Data Pre-processing & Quality Audit Summary
**Member Responsible:** Kalubowila K S U (IT23256378)

---

## 1. Data Integrity & Initial Assessment
Upon initial inspection of the IBM HR Analytics dataset, a data quality audit was performed to identify missingness and inconsistencies. The raw data contained several gaps that required statistical intervention before modeling could begin:

* **WorkLifeBalance:** 5% missing values identified (Numerical/Ordinal).
* **OverTime:** 3% missing values identified (Categorical).

Maintaining the original sample size ($N = 1470$) was prioritized to ensure the statistical power and reliability of our subsequent stochastic models.

---

## 2. Statistical Imputation Strategy
To address the missingness without introducing significant bias, a **Dual-Imputation Strategy** was implemented:

### 🔸 Median Imputation — *WorkLifeBalance*
For the numerical/ordinal variable `WorkLifeBalance`, we utilized **Median Imputation**. The median was selected over the mean because the variable exists on a discrete 1–4 scale. This approach ensures the central tendency is preserved without introducing non-existent decimal values (e.g., a balance score of 2.4).

### 🔸 Mode Imputation — *OverTime*
For the categorical variable `OverTime`, a custom R function was developed to perform **Mode Imputation**. Missing entries were replaced with the most frequent class identified in the dataset ("No"). This ensures the categorical distribution remains realistic for the HR context.



---

## 3. Feature Selection & Engineering
To prepare the dataset for **Ordinary Least Squares (OLS)** regression and **ANOVA**, the following optimizations were performed:

### 🔸 Zero-Variance Variable Removal
We identified and removed four variables that were constant across all 1,470 observations:
* `EmployeeCount`, `Over18`, `StandardHours`, and `EmployeeNumber`.

These variables were excluded as they provide zero mathematical variance. Including them would lead to computational singularities (errors) during the predictive modeling phase.

### 🔸 Factor Level Encoding
To ensure R correctly interprets qualitative data, categorical predictors were converted into **Factors**. This is a crucial step for the regression model to generate correct dummy variables for:
* `OverTime`
* `Department`
* `BusinessTravel`

---

## 4. Conclusion
The resulting dataset, **`cleaned_hr_data.csv`**, serves as the finalized **Single Source of Truth** for the project. This rigorous pre-processing pipeline ensures that the project's models are based on high-integrity data, satisfying the fundamental assumptions of statistical inference.