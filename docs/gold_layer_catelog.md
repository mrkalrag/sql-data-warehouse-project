# Data Catalog for Gold Layer

## Overview

The Gold Layer is the business-level data representation, structured to support analytical and reporting use cases. It consists of **dimension tables** and **fact tables** for specific business metrics.
These tables are built from Silver layer data after cleaning, integration, and validation.

---

### 1. **gold.dim_customers**

* **Purpose:** Stores customer details enriched with demographic and geographic data.

| Column Name     | Data Type    | Description                                                                           |
| --------------- | ------------ | ------------------------------------------------------------------------------------- |
| customer_key    | INT          | Surrogate key uniquely identifying each customer record in the dimension table.       |
| customer_id     | INT          | Unique numerical identifier assigned to each customer.                                |
| customer_number | NVARCHAR(50) | Alphanumeric identifier representing the customer, used for tracking and referencing. |
| first_name      | NVARCHAR(50) | The customer's first name, as recorded in the system.                                 |
| last_name       | NVARCHAR(50) | The customer's last name or family name.                                              |
| country         | NVARCHAR(50) | The country of residence for the customer.                                            |
| marital_status  | NVARCHAR(50) | The marital status of the customer.                                                   |
| gender          | NVARCHAR(50) | The gender of the customer (CRM prioritized; ERP used as fallback).                   |
| birthdate       | DATE         | The date of birth of the customer, formatted as YYYY-MM-DD.                           |
| create_date     | DATE         | The date when the customer record was created in the system.                          |

---

### 2. **gold.dim_products**

* **Purpose:** Provides information about the products and their attributes.

| Column Name          | Data Type    | Description                                                                            |
| -------------------- | ------------ | -------------------------------------------------------------------------------------- |
| product_key          | INT          | Surrogate key uniquely identifying each product record in the product dimension table. |
| product_id           | INT          | A unique identifier assigned to the product for internal tracking and referencing.     |
| product_number       | NVARCHAR(50) | Alphanumeric code representing the product, used for categorization and inventory.     |
| product_name         | NVARCHAR(50) | Descriptive name of the product, including type, color, or size.                       |
| category_id          | NVARCHAR(50) | Unique identifier for the product’s category.                                          |
| category             | NVARCHAR(50) | The broader classification of the product (e.g., Bikes, Components).                   |
| subcategory          | NVARCHAR(50) | Detailed classification of the product within its category.                            |
| maintenance_required | NVARCHAR(50) | Indicates whether the product requires maintenance (Yes/No).                           |
| cost                 | INT          | The cost or base price of the product.                                                 |
| product_line         | NVARCHAR(50) | The specific product line or series (e.g., Road, Mountain).                            |
| start_date           | DATE         | Date when the product became available for sale or use.                                |

---

### 3. **gold.fact_sales**

* **Purpose:** Stores transactional sales data for analytical purposes.

| Column Name   | Data Type    | Description                                                      |
| ------------- | ------------ | ---------------------------------------------------------------- |
| order_number  | NVARCHAR(50) | A unique alphanumeric identifier for each sales order.           |
| product_key   | INT          | Surrogate key linking the order to the product dimension table.  |
| customer_key  | INT          | Surrogate key linking the order to the customer dimension table. |
| order_date    | DATE         | The date when the order was placed.                              |
| shipping_date | DATE         | The date when the order was shipped to the customer.             |
| due_date      | DATE         | The date when the order payment was due.                         |
| sales_amount  | INT          | Total monetary value of the sale for the line item.              |
| quantity      | INT          | Number of units of the product ordered for the line item.        |
| price         | INT          | Price per unit of the product for the line item.                 |


