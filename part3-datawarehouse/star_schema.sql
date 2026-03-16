-- 1. Create Dimension: Store
CREATE TABLE dim_store (
    store_name VARCHAR(100) PRIMARY KEY,
    store_city VARCHAR(100)
);

-- 2. Create Dimension: Product
CREATE TABLE dim_product (
    product_name VARCHAR(100) PRIMARY KEY,
    category VARCHAR(50)
);

-- 3. Create Dimension: Date
CREATE TABLE dim_date (
    date_id DATE PRIMARY KEY,
    year INT,
    month INT,
    day INT
);

-- 4. Create Fact: Sales (The center of the star)
CREATE TABLE fact_sales (
    transaction_id VARCHAR(20) PRIMARY KEY,
    date_id DATE,
    store_name VARCHAR(100),
    product_name VARCHAR(100),
    units_sold INT,
    total_revenue DECIMAL(12, 2),
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (store_name) REFERENCES dim_store(store_name),
    FOREIGN KEY (product_name) REFERENCES dim_product(product_name)
);

-- ==========================================
-- INSERT STATEMENTS (Cleaned Real Data)
-- ==========================================

-- Note: Store cities that were NULL in raw data are handled.
INSERT INTO dim_store (store_name, store_city) VALUES
('Chennai Anna', 'Chennai'),
('Delhi South', 'Delhi'),
('Bangalore MG', 'Bangalore'),
('Pune FC Road', 'Pune');

-- Note: Categories standardized to Title Case ('electronics' -> 'Electronics', 'Grocery' -> 'Groceries')
INSERT INTO dim_product (product_name, category) VALUES
('Speaker', 'Electronics'),
('Tablet', 'Electronics'),
('Phone', 'Electronics'),
('Smartwatch', 'Electronics'),
('Atta 10kg', 'Groceries'),
('Jeans', 'Clothing'),
('Biscuits', 'Groceries');

-- Note: All dates strictly standardized from DD/MM/YYYY or DD-MM-YYYY to standard YYYY-MM-DD
INSERT INTO dim_date (date_id, year, month, day) VALUES
('2023-08-29', 2023, 8, 29),
('2023-12-12', 2023, 12, 12),
('2023-02-05', 2023, 2, 5),
('2023-02-20', 2023, 2, 20),
('2023-01-15', 2023, 1, 15),
('2023-08-09', 2023, 8, 9),
('2023-03-31', 2023, 3, 31),
('2023-10-26', 2023, 10, 26),
('2023-12-08', 2023, 12, 8),
('2023-08-15', 2023, 8, 15);

-- Note: 10 Fact rows linking back to the dimensions. Total revenue is strictly calculated.
INSERT INTO fact_sales (transaction_id, date_id, store_name, product_name, units_sold, total_revenue) VALUES
('TXN5000', '2023-08-29', 'Chennai Anna', 'Speaker', 3, 147788.34),
('TXN5001', '2023-12-12', 'Chennai Anna', 'Tablet', 11, 255487.32),
('TXN5002', '2023-02-05', 'Chennai Anna', 'Phone', 20, 974067.80),
('TXN5003', '2023-02-20', 'Delhi South', 'Tablet', 14, 325165.68),
('TXN5004', '2023-01-15', 'Chennai Anna', 'Smartwatch', 10, 588510.10),
('TXN5005', '2023-08-09', 'Bangalore MG', 'Atta 10kg', 12, 629568.00),
('TXN5006', '2023-03-31', 'Pune FC Road', 'Smartwatch', 6, 353106.06),
('TXN5007', '2023-10-26', 'Pune FC Road', 'Jeans', 16, 37079.52),
('TXN5008', '2023-12-08', 'Bangalore MG', 'Biscuits', 9, 247229.91),
('TXN5009', '2023-08-15', 'Bangalore MG', 'Smartwatch', 3, 176553.03);