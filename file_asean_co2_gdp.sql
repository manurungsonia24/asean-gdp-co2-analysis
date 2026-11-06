CREATE DATABASE asean_project;
USE asean_project;

SELECT country_name, country_code,
ROUND(AVG(gdp_per_capita),2) AS average_gdp, 
ROUND(AVG(co2_per_capita),2) AS average_co2 
FROM gdp_co2
GROUP BY country_name, country_code
ORDER BY average_co2 DESC;

WITH cte AS (SELECT country_name, country_code,
SUM(CASE WHEN year = 2010 THEN gdp_per_capita END) AS gdp_2010,
SUM(CASE WHEN year = 2023 THEN gdp_per_capita END) AS gdp_2023,
SUM(CASE WHEN year = 2010 THEN co2_per_capita END) AS co2_2010,
SUM(CASE WHEN year = 2023 THEN co2_per_capita END) AS co2_2023
FROM gdp_co2
GROUP BY country_name, country_code)

SELECT country_name, country_code, 
ROUND((gdp_2023 - gdp_2010) / gdp_2010 * 100, 2) AS percent_gdp,
ROUND((co2_2023 - co2_2010) / co2_2010 * 100, 2) AS percent_co2
FROM cte;