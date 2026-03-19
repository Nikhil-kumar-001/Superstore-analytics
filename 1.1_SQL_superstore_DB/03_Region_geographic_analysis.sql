USE superstore_db;
# Regional and Geographic Analysis (SQL)

# -- Which regions, states. and cities are driving perfomance -- and which are hurting it? 

## --  Sales & profit by region 

SELECT
    region, 
    ROUND(SUM(sales), 2)  AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY region 
ORDER BY total_sales DESC;

## -- Region-wise profit margin 

SELECT 
    region,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM orders 
GROUP BY region;

##-- State-level perfomance by sales

SELECT
    state,
    ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY State
ORDER BY total_sales DESC
LIMIT 10;

##-- State with consistent losses or with negative total profit

SELECT 
    state,
    ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY state 
HAVING total_profit < 0
ORDER BY total_profit DESC
LIMIT 10;

##-- Average discount by region

SELECT 
    Region,
    ROUND(AVG(Discount), 2) AS avg_discount
FROM
    orders
GROUP BY Region 
ORDER BY avg_discount DESC;

##-- Region wise order volume

SELECT 
    region,
    COUNT(*) AS order_volume
FROM orders
GROUP BY region 
ORDER BY order_volume DESC;

## -- Top cities by sales

SELECT 
    city,
    ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY City
ORDER BY total_sales DESC
LIMIT 10;


# Cities with high sales but negative profit

SELECT 
    city,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY City
HAVING total_sales > 5000
    AND total_profit < 0
ORDER BY total_sales DESC
LIMIT 10;
    
# Category sales perfomance by Region 

SELECT 
    region,
    category, 
    ROUND(SUM(sales), 2) AS total_sales
FROM orders o  
JOIN products p 
ON o.product_id = p.product_id
GROUP BY region, category 
ORDER BY region, total_sales DESC;

/*

 “I performed regional, state,
  and city-level sales and profitability analysis to identify high-performing and loss-making geographies,
  and linked discounting behavior to margin issues.”
  
 */















