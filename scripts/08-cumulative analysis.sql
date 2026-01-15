/*
===============================================================================
Cumulative Analysis
===============================================================================
Purpose:
    - To calculate running totals or moving averages for key metrics.
    - To track performance over time cumulatively.
    - Useful for growth analysis or identifying long-term trends.

SQL Functions Used:
    - Window Functions: SUM() OVER(), AVG() OVER()
===============================================================================
*/

-- Calculate the total sales per month 
-- and the running total of sales over time 

SELECT order_date, total_sales,
    SUM(total_sales) OVER(PARTITION BY order_date ORDER BY order_date) AS running_total_sales
    FROM(
SELECT
    TO_CHAR(date_trunc('month', order_date::date), 'YYYY-MM') AS order_date,
    SUM(sales_amount) AS total_sales
FROM fact_sales
WHERE order_date IS NOT NULL
  AND order_date <> ''
GROUP BY date_trunc('month', order_date::date)) t
 
-- Cumulative over year and moving average price

SELECT order_date, total_sales,
       SUM(total_sales) OVER(ORDER BY order_date) AS runnung_yearly_sales,
       ROUND(AVG(avg_price) OVER(ORDER BY order_date),2) AS moving_AVG_price
FROM(
SELECT 
    TO_CHAR(date_trunc('year', order_date::date), 'YYYY-MM') AS order_date,
    SUM(sales_amount) AS total_sales, 
    AVG(price) AS avg_price
FROM fact_sales
WHERE order_date IS NOT NULL 
  AND order_date <> ''
GROUP BY date_trunc('year', order_date::date))t





