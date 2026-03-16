-- Q1: List all customers along with the total number of orders they have placed
SELECT 
    c.name AS customer_name, 
    COUNT(o.order_id) AS total_orders
FROM read_csv_auto('datasets/customers.csv') c
LEFT JOIN read_json_auto('datasets/orders.json') o ON c.customer_id = o.customer_id
GROUP BY c.name;

-- Q2: Find the top 3 customers by total order value
-- (Using the total_amount column natively found inside orders.json)
SELECT 
    c.name AS customer_name, 
    SUM(o.total_amount) AS total_order_value
FROM read_csv_auto('datasets/customers.csv') c
JOIN read_json_auto('datasets/orders.json') o ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY total_order_value DESC
LIMIT 3;

-- Q3: List all products purchased by customers from Bangalore
SELECT DISTINCT 
    p.product_name
FROM read_parquet('datasets/products.parquet') p
JOIN read_json_auto('datasets/orders.json') o ON p.order_id = o.order_id
JOIN read_csv_auto('datasets/customers.csv') c ON o.customer_id = c.customer_id
WHERE c.city = 'Bangalore';

-- Q4: Join all three files to show: customer name, order date, product name, and quantity
SELECT 
    c.name AS customer_name, 
    o.order_date, 
    p.product_name, 
    p.quantity
FROM read_json_auto('datasets/orders.json') o
JOIN read_csv_auto('datasets/customers.csv') c ON o.customer_id = c.customer_id
JOIN read_parquet('datasets/products.parquet') p ON o.order_id = p.order_id;