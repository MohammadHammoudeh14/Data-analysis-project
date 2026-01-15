/*
===============================================================================
Date Range Exploration 
===============================================================================
Purpose:
    - To determine the temporal boundaries of key data points.
    - To understand the range of historical data.

SQL Functions Used:
    - MIN(), MAX(), DATEDIFF()
===============================================================================
*/

-- Determine the first and last order date and the total duration in months
SELECT 
    MIN(order_date::DATE) AS first_order_date,
    MAX(order_date::DATE) AS last_order_date,
    EXTRACT(YEAR FROM AGE(MAX(order_date::DATE), MIN(order_date::DATE))) * 12
      + EXTRACT(MONTH FROM AGE(MAX(order_date::DATE), MIN(order_date::DATE))) AS order_range_months
FROM fact_sales
WHERE order_date IS NOT NULL
  AND order_date <> '';


-- Find the youngest and oldest customer based on birthdate
SELECT
    MIN(birthdate::DATE) AS oldest_birthdate,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, MIN(birthdate::DATE))) AS oldest_age,
    MAX(birthdate::DATE) AS youngest_birthdate,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, MAX(birthdate::DATE))) AS youngest_age
FROM dim_customers
WHERE birthdate IS NOT NULL
  AND birthdate <> '';