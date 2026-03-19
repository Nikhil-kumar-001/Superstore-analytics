USE superstore_db;

# Customer Segment Analysis

#-- Customer distribution by segment

SELECT 
    segment,
    COUNT(DISTINCT customer_id) AS customer_count
FROM customers
    GROUP BY segment;
    
#-- Order volume by customer segment 

SELECT 
    c.segment,
    COUNT(o.order_item_id) AS order_line_count
FROM orders o 
JOIN customers c 
ON o.customer_id = c.customer_id 
GROUP BY c.Segment
ORDER BY order_line_count DESC;

# Sales by customer segment 

SELECT 
    c.segment,
    ROUND(SUM(o.sales), 2) AS total_sales
    FROM orders o   
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY c.Segment
ORDER BY total_sales DESC;

#--  profit and profit margin by customer segment 

SELECT 
    c.segment,
    ROUND(SUM(o.sales), 2) AS total_sales,
    ROUND(SUM(o.profit), 2) AS total_profit,
    ROUND(SUM(o.profit)/SUM(o.sales) * 100, 2) AS profit_perct
    FROM orders o   
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY c.Segment
ORDER BY total_profit DESC;

# Top 10 Most valued customer

SELECT 
    c.customer_id,
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS order_frequency,
    ROUND(SUM(o.sales),2) AS total_sales,
    ROUND(SUM(o.profit),2) AS total_profit
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY 
    c.customer_id,
    c.customer_name
ORDER BY total_sales DESC
LIMIT 10;



#-- Average order value(AOV) by segment - A classic analyst KPI 

SELECT 
    c.segment,
    ROUND(SUM(o.sales) / COUNT(DISTINCT o.order_id), 2) AS avg_order_value
FROM orders o 
JOIN customers c 
ON o.customer_id = c.customer_id
GROUP BY c.segment;


# -- Top 10 customers by total profit

SELECT 
    c.customer_name,
    c.segment,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(sales), 2) AS total_sales
FROM orders o 
JOIN customers c 
ON c.customer_id = o.customer_id
GROUP BY c.customer_name, c.Segment
ORDER BY total_profit DESC
LIMIT 10;

# -- Customers with high frequency but low profit or Negative profit 

SELECT 
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS order_frequency,
    ROUND(SUM(o.profit), 2)    AS total_profit
FROM orders o 
JOIN customers c 
ON o.customer_id = c.customer_id
GROUP BY c.customer_name
HAVING order_frequency >= 10
AND total_profit < 0
ORDER BY total_profit DESC;


# Product categories they buy
SELECT
    c.customer_name,
    p.category,
    SUM(o.profit) AS total_profit
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
JOIN products p
ON o.product_id = p.product_id
GROUP BY c.customer_name, p.category
ORDER BY total_profit;


/* 

“I analyzed customer behavior and segments using SQL, 
comparing order frequency, average order value, 
and profitability to identify valuable and loss-making customer groups.”

*/








































