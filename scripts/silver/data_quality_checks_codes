/* ===========================================================
DATA QUALITY CHECKS – BRONZE & SILVER LAYER
Purpose: Identify bad data in raw Bronze tables and validate
transformed Silver tables for consistency and correctness.
=========================================================== */

/* ========================== BRONZE LAYER CHECKS ========================== */
PRINT '================== BRONZE: CUSTOMER TABLE ==================';

/* 1. Check NULL customer IDs */
SELECT cst_id
FROM bronze.crm_cust_info
WHERE cst_id IS NULL;

/* 2. Check duplicate customer IDs */
SELECT cst_id, COUNT(*) AS cnt
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1;

/* 3. Detect unwanted spaces in names */
SELECT cst_firstname, cst_lastname
FROM bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)
   OR cst_lastname != TRIM(cst_lastname);

PRINT '================== BRONZE: SALES TABLE ==================';

/* 4. Check invalid order/ship/due dates */
SELECT *
FROM bronze.crm_sales_details
WHERE LEN(sls_order_dt) != 8
   OR LEN(sls_ship_dt) != 8
   OR LEN(sls_due_dt) != 8;

/* 5. Check negative or NULL quantity, price, sales */
SELECT *
FROM bronze.crm_sales_details
WHERE sls_quantity <= 0
   OR sls_price <= 0
   OR sls_sales < 0;

/* 6. Check sales consistency (Sales = Quantity × Price) */
SELECT *
FROM bronze.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
   OR sls_sales IS NULL
   OR sls_quantity IS NULL
   OR sls_price IS NULL;

PRINT '================== BRONZE: ERP CUSTOMER TABLE ==================';

/* 7. Invalid or future/ancient birthdates */
SELECT bdate
FROM bronze.erp_cust_az12
WHERE bdate < '1900-01-01'
   OR bdate > GETDATE();

/* 8. Invalid gender values */
SELECT DISTINCT gen
FROM bronze.erp_cust_az12
WHERE UPPER(TRIM(gen)) NOT IN ('M','F','MALE','FEMALE');

PRINT '================== BRONZE: PRODUCT CATEGORY TABLE ==================';

/* 9. Unwanted spaces in category/subcategory/maintenance */
SELECT *
FROM bronze.erp_px_cat_g1v2
WHERE cat != TRIM(cat) 
   OR subcat != TRIM(subcat)
   OR maintenance != TRIM(maintenance);

/* 10. Review distinct maintenance values */
SELECT DISTINCT maintenance
FROM bronze.erp_px_cat_g1v2;

/* ========================== SILVER LAYER CHECKS ========================== */
PRINT '================== SILVER: CUSTOMER TABLE ==================';

/* 1. NULL or duplicate customer IDs */
SELECT cst_id
FROM silver.crm_cust_info
WHERE cst_id IS NULL;

SELECT cst_id, COUNT(*) AS cnt
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1;

/* 2. Standardized gender values check */
SELECT DISTINCT cst_gndr
FROM silver.crm_cust_info
WHERE cst_gndr NOT IN ('Male','Female','n/a');

/* 3. Standardized marital status check */
SELECT DISTINCT cst_marital_status
FROM silver.crm_cust_info
WHERE cst_marital_status NOT IN ('Single','Married','n/a');

PRINT '================== SILVER: PRODUCT TABLE ==================';

/* 4. Check product cost validity */
SELECT prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

/* 5. Check product line domain values */
SELECT DISTINCT prd_line
FROM silver.crm_prd_info
WHERE prd_line NOT IN ('Mountain','Road','Touring','Other Sales','n/a');

PRINT '================== SILVER: SALES TABLE ==================';

/* 6. Sales consistency: Sales = Quantity × Price */
SELECT *
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
   OR sls_sales IS NULL
   OR sls_quantity IS NULL
   OR sls_price IS NULL;

/* 7. Date consistency: order <= ship <= due */
SELECT *
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt
   OR sls_ship_dt > sls_due_dt;

/* 8. Foreign key validation: sales keys must exist in products/customers */
SELECT *
FROM silver.crm_sales_details
WHERE sls_prd_key NOT IN (SELECT prd_key FROM silver.crm_prd_info)
   OR sls_cust_id NOT IN (SELECT cst_id FROM silver.crm_cust_info);

PRINT '================== SILVER: ERP CUSTOMER TABLE ==================';

/* 9. ERP gender standardization */
SELECT *
FROM silver.erp_cust_az12
WHERE gen NOT IN ('Male','Female','n/a');

PRINT '================== SILVER: ERP CATEGORY TABLE ==================';

/* 10. Review distinct maintenance values */
SELECT DISTINCT maintenance
FROM silver.erp_px_cat_g1v2;

/* 11. Full ERP category table check for any issues */
SELECT *
FROM silver.erp_px_cat_g1v2;
