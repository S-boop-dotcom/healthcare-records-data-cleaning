# Healthcare Records Data Cleaning in SQL

## Project Overview
This project focuses on cleaning and preparing a healthcare records dataset using SQL in MySQL.

The dataset contained several common data quality issues that needed to be resolved before analysis could be performed effectively. The goal of this project was to improve data consistency, accuracy, and usability for future analytical tasks.

---

## Tools Used
- MySQL
- SQL
- GitHub

---

## Dataset Information
The dataset contains healthcare-related records and includes information used for data cleaning and exploratory analysis practice.

---

## Data Cleaning Tasks Performed

### 1. Duplicate Removal
- Identified duplicate records using window functions and CTEs
- Removed unnecessary duplicate rows

### 2. Handling Missing Values
- Checked for null and blank values
- Standardized missing or incomplete data fields

### 3. Data Standardization
- Cleaned inconsistent text formatting
- Standardized categorical values
- Improved overall data consistency

### 4. Data Validation
- Investigated unusual or invalid values
- Applied cleaning logic to improve data quality

---


## Project Structure

```text
healthcare-records-data-cleaning/
│
├── dataset/
│   ├── healthcare_records_raw.csv
│   └── healthcare_records_cleaned.csv
│
├── sql/
│   ├── data_cleaning.sql
│   └── exploratory_analysis.sql
│
└── README.md
```

---

## Files Included
- `healthcare_records_raw.csv` — Original dataset
- `healthcare_records_cleaned.csv` — Cleaned dataset
- `data_cleaning.sql` — SQL queries used for cleaning

---

## Skills Demonstrated
- SQL Data Cleaning
- Common Table Expressions (CTEs)
- Window Functions
- Data Validation
- Exploratory Data Analysis (EDA)
- Problem Solving

---

## Conclusion
This project demonstrates practical SQL data cleaning techniques used to prepare raw healthcare data for analysis. The cleaning process improved the overall reliability and consistency of the dataset for future analytical use.
