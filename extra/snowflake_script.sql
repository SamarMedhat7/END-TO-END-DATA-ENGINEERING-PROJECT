CREATE OR REPLACE WAREHOUSE finance_wh
  WITH
  WAREHOUSE_SIZE = 'XSMALL'
  AUTO_SUSPEND = 60  
  AUTO_RESUME = TRUE
  INITIALLY_SUSPENDED = TRUE;

  -- Create a database to store data
CREATE OR REPLACE DATABASE finance_db;


-- Create a schema for organization inside the database
CREATE OR REPLACE SCHEMA raw;

--Create tables
CREATE OR REPLACE TABLE raw.customers (
id int PRIMARY KEY,
name varchar,
email varchar,
country varchar
);


CREATE OR REPLACE TABLE raw.orders(
id int PRIMARY KEY,
customer_id int,
order_date date,
tatal_amount int,
status varchar
);
CREATE OR REPLACE TABLE raw.order_items(
id int,
order_id int,
product_id int,
quantity int,
unit_price int
);
CREATE OR REPLACE TABLE raw.products(
id int PRIMARY KEY,
name varchar,
category varchar,
price int
);

-- Load data into tables

-- You can use the Snowflake UI or SnowSQL to load data from local files or cloud storage (like AWS S3) into these tables.


SELECT CURRENT_REGION(),CURRENT_ACCOUNT();
SELECT CURRENT_USER;

CREATE USER dbt_user PASSWORD = 'dbt_password'
LOGIN_NAME = 'dbt_user'
DEFAULT_ROLE = ACCOUNTADMIN
MUST_CHANGE_PASSWORD = FALSE;
GRANT ROLE ACCOUNTADMIN TO USER dbt_user;
GRANT USAGE ON DATABASE finance_db TO ROLE ACCOUNTADMIN;
GRANT USAGE ON SCHEMA finance_db.raw TO ROLE ACCOUNTADMIN;
GRANT USAGE ON WAREHOUSE finance_wh TO ROLE ACCOUNTADMIN;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA finance_db.raw TO ROLE ACCOUNTADMIN;

drop view stg_customers;
drop view stg_order_items;
drop view stg_orders;
drop view stg_products;