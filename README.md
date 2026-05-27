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
├── sql/
│   ├── healthcare_records.sql
|
├── dataset/
│   ├── cleaned_healthcare_data.csv
│   └── messy_healthcare_data.csv
|
└── README.md
```

---

## Files Included
- `messy_healthcare_data.csv` — Original dataset
- `cleaned_healthcare_data.csv` — Cleaned dataset
- `healthcare_records.sql` — SQL queries used for cleaning

---

## Skills Demonstrated
- SQL Data Cleaning
- Common Table Expressions (CTEs)
- Window Functions
- Data Validation
- Problem Solving


