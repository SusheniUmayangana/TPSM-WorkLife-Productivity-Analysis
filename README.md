# 🏗️ Data Architecture & Engineering Phase
**Owner:** Kalubowila K S U (IT23256378)
**Branch:** `feature/susheni/data-architecture-engineering`

This branch serves as the foundation for the TPSM project. It contains the logic for the **Data Audit**, **Stochastic Imputation**, and **Feature Engineering** required to transform the raw IBM HR dataset into a model-ready "Single Source of Truth."

## 🛠️ Technical Contributions

### 1. Data Quality Audit
I performed an initial audit to identify missingness patterns. To maintain the statistical power of the dataset ($N=1470$), I implemented a dual-imputation strategy:
* **WorkLifeBalance (Ordinal):** Resolved via **Median Imputation** to preserve the discrete 1-4 scale.
* **OverTime (Categorical):** Resolved via **Mode Imputation** using a custom R function to maintain categorical frequency.

### 2. Feature Engineering (Binary Re-coding)
Detected a **Ceiling Effect** in `PerformanceRating` (only values 3 and 4 were present). I engineered a new binary feature to support robust categorical modeling:
* **`Performance_Binary`**: `0` (Excellent) | `1` (Outstanding).

### 3. Dimensionality Reduction
Removed zero-variance variables to satisfy the assumptions of **Ordinary Least Squares (OLS)** regression:
* Excluded: `EmployeeCount`, `Over18`, `StandardHours`, and `EmployeeNumber`.

### 4. Repository Governance
* Implemented a structured `.gitignore` to exclude local environment files (`.RData`, `.Rhistory`).
* Established the project directory structure for `scripts/`, `data/`, and `results/`.

## 📂 Key Artifacts
* `scripts/01_data_cleaning.R`: The reproducible pre-processing pipeline.
* `data/processed/cleaned_hr_data.csv`: The finalized dataset for team-wide use.
* `results/summary/data_cleaning_summary.md`: Technical documentation of the audit.
* `research pp/`: Contains the foundational academic literature (Fisher et al., 2003) used to justify the WLB metrics and imputation logic.

## 📚 Theoretical Basis
Imputation and variable scaling strategies were informed by the **Fisher et al. (2003)** model, ensuring that our data cleaning aligns with established HR analytics frameworks.

---
**Status:** Merged into `dev` | **Role:** Data Architect
