/*
===============================================================================
Performance Analysis (Year-over-Year, Month-over-Month)
===============================================================================
Purpose:
    - To measure the performance of products, customers, or regions over time.
    - For benchmarking and identifying high-performing entities.
    - To track yearly trends and growth.

SQL Functions Used:
    - LAG(): Accesses data from previous rows.
    - AVG() OVER(): Computes average values within partitions.
    - CASE: Defines conditional logic for trend analysis.
===============================================================================
*/

/* Analyze the yearly performance of products by comparing their sales 
to both the average sales performance of the product and the previous year's sales */

WITH yearly_product_sales AS(

SELECT TO_CHAR(DATE_TRUNC('year',f.order_date::DATE),'YYYY')AS order_year, 
      p.product_name,
      SUM(f.sales_amount) AS current_sales
FROM fact_sales f
LEFT JOIN dim_products p
ON p.product_key = f.product_key 
WHERE f.order_date IS NOT NULL AND f.order_date <> ''
GROUP BY TO_CHAR(DATE_TRUNC('year',f.order_date::DATE),'YYYY'), p.product_name)

SELECT 
order_year,
product_name,
current_sales,
AVG(current_sales) OVER(PARTITION BY product_name) AS AVG_sales,
current_sales - AVG(current_sales) OVER(PARTITION BY product_name) AS diff_avg,
CASE WHEN current_sales - AVG(current_sales) OVER(PARTITION BY product_name) > 0 THEN 'Above Avg'
     WHEN current_sales - AVG(current_sales) OVER(PARTITION BY product_name) < 0 THEN 'Below Avg'
     ELSE 'Avg' END AS Avg_change,
-- Yeat-over-year analysis 
LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) AS previous_year,
current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) AS diff_previous_year,
CASE WHEN current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) > 0 THEN 'Increase'
     WHEN current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) < 0 THEN 'Decrease'
     ELSE 'No change' END AS previous_year_change

FROM yearly_product_sales
ORDER BY product_name, order_year;


