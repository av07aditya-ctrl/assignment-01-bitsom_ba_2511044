-- 1. Create Customers Table
CREATE TABLE Customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    customer_email VARCHAR(100) NOT NULL,
    customer_city VARCHAR(50) NOT NULL
);

-- 2. Create Products Table
CREATE TABLE Products (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL
);

-- 3. Create Sales Representatives Table
CREATE TABLE Sales_Reps (
    sales_rep_id VARCHAR(10) PRIMARY KEY,
    sales_rep_name VARCHAR(100) NOT NULL,
    sales_rep_email VARCHAR(100) NOT NULL,
    office_address VARCHAR(255) NOT NULL
);

-- 4. Create Orders Table (This must be created last due to Foreign Keys)
CREATE TABLE Orders (
    order_id VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10) NOT NULL,
    product_id VARCHAR(10) NOT NULL,
    sales_rep_id VARCHAR(10) NOT NULL,
    quantity INT NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (sales_rep_id) REFERENCES Sales_Reps(sales_rep_id)
);

-- ==========================================
-- INSERT STATEMENTS (At least 5 rows per table)
-- ==========================================

INSERT INTO Customers (customer_id, customer_name, customer_email, customer_city) VALUES
('C001', 'Rohan Mehta', 'rohan@gmail.com', 'Mumbai'),
('C002', 'Priya Sharma', 'priya@gmail.com', 'Delhi'),
('C003', 'Amit Verma', 'amit@gmail.com', 'Bangalore'),
('C006', 'Neha Gupta', 'neha@gmail.com', 'Delhi'),
('C008', 'Kavya Rao', 'kavya@gmail.com', 'Hyderabad');

INSERT INTO Products (product_id, product_name, category, unit_price) VALUES
('P001', 'Laptop', 'Electronics', 55000.00),
('P002', 'Mouse', 'Electronics', 800.00),
('P004', 'Notebook', 'Stationery', 120.00),
('P005', 'Headphones', 'Electronics', 3200.00),
('P007', 'Pen Set', 'Stationery', 250.00);

-- Note: Only SR01, SR02, and SR03 existed in the raw data. SR04 and SR05 are added to fulfill the assignment requirement.
INSERT INTO Sales_Reps (sales_rep_id, sales_rep_name, sales_rep_email, office_address) VALUES
('SR01', 'Deepak Joshi', 'deepak@corp.com', 'Mumbai HQ, Nariman Point, Mumbai - 400021'),
('SR02', 'Anita Desai', 'anita@corp.com', 'Delhi Office, Connaught Place, New Delhi - 110001'),
('SR03', 'Ravi Kumar', 'ravi@corp.com', 'South Zone, MG Road, Bangalore - 560001'),
('SR04', 'Sanjay Patil', 'sanjay@corp.com', 'Pune Branch, MG Road, Pune - 411001'),
('SR05', 'Meera Reddy', 'meera@corp.com', 'Hyderabad Branch, Hi-Tech City, Hyderabad - 500081');

INSERT INTO Orders (order_id, customer_id, product_id, sales_rep_id, quantity, order_date) VALUES
('ORD1027', 'C002', 'P004', 'SR02', 4, '2023-11-02'),
('ORD1114', 'C001', 'P007', 'SR01', 2, '2023-08-06'),
('ORD1153', 'C006', 'P007', 'SR01', 3, '2023-02-14'),
('ORD1002', 'C002', 'P005', 'SR02', 1, '2023-01-17'),
('ORD1120', 'C008', 'P004', 'SR02', 3, '2023-05-07');