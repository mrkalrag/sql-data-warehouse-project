-- ========================================================================================
-- PURPOSE: Gold Layer Quality Check
-- ========================================================================================
-- This script is used to perform **data quality checks** on the Gold layer customer data 
-- after joining Silver layer tables. 
-- It ensures:
-- 1. No duplicate customer records are created after the joins.
-- 2. Gender column values are integrated correctly from CRM (priority) and ERP (fallback).
-- 
-- WARNING: Expected result for the duplicate check should be **no rows**. 
--          Any result indicates duplicates that need resolution before building the Gold table.
-- ========================================================================================

-- ===============================
-- CHECK 1: Detect duplicate customers after joining tables
-- ===============================
SELECT cst_id, COUNT(*) 
FROM
(
    SELECT 
        ci.cst_id,
        ci.cst_key,
        ci.cst_firstname,
        ci.cst_lastname,
        ci.cst_marital_status,
        ci.cst_gndr,
        ci.cst_create_date,
        ca.bdate,
        ca.gen,
        la.cntry
    FROM silver.crm_cust_info AS ci
    LEFT JOIN silver.erp_cust_az12 AS ca
        ON ci.cst_key = ca.cid
    LEFT JOIN silver.erp_loc_a101 AS la
        ON ci.cst_key = la.cid
) t
GROUP BY cst_id
HAVING COUNT(*) > 1

-- ========================================================================================
-- CHECK 2: Verify gender integration from CRM and ERP
-- ========================================================================================
-- CRM gender is the master; if missing, fallback to ERP gender; if both missing, assign 'n/a'.
SELECT DISTINCT
    ci.cst_gndr,
    ca.gen,
    CASE 
        WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr  -- CRM is prioritized
        ELSE COALESCE(ca.gen, 'n/a')               -- ERP used as fallback
    END AS new_gen
FROM silver.crm_cust_info AS ci
LEFT JOIN silver.erp_cust_az12 AS ca
    ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 AS la
    ON ci.cst_key = la.cid
ORDER BY 1,2
