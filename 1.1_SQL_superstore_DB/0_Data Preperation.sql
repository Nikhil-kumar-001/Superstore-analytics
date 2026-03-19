USE superstore_db;

SHOW tables;

RENAME TABLE orders TO orders_raw;

SHOW TABLES;

SELECT * FROM orders_raw;

DROP TABLE customers;

CREATE TABLE customers AS
SELECT
    `Customer ID` AS customer_id,
    `Customer Name` AS customer_name,
     Segment
FROM orders_raw
GROUP BY 
    `Customer ID`,
    `Customer Name`,
    Segment;
    
ALTER TABLE customers
ADD PRIMARY KEY (customer_id);

DESC customers;

SELECT COUNT(*) AS customer_count FROM customers;  

SELECT COUNT(DISTINCT customer_id)
AS distinct_cust_count
FROM customers ;


CREATE TABLE products AS 
SELECT DISTINCT
    `Product ID` AS product_id,
    `Product Name` AS product_name,
    `Sub-Category` AS sub_category,
    Category
FROM
    orders_raw;

DROP table products;   

CREATE TABLE products AS
SELECT
    `Product ID` AS product_id,
    MIN(`Product Name`) AS product_name,
    MIN(Category) AS category,
    MIN(`Sub-Category`) AS sub_category
FROM orders_raw
GROUP BY `Product ID`;

SELECT COUNT(DISTINCT(product_id)) FROM products;
SELECT COUNT(*) AS product_count FROM products;    

ALTER TABLE products
ADD PRIMARY KEY (product_id);

    
# --- Creating ORDERS table:


     
     
DROP TABLE orders;
SHOW TABLES;

CREATE TABLE orders AS
SELECT
    `Order ID`    AS order_id,
    `Order Date`  AS order_date,
    `Ship Date`   AS ship_date,
    `Ship Mode`   AS ship_mode,
    `Customer ID` AS customer_id,
    `Product ID`  AS product_id,
    Country,
    State,
    City,
    Region,
    `Postal Code` AS postal_code,
    Sales,
    Quantity,
    Discount,
    Profit
FROM orders_raw;


# as one order has many products we need to make composite primary key instead of normal primary key
# As we try composite primary key but we came to know that there is also a duplicate entry for combined order_id and product_id)

ALTER TABLE orders
ADD COLUMN order_item_id INT AUTO_INCREMENT PRIMARY KEY;

DESC orders;

SELECT order_date 
FROM orders
LIMIT 5;


SHOW TABLES;

SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM products;
SELECT * FROM returns;

show    TABLES;

SELECT customer_id, COUNT(*)
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

SELECT product_id, COUNT(*)
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;

SELECT order_id, COUNT(*)
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;


#-- Adding primary keys to the table 

ALTER TABLE customers
ADD PRIMARY KEY (customer_id);

ALTER TABLE orders
	ADD `Shipping Cost` DECIMAL(10,2);

UPDATE orders o
JOIN orders_raw r
ON o.order_item_id = r.order_item_id
SET o.`Shipping Cost` = r.`Shipping Cost`;

ALTER TABLE orders
RENAME COLUMN `Shipping Cost` TO shipping_cost;



SELECT shipping_cost FROM orders;



DESC orders;






ALTER TABLE returns
ADD PRIMARY KEY(`Order ID

DESC customers;

SELECT COUNT(*) FROM customers;

SELECT COUNT(DISTINCT customer_id) AS customer_id_count
FROM customers;


DESC customers;
DESC orders;
DESC products;
DESC returns;


#-- Add foreign keys to all the tables:-

ALTER TABLE orders
ADD CONSTRAINT fk_orders_customers
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);

ALTER TABLE orders
ADD CONSTRAINT fk_orders_products
FOREIGN KEY (product_id)
REFERENCES products(product_id);

DESC orders;






