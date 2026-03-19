USE superstore_db;

# shipping and operation analysis :-

-- Shipping time in days for each order 

SELECT 
    order_id,
    DATEDIFF(ship_date, order_date) AS shipping_days
FROM orders;

-- Average shipping time over all

SELECT 
    ROUND(AVG(DATEDIFF(ship_date, order_date)), 2) AS avg_shipping_days
FROM orders;

-- MAX and MIN shipping dates

SELECT 
    ROUND(MAX(DATEDIFF(ship_date, order_date)), 2) AS max_shipping_days,
    ROUND(MIN(DATEDIFF(ship_date, order_date)), 2) AS min_shipping_days
FROM orders;

# Shipping Method VS shipping cost

SELECT 
    ship_mode,
    ROUND(AVG(`shipping_Cost`),2) AS avg_shipping_cost
FROM orders
GROUP BY ship_mode
ORDER BY avg_shipping_cost DESC;


-- Shipping mode vs Sales and profit

SELECT 
    ship_mode,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY ship_mode
ORDER BY total_sales DESC;


-- lATE shipment analysis :- 

-- How many orders took more than 5 days to ship?

SELECT 
    COUNT(*) AS late_shipments
FROM orders
WHERE DATEDIFF(ship_date, order_date) > 5;

-- Profit impact of late shipments
SELECT 
    CASE
        WHEN DATEDIFF(ship_date, order_date) > 5 THEN 'Late'
        ELSE 'On-Time'
    END AS shipment_status,
    ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY shipment_status;

-- Late shipment by region 

SELECT 
    region, 
    COUNT(*) AS late_shipments
FROM orders
WHERE DATEDIFF(ship_date, order_date) > 5
GROUP BY region 
ORDER BY late_shipments DESC;

-- Shipping efficiency summary 

SELECT 
    ship_mode,
    COUNT(*) AS total_orders,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(AVG(DATEDIFF(ship_date, order_date)), 2) AS avg_shipping_days
FROM orders
GROUP BY ship_mode;

# Shipping cost vs profit (are higher shipping costs hurting profit?)

SELECT
    ship_mode,
    ROUND(AVG(shipping_cost),2) AS avg_shipping_cost,
    ROUND(AVG(profit),2) AS avg_profit
FROM orders
GROUP BY ship_mode;

# Shipping cost by Region

SELECT 
	region,
    ROUND(AVG(shipping_cost),2) AS avg_shipping_cost
FROM orders
GROUP BY region
ORDER BY avg_shipping_cost DESC;

# Shipping cost vs order value

SELECT
    ROUND(AVG(sales),2) AS avg_sales,
    ROUND(AVG(shipping_cost),2) AS avg_shipping_cost
FROM orders;


/* 

“I analyzed shipping performance and operational efficiency using SQL,
measuring delivery times, late shipments,
and their impact on profitability across regions and shipping modes.”

*/











