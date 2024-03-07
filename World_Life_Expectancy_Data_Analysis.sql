# World Life Expectancy Project (Exploratory Data Analysis)

# Select all data from table
SELECT *
FROM world_life_expectancy
;

# All countries min and max life expectancy
SELECT 
	country, 
    MIN(`Life expectancy`) AS Life_Expectancy_Min, 
    MAX(`Life expectancy`) AS Life_Expectancy_Max,
    ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`),1) AS Life_Increase_15_Years
FROM world_life_expectancy
GROUP BY country
HAVING MIN(`Life expectancy`) <> 0
AND MAX(`Life expectancy`) <> 0
ORDER BY Life_Increase_15_Years ASC
;

# Average life expectancy year over year
SELECT year, ROUND(AVG(`Life expectancy`),2) AS Avg_Life_Expectancy
FROM world_life_expectancy
WHERE `Life expectancy` <> 0
AND `Life expectancy` <> 0
GROUP BY year
ORDER BY year
;

# Average life expectancy, BMI, and GDP per country
SELECT country, ROUND(AVG(`Life expectancy`),1) AS Life_Exp, ROUND(AVG(GDP),1) AS GDP, ROUND(AVG(BMI),1) AS BMI
FROM world_life_expectancy
GROUP BY country
HAVING Life_Exp > 0
AND GDP > 0
ORDER BY GDP DESC
;

# High GDP vs high life expectancy and low GDP vs low life expectancy
SELECT
	SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) High_GDP_Count,
    AVG(CASE WHEN GDP >= 1500 THEN `Life expectancy` ELSE NULL END) High_GDP_Life_Expectancy,
    SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) Low_GDP_Count,
    AVG(CASE WHEN GDP <= 1500 THEN `Life expectancy` ELSE NULL END) Low_GDP_Life_Expectancy
FROM world_life_expectancy
ORDER BY GDP
;

# High GDP vs high life expectancy and low GDP vs low life expectancy
SELECT
	country,
	ROUND(AVG(`Life expectancy`),1) AS Avg_Life_Expectancy,
    ROUND(AVG(GDP),1) AS Avg_GDP
FROM world_life_expectancy
GROUP BY country
HAVING ROUND(AVG(GDP),1) > 1
ORDER BY 3 DESC
;

# High GDP vs high life expectancy and low GDP vs low life expectancy
SELECT *
FROM world_life_expectancy
;

# Average life expectancy for developing and developed countries
SELECT status, ROUND(AVG(`Life expectancy`),1) AS Avg_Life_Expectancy
FROM world_life_expectancy
GROUP BY status
;

# Count of developed and developing countries with average life expectancy
SELECT status, COUNT(DISTINCT country) AS Country_Count, ROUND(AVG(`Life expectancy`),1) AS Avg_Life_Expectancy
FROM world_life_expectancy
GROUP BY status
;

# Average life expectancy and BMI per country
SELECT country, ROUND(AVG(`Life expectancy`),1) AS Life_Exp, ROUND(AVG(BMI),1) AS BMI
FROM world_life_expectancy
GROUP BY country
HAVING Life_Exp > 0
AND BMI > 0
ORDER BY BMI ASC
;

# Rolling total of adult mortality per year for "United" countries
SELECT
	country,
    year,
    `Life expectancy`,
    `Adult Mortality`,
    SUM(`Adult Mortality`) OVER(PARTITION BY country ORDER BY year) AS Rolling_Total
FROM world_life_expectancy
;