# US Household Income Exploratory Data Analysis

# Select all from us_household_income table
SELECT *
FROM us_project.us_household_income
;

# Select all from us_household_income_statistics table
SELECT *
FROM us_project.us_household_income_statistics
;

# Top 10 Sum of all land mass and water mass per state ordered by land
SELECT state_name, SUM(aland), SUM(awater)
FROM us_project.us_household_income
GROUP BY state_name
ORDER BY 2 DESC
LIMIT 10
;

# Top 10 Sum of all land mass and water mass per state ordered by water
SELECT state_name, SUM(aland), SUM(awater)
FROM us_project.us_household_income
GROUP BY state_name
ORDER BY 3 DESC
LIMIT 10
;

# Inner join of the two tables
SELECT *
FROM us_project.us_household_income u 
JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
;

# Joined tables with all data excluding rows without a mean
SELECT *
FROM us_project.us_household_income u 
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE mean <> 0
;

# Joined tables excluding rows without a mean
SELECT u.state_name, county, type, `primary`, mean, median
FROM us_project.us_household_income u 
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE mean <> 0
;

# Avg mean and median income per state
SELECT u.state_name, ROUND(AVG(mean),1), ROUND(AVG(median),1)
FROM us_project.us_household_income u 
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE mean <> 0
GROUP BY u.state_name
ORDER BY 3 DESC
LIMIT 10
;

# Avg mean and median income per type with count of type
SELECT u.type, COUNT(type), ROUND(AVG(mean),1), ROUND(AVG(median),1)
FROM us_project.us_household_income u 
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE mean <> 0
GROUP BY u.type
ORDER BY 4 DESC
LIMIT 20
;

# All data with type = community
SELECT *
FROM us_project.us_household_income
WHERE type = 'Community'
;

# Avg mean and median income per type with count of type > 100
SELECT u.type, COUNT(type), ROUND(AVG(mean),1), ROUND(AVG(median),1)
FROM us_project.us_household_income u 
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE mean <> 0
GROUP BY 1
HAVING COUNT(type) > 100
ORDER BY 4 DESC
LIMIT 20
;

# Avg mean and median income per city and state
SELECT u.state_name, city, ROUND(AVG(mean),1), ROUND(AVG(median),1)
FROM us_project.us_household_income u 
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
GROUP BY u.state_name, city
ORDER BY ROUND(AVG(mean),1) DESC
;