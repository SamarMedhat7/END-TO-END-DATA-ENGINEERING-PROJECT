# End-to-End Data Pipeline with Snowflake, dbt, and Airflow

This project demonstrates how to build and orchestrate a complete data pipeline using:
- **Snowflake** as the data warehouse  
- **dbt (Data Build Tool)** for modeling and transformations  
- **Apache Airflow** for orchestration  

---

## Project Overview

1. **Data Source**  
   Raw data is loaded into Snowflake.  

2. **Transformation with dbt**  
   - Staging  (`stg_orders`, `stg_order_items`, `stg_customers`, `stg_products` )  
   - Marts (`fact_daily_order_revenue`)  

3. **Orchestration with Airflow**  
   Airflow DAG runs dbt commands to ensure data freshness and quality.  

---

## Repository Structure

