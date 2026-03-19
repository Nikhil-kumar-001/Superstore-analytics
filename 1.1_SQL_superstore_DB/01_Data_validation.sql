# Data validation check
/* 
    This stage answer can I really trust this data before analyzing it or not?
*/

# 1. Row count check in all tables 
# UNION ALL stacks results vertically(one below another)

-- Row counts in all tables

SELECT 'customers' AS table_exist, COUNT(*) AS row_count FROM customers
UNION ALL 
SELECT 'Products', COUNT(*) FROM products 
UNION ALL 
SELECT 'Orders', COUNT(*) FROM orders   
UNION ALL 
SELECT 'returns', COUNT(*)  FROM returns;

# 2. Primary key uniqueness check

# -- Duplicate customer IDs
SELECT 
    customer_id,
COUNT(*)
    AS times_appear
FROM customers
GROUP BY customer_id
HAVING times_appear >1;

# -- Duplicate Product IDs
SELECT
    product_id,
COUNT(*)    
    AS times_appear
FROM
    products
GROUP BY product_id
HAVING times_appear > 1;

#-- Duplicate order item IDs
SELECT order_item_id,
COUNT(*) 
    AS times_appear
FROM 
    orders
GROUP BY order_item_id
HAVING times_appear >1;


# 3. NULL Checks on critical columns;
# I checked NULLs in columns that are essential for relationships, time analysis, and core business metrics.”

SELECT COUNT(*) FROM orders WHERE customer_id IS NULL;
SELECT COUNT(*) FROM orders WHERE product_id IS NULL;
SELECT COUNT(*) FROM orders WHERE order_date IS NULL;
SELECT COUNT(*) FROM orders WHERE sales IS NULL;
SELECT COUNT(*) FROM orders WHERE profit IS NULL;

# 4. Orphan record check (FK logic)
# An orphan record is a row that point to something that does not exist

# -- Orders with missing customers

SELECT COUNT(*) AS orphan_customers
FROM orders o 
LEFT JOIN customers c 
ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

# --  Order with missing products

SELECT COUNT(*) AS orphan_record_products
FROM orders o 
LEFT JOIN products p 
ON o.product_id = p.product_id
WHERE p.product_id IS NULL;

# 5. Data sanity checks
# Data sanity = checking whether data makes logical sense in real life
# -- Orders with ship data before order date 

SELECT COUNT(*) AS invalid_ship_dates
FROM orders
WHERE ship_date < order_date;


# 6. Numeric sanity checks
#-- Negative or zero sales

SELECT COUNT(*) AS invalid_sales
FROM orders
WHERE sales <= 0;

# -- Extreme Discounts

SELECT 
    MIN(discount) AS min_discount,
    MAX(discount) AS max_discount
FROM orders;


# 7. Returns coverage check
# -- How many orders are returned

SELECT 
    Returned,
    COUNT(*) AS return_count
FROM returns
GROUP BY Returned;

#-- Return orders that do not exist in orders table 

SELECT COUNT(*) AS invalid_returns
FROM returns r  
LEFT JOIN orders o  
    ON r.`Order ID` = o.order_id  
WHERE o.order_id IS NULL;


/*
  “Before analysis, I validated data integrity — 
  checking duplicates, nulls, orphan records, date inconsistencies,
  and numeric sanity.”
*/










