## Storage Systems

To meet the four specific goals of the hospital network, I have selected a highly specialized polyglot persistence architecture, assigning the most optimal database technology to each distinct workload:

1. **Predicting Patient Readmission (Data Lake):** Machine learning models require massive volumes of historical, potentially unstructured data to train accurately. I chose a Data Lake (like Amazon S3 or Hadoop) for this goal. It provides cheap, highly scalable storage for decades of historical treatment records, lab results, and discharge summaries without requiring rigid schemas upfront.
2. **Plain English Queries (Vector Database):** To allow doctors to ask questions like "Has this patient had a cardiac event before?", traditional SQL keyword searches will fail. I selected a Vector Database (like Pinecone or Milvus). Patient histories and clinical notes are converted into high-dimensional AI embeddings. When a doctor asks a question, the system performs a semantic similarity search to retrieve the exact clinical context, powering a Large Language Model (LLM) to generate an accurate response.
3. **Monthly Management Reports (Data Warehouse):** Hospital administrators need structured, highly accurate aggregations of bed occupancy and department costs. I chose a Data Warehouse (like Snowflake or BigQuery) using a Star Schema. This allows Business Intelligence tools to run complex analytical queries (`GROUP BY` months, departments) rapidly and reliably. 
4. **Real-time ICU Vitals (Time-Series Database):** ICU monitors stream thousands of data points (heart rate, oxygen) per second. Relational databases cannot handle this write-velocity. I selected a specialized Time-Series Database (like InfluxDB or TimescaleDB). These are uniquely engineered to ingest high-frequency, time-stamped streaming data and provide instant alerts for critical condition changes.

## OLTP vs OLAP Boundary

The boundary between the transactional (OLTP) and analytical (OLAP) systems is strictly defined by our data ingestion layer to protect hospital operations. 

The OLTP systems include the live Electronic Health Records (EHR) database where doctors actively type notes, and the live ICU edge monitors. These systems prioritize high availability and fast writes. 
The boundary occurs at the ETL (Extract, Transform, Load) pipelines and Apache Kafka event streams. These tools pull a copy of the data *away* from the live hospital systems and load it into the Data Warehouse, Data Lake, and Vector DB. Everything downstream of this ingestion layer is OLAP. This strict boundary ensures that heavy AI training jobs or massive monthly report queries will never consume the CPU resources of the live databases keeping patients alive.

## Trade-offs

One significant trade-off in this design is the high infrastructure and cloud compute cost associated with streaming and storing real-time ICU vitals indefinitely. Capturing heartbeat data every millisecond for every patient generates petabytes of data quickly, much of which becomes "noise" after the patient recovers.

**Mitigation:** To mitigate this cost, I would implement a data downsampling and lifecycle management policy. The Time-Series Database would store the ultra-high-resolution millisecond data for only 7 days to assist with immediate patient care. After 7 days, an automated script would aggregate the vitals into 5-minute averages (downsampling) before archiving it to the cheap Data Lake for long-term storage and future AI research. This drastically reduces storage costs while preserving the analytical value of the data.