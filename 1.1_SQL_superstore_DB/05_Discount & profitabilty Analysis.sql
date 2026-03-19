USE superstore_db;

# Discount and profitability analysis
# Are discounts helping the business or hurting it? 
 

# Looking for overall discount behaviour

SELECT 
    ROUND(AVG(discount), 2) AS avg_discount,
    MIN(discount) AS min_discount,
    MAX(discount) AS max_discount
FROM orders;

# Sales and profit by discount level 

SELECT 
    discount,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY discount 
ORDER BY discount;

# Profit margin by discount level 

SELECT 
    discount,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_percentage
FROM orders 
GROUP BY discount 
ORDER BY discount;


# Discount bucket :
-- We are checking how discounts affect sales and profit
-- Profitability by discount bucket
-- order_line_count means -> How many items were sold with this level of discount 

SELECT 
    CASE
        WHEN discount = 0 THEN 'No Discount'
        WHEN discount <= 0.2 THEN 'Low (0-20%)'
        WHEN disCount <= 0.4 THEN  'Medium (21 - 40%)'
        ELSE 'High (40%)'
    END AS discount_bucket,
    COUNT(*) AS order_line_count,
    p.category,
    ROUND(SUM(o.sales), 2) AS total_sales,
    ROUND(SUM(o.profit), 2) AS total_profit
FROM orders o 
JOIN products p 
ON o.product_id = p.product_id
GROUP BY discount_bucket, p.category
ORDER BY total_sales DESC;


/*
   Explaination :- 

  -> As discount increases, profit sharply decreases and eventually turns negative.

So:

  -> Discounts help sales only up to a point
  -> Beyond that point, they destroy profitability

*/


# Category-wise discount impact 

SELECT
    p.category,
    o.discount,
    SUM(o.sales) AS total_sales
FROM orders o 
JOIN products p 
ON o.product_id = p.product_id
GROUP BY p.category, o.discount
ORDER BY p.category, o.discount;

# Average discount by product category :

SELECT
    ROUND(AVG(o.discount),2) AS avg_discount,
    p.category
FROM orders o 
JOIN products p
ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY avg_discount;

# Average discount by product sub - category :

SELECT
    ROUND(AVG(o.discount),2) AS avg_discount,
    p.sub_category
FROM orders o 
JOIN products p
ON o.product_id = p.product_id
GROUP BY p.sub_category
ORDER BY avg_discount;

# How frequently losses occur? 

SELECT 
    p.category,
    SUM(CASE WHEN o.profit < 0 THEN 1 ELSE 0 END) AS loss_orders,
    COUNT(*) AS total_orders,
    ROUND(SUM(CASE WHEN o.profit < 0 THEN 1 ELSE 0 END) / COUNT(*) * 100,2) AS loss_percentage
FROM orders o
JOIN products p
ON o.product_id = p.product_id
GROUP BY p.category;

-- # Sub-category with negative profit
-- SELECT 
--     p.sub_category,
--     ROUND(SUM(o.sales), 2) AS total_sales,
--     ROUND(SUM(o.profit), 2) AS total_profit
-- FROM orders o  
-- JOIN products p 
-- ON o.product_id = p.product_id 
-- GROUP BY p.sub_category
-- HAVING total_profit < 0
-- ORDER BY total_profit;

-- In this we can see that Tables as a sub-category gives the negative total_profit,among all the sub categories

# Top 5 High Discount but low profit products

SELECT 
    p.product_name,
    ROUND(AVG(o.discount), 2) AS avg_discount,
    ROUND(SUM(o.sales), 2) AS total_sales,
    ROUND(SUM(o.profit), 2) AS total_profit
FROM orders o 
JOIN products p 
ON o.product_id = p.product_id
GROUP BY p.product_name
HAVING avg_discount >= 0.3
    AND total_profit < 0
ORDER BY avg_discount DESC
LIMIT 5;

# Discount vs volume trade_off

SELECT 
    discount,
    SUM(quantity) AS total_quantity_sold
FROM orders
GROUP BY Discount
ORDER BY Discount;

# -- Customers with high frequency but low profit or Negative profit with relation of discounts

SELECT
    c.customer_name,
    COUNT(o.order_id) AS order_frequency,
    AVG(o.discount) * 100 AS avg_discount,
    SUM(o.profit) AS total_profit
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY c.customer_name
HAVING total_profit < 0
ORDER BY total_profit ASC;


/*
    “I analyzed discounting strategies using SQL 
    and found that higher discounts increased sales volume but 
    significantly reduced profit margins,
    especially in certain categories and sub-categories.”


*/
	   
SELECT
    p.category,
    COUNT(*) AS order_lines,
    AVG(o.discount) AS avg_discount
FROM orders o
JOIN products p
ON o.product_id = p.product_id
WHERE o.discount >= 0.4
GROUP BY p.category;

SELECT 
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit
FROM orders;    
    
# know the business_status :

SELECT 
    CASE 
        WHEN SUM(profit) > 0 THEN 'Profitable'
        ELSE 'Not Profitable'
    END AS business_status
FROM orders;












