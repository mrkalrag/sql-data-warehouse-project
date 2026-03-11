Data Catalog
Overview

This document describes the Gold Layer tables used for analytics and reporting in the data warehouse.
The Gold layer contains business-ready data models built from cleaned and transformed data in the Silver layer.

The tables in this layer follow a star schema design:

Dimension tables store descriptive information (customers and products).

Fact tables store measurable business events (sales transactions).

These tables are used by analysts, reporting tools, and dashboards to analyze sales performance.

Tables Included
Table Name	Type	Description
gold.dim_customers	Dimension	Stores customer demographic and profile information.
gold.dim_products	Dimension	Stores product details including category and cost.
gold.fact_sales	Fact	Stores sales transactions linking customers and products.
1. Table: gold.dim_customers

Description:
Stores customer demographic and profile information used for analysis and reporting.

Column Name	Data Type	Description
customer_key	INT	Internal unique identifier generated in the data warehouse for each customer. Used to connect customers with sales records.
customer_id	INT	Original customer ID from the CRM source system.
customer_number	NVARCHAR(50)	Customer reference number used in the source systems.
first_name	NVARCHAR(50)	First name of the customer.
last_name	NVARCHAR(50)	Last name of the customer.
country	NVARCHAR(50)	Country where the customer is located.
gender	NVARCHAR(10)	Gender of the customer. CRM data is prioritized and ERP data is used when CRM information is unavailable.
marital_status	NVARCHAR(20)	Marital status of the customer recorded in the CRM system.
birthdate	DATE	Date of birth of the customer.
create_date	DATE	Date when the customer record was first created in the system.
2. Table: gold.dim_products

Description:
Contains product information including product category, classification, and cost. Only active products are included.

Column Name	Data Type	Description
product_key	INT	Internal warehouse identifier generated for each product. Used for joining with the sales fact table.
product_id	INT	Product identifier from the source system.
product_number	NVARCHAR(50)	Unique product code used in the operational systems.
product_name	NVARCHAR(50)	Name of the product.
category_id	NVARCHAR(50)	Identifier of the product category.
category	NVARCHAR(50)	Main product category name.
subcategory	NVARCHAR(50)	More detailed classification of the product within the category.
maintenance	NVARCHAR(50)	Indicates whether the product requires maintenance or service.
product_cost	INT	Cost of producing or purchasing the product.
product_line	NVARCHAR(50)	Classification of the product line.
start_date	DATE	Date when the product became available for sale.
3. Table: gold.fact_sales

Description:
Stores sales transaction data. Each record represents a product purchased by a customer.

Column Name	Data Type	Description
order_number	NVARCHAR(50)	Unique identifier assigned to each sales order.
product_key	INT	Product identifier referencing the product dimension table.
customer_key	INT	Customer identifier referencing the customer dimension table.
order_date	DATE	Date when the order was placed.
shipping_date	DATE	Date when the order was shipped to the customer.
due_date	DATE	Expected delivery date for the order.
sales_amount	INT	Total monetary value of the sales transaction.
quantity	INT	Number of product units included in the order.
price	INT	Price per unit of the product.
