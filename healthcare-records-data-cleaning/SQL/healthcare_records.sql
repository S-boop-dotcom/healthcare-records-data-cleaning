-- DATA CLEANING WITH MySQL
-- Messy healthcare data


-- 1. Find and remove duplicates
-- 2. Standardize the data
-- 3. Handle NULL and blank values
-- 4. Remove any unnecessary rows and columns

SELECT *
FROM messy_healthcare_data;

-- Creating a table similar to the original for refence and keeping the original safe
CREATE TABLE healthcare_records
LIKE messy_healthcare_data;

INSERT healthcare_records
SELECT *
FROM messy_healthcare_data;

-- Verify
SELECT *
FROM healthcare_records;


-- 1. Find and remove duplicates
SELECT *, ROW_NUMBER() OVER(
PARTITION BY PatientID , FullName, DOB, BloodType, Weight, Height_cm, BillAmount
) as row_num
FROM healthcare_records
ORDER BY row_num
;

WITH duplicate_cte AS
(
SELECT *, ROW_NUMBER() OVER(
PARTITION BY PatientID , FullName, DOB, BloodType, Weight, Height_cm, BillAmount
) as row_num
FROM healthcare_records
ORDER BY row_num
)
SELECT *
FROM duplicate_cte
WHERE PatientID = "PT-103141";
SELECT *
FROM duplicate_cte
WHERE row_num > 1;



-- Create another table with an additional tabel 'row_num' to perform a 'delete' operation

CREATE TABLE `healthcare_records2` (
  `PatientID` text,
  `FullName` text,
  `DOB` text,
  `BloodType` text,
  `Weight` text,
  `Height_cm` double DEFAULT NULL,
  `BillAmount` double DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT healthcare_records2
SELECT *, ROW_NUMBER() OVER(
PARTITION BY PatientID , FullName, DOB, BloodType, Weight, Height_cm, BillAmount
) as row_num
FROM healthcare_records
ORDER BY row_num;


SELECT *
FROM healthcare_records2;

SELECT *
FROM healthcare_records2
WHERE row_num > 1
;

DELETE 
FROM healthcare_records2
WHERE row_num > 1;

-- Verify (should return 0 rows)!
SELECT *
FROM healthcare_records2
WHERE row_num > 1
;


-- 2. Standardize the data
SELECT *
FROM healthcare_records2;

SELECT *
FROM healthcare_records2
WHERE Height_cm < 0
;

SELECT *
FROM healthcare_records2
WHERE Weight < 0
;

SELECT *
FROM healthcare_records2
WHERE BillAmount < 0
;

SELECT *
FROM healthcare_records2 
WHERE Weight LIKE '%lbs';

SELECT Weight, TRIM(REPLACE(Weight,'lbs','')) as clean_weight
FROM healthcare_records2
WHERE Weight LIKE '%lbs';


UPDATE healthcare_records2
SET Weight = TRIM(REPLACE(Weight,'lbs',''))
WHERE Weight LIKE '%lbs';


-- Check for any remaining non-numeric values
SELECT DISTINCT Weight
FROM healthcare_records2
WHERE Weight REGEXP '[^0-9.]';

UPDATE healthcare_records2
SET Weight = NULL 
WHERE Weight REGEXP '[^0-9.]';

SELECT DISTINCT BloodType, COUNT(*) AS cnt
FROM healthcare_records2
GROUP BY BloodType
ORDER BY BloodType
;

SELECT BloodType, TRIM(REPLACE(BloodType,' positive','+') ) as blood
FROM healthcare_records2
WHERE BloodType LIKE '%positive'
;

UPDATE healthcare_records2
SET BloodType = TRIM(REPLACE(BloodType,' positive','+') )
WHERE BloodType LIKE '%positive'
;

UPDATE healthcare_records2
SET BloodType = NULL 
WHERE BloodType = '' OR BloodType = '-'
;

UPDATE healthcare_records2
SET BloodType = NULL 
WHERE BloodType = 'unknown' 
;

SELECT *
FROM healthcare_records2;

-- Standardize all blank/placeholder values to NULL across columns
UPDATE healthcare_records2
SET
  FullName    = NULLIF(TRIM(FullName), ''),
  DOB   = CASE 
			WHEN TRIM(DOB) IN ('', 'None') THEN NULL 
			ELSE DOB
		  END,
  BloodType      = NULLIF(TRIM(BloodType), ''),
  Weight         = NULLIF(TRIM(CAST(Weight AS CHAR)), ''),
  Height_cm         = NULLIF(TRIM(CAST(Height_cm AS CHAR)), ''),
  BillAmount  = NULLIF(TRIM(CAST(BillAmount AS CHAR)), '');

SELECT *
FROM healthcare_records2;


-- Rerun the format checker, should only show values in YYYY-MM-DD now
SELECT
    SUM(CASE WHEN STR_TO_DATE(DOB, '%Y-%m-%d') IS NOT NULL THEN 1 ELSE 0 END) AS YYYY_MM_DD,
    SUM(CASE WHEN STR_TO_DATE(DOB, '%m/%d/%Y') IS NOT NULL THEN 1 ELSE 0 END) AS MM_DD_YYYY,
    SUM(CASE WHEN STR_TO_DATE(DOB, '%d/%m/%Y') IS NOT NULL THEN 1 ELSE 0 END) AS DD_MM_YYYY,
    SUM(CASE WHEN STR_TO_DATE(DOB, '%M %d, %Y') IS NOT NULL THEN 1 ELSE 0 END) AS Month_DD_YYYY
FROM healthcare_records2;

SELECT DOB, STR_TO_DATE(DOB, '%d/%m/%Y') AS converted
FROM healthcare_records2
WHERE DOB REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$'
;

UPDATE healthcare_records2
SET DOB = STR_TO_DATE(DOB, '%d/%m/%Y')
WHERE DOB REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$'
;

SELECT DOB, STR_TO_DATE(DOB, '%m/%d/%Y') AS converted
FROM healthcare_records2
WHERE DOB REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$'
;

UPDATE healthcare_records2
SET DOB = STR_TO_DATE(DOB, '%d/%m/%Y')
WHERE DOB REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$'
;

SELECT *
FROM healthcare_records2;

ALTER TABLE healthcare_records2
MODIFY COLUMN DOB DATE;

ALTER TABLE healthcare_records2
DROP COLUMN row_num;
