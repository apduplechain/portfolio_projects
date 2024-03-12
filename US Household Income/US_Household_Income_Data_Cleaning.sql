# US Household Income Data Cleaning

ALTER TABLE us_project.us_household_income_statistics RENAME COLUMN `ï»¿id` TO `id`;

SELECT *
FROM us_project.us_household_income
;

SELECT *
FROM us_project.us_household_income_statistics
;

SELECT COUNT(id)
FROM us_project.us_household_income
;

SELECT COUNT(id)
FROM us_project.us_household_income_statistics
;

SELECT id, COUNT(id)
FROM us_project.us_household_income
GROUP BY id
HAVING COUNT(id) > 1
;

SELECT *
FROM (
	SELECT 
		row_id,
        id,
        ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
        FROM us_project.us_household_income
) duplicates
WHERE row_num > 1
;

SELECT id, COUNT(id)
FROM us_project.us_household_income_statistics
GROUP BY id
HAVING COUNT(id) > 1
;

DELETE FROM us_project.us_household_income
WHERE row_id IN (
	SELECT row_id
    FROM (
		SELECT 
			row_id,
			id,
			ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
		FROM us_project.us_household_income
) duplicates
WHERE row_num > 1
)
;

SELECT DISTINCT state_name
FROM us_project.us_household_income
ORDER BY 1
;

UPDATE us_project.us_household_income
SET state_name = 'Alabama'
WHERE state_name = 'alabama'
;

SELECT *
FROM us_project.us_household_income
WHERE county = 'Autauga County'
ORDER BY 1
;

UPDATE us_project.us_household_income
SET place = 'Autaugaville'
WHERE county = 'Autauga County'
AND city = 'Vinemont'
;

SELECT type, COUNT(type)
FROM us_project.us_household_income
GROUP BY type
;

UPDATE us_project.us_household_income
SET type = 'Borough'
WHERE type = 'Boroughs'
;

SELECT aland, awater
FROM us_project.us_household_income
WHERE (aland = 0 OR aland = '' OR aland IS NULL)
;