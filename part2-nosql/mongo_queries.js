// OP1: insertMany() — insert all 3 documents from sample_documents.json
db.products.insertMany([
  {
    "product_id": "E1001",
    "name": "Sony Wireless Headphones",
    "category": "Electronics",
    "price": 25000,
    "specs": { "voltage": "5V", "battery_life": "30 hours", "warranty": "2 years" },
    "tags": ["audio", "wireless", "noise-canceling"]
  },
  {
    "product_id": "C2001",
    "name": "Men's Cotton T-Shirt",
    "category": "Clothing",
    "price": 899,
    "attributes": { "size": "L", "color": "Navy Blue", "material": "100% Cotton" },
    "available_sizes": ["S", "M", "L", "XL"]
  },
  {
    "product_id": "G3001",
    "name": "Organic Almond Milk",
    "category": "Groceries",
    "price": 350,
    "expiry_date": "2024-11-15",
    "nutritional_info": { "calories": 45, "protein": "1g", "sugar": "0g" }
  }
]);

// OP2: find() — retrieve all Electronics products with price > 20000
db.products.find({ category: "Electronics", price: { $gt: 20000 } });

// OP3: find() — retrieve all Groceries expiring before 2025-01-01
db.products.find({ category: "Groceries", expiry_date: { $lt: "2025-01-01" } });

// OP4: updateOne() — add a "discount_percent" field to a specific product
db.products.updateOne(
  { product_id: "E1001" },
  { $set: { discount_percent: 10 } }
);

// OP5: createIndex() — create an index on category field and explain why
db.products.createIndex({ category: 1 });
/* Explanation: Since we frequently query the database by the 'category' field 
   (e.g., retrieving all Electronics or all Groceries), creating an index on 
   'category' drastically improves read performance. It allows MongoDB to quickly 
   locate the relevant documents without having to perform a full collection scan.
