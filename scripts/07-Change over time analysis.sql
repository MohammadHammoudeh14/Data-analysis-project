/*
===============================================================================
Change Over Time Analysis
===============================================================================
Purpose:
    - To track trends, growth, and changes in key metrics over time.
    - For time-series analysis and identifying seasonality.
    - To measure growth or decline over specific periods.

SQL Functions Used:
    - Date Functions: DATEPART(), DATETRUNC(), FORMAT()
    - Aggregate Functions: SUM(), COUNT(), AVG()
===============================================================================
*/

-- Analyse sales performance over time
-- Quick Date Functions

-- Yearly-Monthly Analysis
SELECT
    EXTRACT(YEAR FROM order_date::DATE) AS order_year,
    EXTRACT(MONTH FROM order_date::DATE) AS order_month,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM fact_sales
WHERE order_date IS NOT NULL AND order_date <> ''
GROUP BY
    EXTRACT(YEAR FROM order_date::DATE),
    EXTRACT(MONTH FROM order_date::DATE)
ORDER BY
    order_year,
    order_month;

-- DATE_TRUNC()
SELECT
    date_trunc('month', order_date::date) AS order_month,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM fact_sales
WHERE order_date IS NOT NULL
  AND order_date <> ''
GROUP BY date_trunc('month', order_date::date)
ORDER BY order_month;

-- TO_CHAR()
SELECT
    TO_CHAR(order_date::date, 'YYYY-Mon') AS order_month,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM fact_sales
WHERE order_date IS NOT NULL
  AND order_date <> ''
GROUP BY TO_CHAR(order_date::date, 'YYYY-Mon')
ORDER BY TO_CHAR(order_date::date, 'YYYY-Mon');

-- Here I made the time analysis with 3 different ways but the same result. 



 
