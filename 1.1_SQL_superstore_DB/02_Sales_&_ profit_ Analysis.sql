use superstore_db;

# SALES & PROFIT ANALYSIS 

# GOAL - How is the business performing over time and across products?

# 1. OverAll business perfimance

#-- Total sales and total profit

SELECT 
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM orders;

# Average order values

SELECT 
    SUM(sales) / COUNT(DISTINCT order_id) AS avg_order_value
FROM orders;

# -- Year-wise sales and profit

SELECT 
    YEAR(order_date) AS order_year,
    ROUND(SUM(sales), 2)AS yearly_sales,
    ROUND(SUM(profit),2)AS yearly_profit
FROM orders
GROUP BY YEAR(order_date)
ORDER BY order_year;

#-- Monthly sales trend

SELECT
    YEAR(order_date)  AS order_year,
    MONTH(order_date) AS order_month,
    ROUND(SUM(sales), 2) AS monthly_sales
FROM orders
GROUP BY
    YEAR(order_date),
    MONTH(order_date)
ORDER BY
    order_year,
    order_month;


#-- Top 10 products by sales

SELECT 
    p.product_name,
    ROUND(SUM(o.sales), 2) AS total_sales
FROM orders o 
JOIN products p 
ON o.product_id = p.product_id
GROUP BY p.product_name 
ORDER BY total_sales DESC 
LIMIT 10;


#--Top 10 products by Profit

SELECT 
    p.product_name,
    ROUND(SUM(o.profit), 2) AS total_profit
FROM orders o  
JOIN products p  
ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_profit DESC 
LIMIT 10;

#-- Products with high sales but low profit or negative profit

SELECT 
    p.product_name,
    ROUND(SUM(o.sales), 2) AS total_sales,
    ROUND(SUM(o.profit), 2) AS total_profit
FROM orders o  
JOIN products p 
ON o.product_id = p.product_id
GROUP BY p.product_name
HAVING total_sales > 10000
    AND total_profit < 0
ORDER BY total_sales DESC
LIMIT 10;


#-- Category-level perfomance
# Category and profit by category

SELECT
    p.category,
    ROUND(SUM(o.sales), 2) AS category_sales,
    ROUND(SUM(o.profit), 2) AS category_profit
FROM orders o 
JOIN products p  
ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY category_sales DESC
LIMIT 10;



# -- Profit margin by category

SELECT 
    p.category,
    ROUND(SUM(o.profit) / SUM(o.sales) * 100, 2) AS profit_margin_pct
FROM orders o 
JOIN products p 
ON o.product_id = p.product_id
GROUP BY p.category;


#-- Check average discount for these products

SELECT
    p.product_name,
    ROUND(AVG(o.discount), 2) AS avg_discount,
    ROUND(SUM(o.sales), 2) AS total_sales,
    ROUND(SUM(o.profit), 2) AS total_profit
FROM orders o
JOIN products p
ON o.product_id = p.product_id
GROUP BY p.product_name
HAVING total_profit < 0
ORDER BY total_sales DESC;

-- Sales per yer 

SELECT 
    YEAR(order_date) AS order_year,
    SUM(sales) AS total_sales
FROM orders
GROUP BY YEAR(order_date)
ORDER BY order_year;

# Profit per year

SELECT 
    YEAR(order_date) AS order_year,
    SUM(profit) AS total_profit
FROM orders
GROUP BY YEAR(order_date)
ORDER BY order_year;

# sales per month 

SELECT 
	YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(SALES) AS total_sales
FROM orders 
GROUP BY order_year, order_month
ORDER BY order_year, order_month;


/*
    “I analyzed sales and profitability trends using SQL,
    identified top and bottom products, 
    and highlighted high-revenue but loss-making items.”

*/



SELECT 
    MAX(Year(order_date)) AS max_year,
    MIN(YEAR(order_date)) AS min_year
FROM orders;
















