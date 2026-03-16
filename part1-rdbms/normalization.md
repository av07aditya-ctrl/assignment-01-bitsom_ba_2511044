## Anomaly Analysis

### 1. Insert Anomaly
An insert anomaly occurs when we cannot add a new piece of data without needing another piece of data. 
* **Example:** If the company starts selling a new product (e.g., `P009`, 'Keyboard'), we cannot insert it into the database until a customer actually places an order for it. This is because the primary identifier for a row is `order_id`, and a standalone product doesn't have an order yet.

### 2. Update Anomaly
An update anomaly happens when updating a single piece of information requires changing multiple rows. If we miss even one row, the data becomes inconsistent.
* **Example:** Customer `C002` (Priya Sharma) has placed multiple orders (e.g., `ORD1027`, `ORD1002`, `ORD1037`). If Priya changes her `customer_city` or `customer_email`, we have to update every single one of those order rows. If we only update `ORD1027` but forget `ORD1002`, the database will show two different cities for the exact same customer.

### 3. Delete Anomaly
A delete anomaly occurs when deleting one piece of data accidentally wipes out completely separate, unrelated information.
* **Example:** According to the dataset, the product `P008` (Webcam) has only been ordered exactly once, in row `ORD1185` by customer `C003`. If this customer cancels their order and we delete row `ORD1185`, we accidentally delete all our knowledge of the Webcam product (its `unit_price`, `category`, and `product_name`) from the entire database.

## Normalization Justification

While keeping all data in a single table like `orders_flat.csv` might seem simpler for running basic queries without `JOIN` statements, I strongly refute the manager's position that normalization is "over-engineering." A single flat table is structurally fragile and will inevitably lead to severe data integrity issues as the business scales. 

We can see this directly in our dataset. For example, if Priya Sharma (Customer C002) moves to a new city, we must perfectly update all five of her distinct order rows (ORD1027, ORD1002, ORD1037, etc.). If a junior analyst misses even one row, our database will report that Priya lives in two different cities simultaneously, destroying our data reliability. Furthermore, keeping data flat risks permanent data loss. Our dataset shows the 'Webcam' (P008) has only been ordered once (ORD1185). If that customer cancels and we delete the order row, we unintentionally erase the Webcam's product details, pricing, and category from our system entirely. 

Normalization resolves this by creating single sources of truth. By splitting the flat file into Third Normal Form (3NF) across `Customers`, `Products`, `Sales_Reps`, and `Orders` tables, we ensure that a customer's address or a product's price only exists in one single place. This guarantees that updates, insertions, and deletions happen cleanly without creating orphaned data or contradictory records, making it a critical requirement, not an over-engineered luxury.