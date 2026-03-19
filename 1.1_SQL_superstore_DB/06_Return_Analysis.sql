USE superstore_db;

# Return Analysis

#-- How many orders are returned or kept?

-- SELECT 
--     returned,
--     COUNT(DISTINCT `Order ID`) AS order_count
-- FROM returns
-- GROUP BY returned;

SELECT 
    CASE 
        WHEN r.returned IS NULL THEN 'No'
        ELSE 'Yes'
    END AS returned_status,
    COUNT(DISTINCT o.order_id) AS order_count
FROM orders o
LEFT JOIN returns r
ON o.order_id = r.`Order ID`
GROUP BY returned_status;

-- WE have 1172 as unique return count
-- If the order is not found in the returns table, Then it was not returned Else it was returned

# Sales and profit by Return Status:

SELECT 
    CASE
        WHEN r.`Order ID` IS NULL THEN 'Not Returned'
        ELSE 'Returned'
    END AS returned_status,
    ROUND(SUM(o.sales), 2) AS total_sales,
    ROUND(SUM(o.profit), 2) AS total_profit
FROM orders o  
LEFT JOIN returns r  
ON o.order_id = r. `Order ID`
GROUP BY returned_status;

/* 

returns are marked as a flag only.
The financial impact of returns is not fully adjusted in the dataset.

*/

# Return rate percentage :- 

-- Return rate
SELECT
    ROUND(
        COUNT(DISTINCT r.`Order ID`) /
        COUNT(DISTINCT o.order_id)*100,
        2
    ) AS return_rate_pct
FROM orders o
LEFT JOIN returns r
ON o.order_id = r.`Order ID`;

/* 

“About 4.7% of orders are returned.
I calculated it as returned orders divided by total orders using a LEFT JOIN.”

Return rate = Returned orders ÷ Total orders

*/

# Returns by product category :- 

-- Returns by category
SELECT
    p.category,
    COUNT(DISTINCT r.`Order ID`) AS returned_orders
FROM returns r
JOIN orders o
ON r.`Order ID` = o.order_id
JOIN products p
ON o.product_id = p.product_id
WHERE r.returned = 'Yes'
GROUP BY p.category
ORDER BY returned_orders DESC;

# Return by Region :-

SELECT 
    o.region,
    COUNT(DISTINCT r.`Order ID`) AS returned_orders
FROM returns r  
JOIN orders o 
ON r.`Order ID` = o.order_id 
WHERE r.returned = 'Yes'
GROUP BY o.Region
ORDER BY returned_orders DESC;


# Profit and Sales impact of returned orders

SELECT 
    ROUND(SUM(o.profit), 2) AS profit_lost_due_to_returns,
    ROUND(SUM(o.sales), 2) AS sales_lost_due_to_returns
FROM orders o 
JOIN returns r  
ON o.order_id = r.`Order ID`
WHERE r.returned = 'Yes';

# Categories with high return rate :- 

SELECT 
    p.category,
    COUNT(DISTINCT r.`Order ID`) AS returned_orders,
    COUNT(DISTINCT o.order_id)   AS total_orders,
    ROUND(
        COUNT(DISTINCT r.`Order ID`) * 100.00/
        COUNT(DISTINCT o.order_id),
        2
    ) AS return_rate_perct
FROM orders o
LEFT JOIN returns r  
ON o.order_id = r.`Order ID` AND r.returned = 'Yes'
JOIN products p 
ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY return_rate_perct DESC;
    
/* 

“I analyzed return patterns using SQL and quantified their impact on profitability,
identifying categories and regions with higher return rates and margin loss.”

*/







