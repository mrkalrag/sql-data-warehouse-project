# SQL Data Warehouse Project

## Project Overview

This project involves building a modern data warehouse using **SQL Server**, leveraging **Medallion Architecture** (Bronze, Silver, Gold layers) to manage ETL pipelines, data modeling, and analytics.
The repository is a resource for professionals and students aiming to showcase skills in **SQL development, data engineering, and analytics**.

### Key Components

* **Data Architecture:** Design a Modern Data Warehouse with Bronze, Silver, and Gold layers.
* **ETL Pipelines:** Extract, transform, and load data from source systems (ERP and CRM) into the warehouse.
* **Data Modeling:** Create fact and dimension tables optimized for analytical queries.
* **Analytics & Reporting:** Build SQL-based reports and dashboards for actionable insights.

### Skills Highlighted

* SQL Development
* Data Architecture
* ETL Pipeline Design
* Data Modeling
* Data Analytics

---

## Project Requirements

### 1. Building the Data Warehouse (Data Engineering)

**Objective:**
Develop a modern data warehouse using SQL Server to consolidate sales data and enable analytical reporting.

**Specifications:**

* **Data Sources:** Import data from ERP and CRM systems provided as CSV files.
* **Data Quality:** Cleanse and resolve any data quality issues prior to analysis.
* **Integration:** Combine both sources into a single, user-friendly data model designed for analytical queries.
* **Scope:** Focus on the latest dataset only; historization is not required.
* **Documentation:** Provide clear documentation of the data model to support both business stakeholders and analytics teams.

---

### 2. BI: Analytics & Reporting (Data Analysis)

**Objective:**
Develop SQL-based analytics to deliver insights into:

* Customer Behavior
* Product Performance
* Sales Trends

These insights provide stakeholders with **key business metrics** for strategic decision-making.

---

### 3. Data Catalog (High-Level Example)

**Bronze Layer:** Raw data imported directly from CSV files (ERP & CRM).
**Silver Layer:** Cleaned and transformed data, resolving data type mismatches and inconsistencies.
**Gold Layer:** Analytical-ready tables including **dimension** and **fact tables** optimized for reporting.

| Layer  | Table / View      | Purpose                                                                                 |
| ------ | ----------------- | --------------------------------------------------------------------------------------- |
| Bronze | crm_sales_details | Raw sales data imported from source CSVs.                                               |
| Silver | crm_sales_details | Cleaned and transformed sales data; dates and numeric columns standardized.             |
| Silver | crm_cust_info     | Cleaned customer info from CRM system.                                                  |
| Silver | crm_prd_info      | Cleaned product info from CRM system.                                                   |
| Gold   | dim_customers     | Enriched customer dimension for reporting.                                              |
| Gold   | dim_products      | Product dimension with categories and attributes for analytics.                         |
| Gold   | fact_sales        | Fact table linking sales transactions to customers and products for analytical queries. |

---
