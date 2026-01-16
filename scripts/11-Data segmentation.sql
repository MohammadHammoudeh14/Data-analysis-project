/*
===============================================================================
Data Segmentation Analysis
===============================================================================
Purpose:
    - To group data into meaningful categories for targeted insights.
    - For customer segmentation, product categorization, or regional analysis.

SQL Functions Used:
    - CASE: Defines custom segmentation logic.
    - GROUP BY: Groups data into segments.
===============================================================================
*/

/*Segment products into cost ranges and 
count how many products fall into each segment*/

WITH product_segments AS(
SELECT 
product_key,
product_name,
cost,
CASE WHEN cost < 100 THEN 'Below 100'
     WHEN cost BETWEEN 100 AND 500 THEN '100-500'
     WHEN cost BETWEEN 500 AND 1000 THEN '500-1000'
     ELSE 'Above 1001' END AS cost_range
FROM dim_products)

SELECT 
cost_range,
COUNT(product_key) AS total_products
FROM product_segments
GROUP BY cost_range
ORDER BY total_products DESC;

/*Group customers into three segments based on their spending behavior:
	- VIP: Customers with at least 12 months of history and spending more than €5,000.
	- Regular: Customers with at least 12 months of history but spending €5,000 or less.
	- New: Customers with a lifespan less than 12 months.
And find the total number of customers by each group
*/

WITH customer_spending AS (
SELECT 
    c.customer_key::TEXT AS customer_key,
    SUM(f.sales_amount) AS total_spending,
    MIN(f.order_date::DATE) AS first_order,
    MAX(f.order_date::DATE) AS last_order,
    DATE_PART('year', AGE(MAX(f.order_date::DATE), MIN(f.order_date::DATE))) * 12
    + DATE_PART('month', AGE(MAX(f.order_date::DATE), MIN(f.order_date::DATE))) AS lifespan
FROM fact_sales f
LEFT JOIN dim_customers c
    ON c.customer_key = f.customer_key
WHERE f.order_date IS NOT NULL
  AND f.order_date <> ''
GROUP BY c.customer_key
)

SELECT
Customer_segments,
COUNT(customer_key) AS total_customers
FROM(
 SELECT 
 customer_key,
 CASE WHEN lifespan >= 12 AND total_spending > 5000 THEN 'VIP'
      WHEN lifespan >= 12 AND total_spending <= 5000 THEN 'Regular'
      ELSE 'NEW' END AS Customer_segments
 FROM customer_spending
)m
GROUP BY Customer_segments
ORDER BY total_customers DESC;









