# Data Analysis Project: Sales, Products, and Customers

This project focuses on analyzing sales data using **PostgreSQL**. It includes three main tables: **products**, **customers**, and **sales**. The goal is to explore the data, perform analysis, and generate comprehensive reports for insights.

---

## Project Structure

- **products**: Information about products, including name, category, subcategory, and cost.  
- **customers**: Customer details such as ID, name, and demographics.  
- **sales**: Transactional data including order number, product, customer, quantity, and sales amount.

---

## Data Exploration and Analysis

For each table, the analysis includes:

- Checking data quality and missing values  
- Understanding distributions and patterns  
- Calculating basic statistics (totals, averages, counts, etc.)  
- Identifying relationships between products, customers, and sales

---

## Reports

Two main reports are generated as SQL views:

### 1. Customer Report (`report_customers`)
- Summarizes customer behavior and metrics  
- Includes total orders, total spending, recency, average order value, and customer lifespan  
- Helps identify customer segments and trends

### 2. Product Report (`report_products`)
- Summarizes product-level metrics  
- Includes total orders, total sales, total quantity sold, unique customers, and product lifespan  
- Calculates key KPIs like recency, average order revenue (AOR), and average monthly revenue  
- Helps identify high-performing and low-performing products

> Each report includes comments in the SQL code explaining the purpose of each step and calculation.

---

## Technology

- **PostgreSQL** for data storage, analysis, and report generation
