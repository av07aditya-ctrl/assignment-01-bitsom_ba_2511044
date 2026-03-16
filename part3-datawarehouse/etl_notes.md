## ETL Decisions

### Decision 1 — Standardizing Inconsistent Date Formats
Problem: The raw `retail_transactions.csv` contained highly inconsistent date strings mixing multiple formats (e.g., '29/08/2023', '12-12-2023', '2023-02-05'). This makes chronological sorting and grouping by month impossible for SQL analysis.
Resolution: During the ETL process, I parsed all date strings into a standardized ISO 8601 format (`YYYY-MM-DD`) before inserting them into `dim_date` and `fact_sales`. I also decomposed the dates into separate Year, Month, and Day integer columns in the dimension table to simplify future BI reporting.

### Decision 2 — Cleaning Inconsistent Category Casing and Naming
Problem: The product categories were entered with inconsistent casing and naming variations (e.g., 'electronics' vs 'Electronics', and 'Grocery' vs 'Groceries'). In SQL, a `GROUP BY` statement treats these as entirely separate entities, which breaks category-level revenue calculations.
Resolution: I applied a string transformation function to enforce Title Case across all records. Furthermore, I merged naming variations (mapping 'Grocery' to 'Groceries') so that all items logically group under standardized strings before being loaded into `dim_product`.

### Decision 3 — Handling Missing (NULL) Store Cities
Problem: Upon inspecting the raw data, 19 rows were missing their `store_city` value. If left untreated, this could cause issues with geographic reporting or unexpected drops in inner join queries if a separate city dimension was required.
Resolution: Rather than dropping the rows and losing valuable sales revenue data in the fact table, I implemented a data imputation strategy. I used a `COALESCE()` style logic to fill any missing city values with 'Unknown' to ensure the dimension table remained robust and complete.