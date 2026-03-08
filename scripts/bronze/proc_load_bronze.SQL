/*
====================================================================================
Procedure: bronze.load_bronze

Purpose:
Loads raw source files from CRM and ERP systems into the Bronze layer of the
data warehouse. The procedure truncates existing data and performs bulk inserts
from CSV files to ensure a fresh load.

Notes:
- The Bronze layer stores raw data with minimal transformation.
- Each table load is timed to monitor performance.
- Errors are captured using TRY...CATCH for easier debugging.
====================================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN

	DECLARE @start_time DATETIME, 
			@end_time DATETIME; 

	BEGIN TRY

		SET @start_time = GETDATE();

		PRINT '=============================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '=============================================================';

		PRINT '-------------------------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '-------------------------------------------------------------';

		--===========================================================
		-- CRM TABLE: Customer Information
		--===========================================================

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>> Inserting Data Into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\DELL\Downloads\Crm Data\cust_info.csv'
		WITH (
			FIRSTROW = 2,        -- skip header
			FIELDTERMINATOR = ',',
			TABLOCK              -- improves bulk load performance
		);

		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + 
		CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

		PRINT '--------------------------------------------------------------------------------------------';


		--===========================================================
		-- CRM TABLE: Sales Details
		--===========================================================

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '>> Inserting Data Into: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\DELL\Downloads\Crm Data\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + 
		CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

		PRINT '--------------------------------------------------------------------------------------------';


		--===========================================================
		-- CRM TABLE: Product Information
		--===========================================================

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '>> Inserting Data Into: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\DELL\Downloads\Crm Data\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + 
		CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

		PRINT '--------------------------------------------------------------------------------------------';


		--=========================================================================================
		-- ERP SOURCE TABLES
		--=========================================================================================

		PRINT '-------------------------------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '-------------------------------------------------------------';


		--===========================================================
		-- ERP TABLE: Product Categories
		--===========================================================

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT '>> Inserting Data Into: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\DELL\Downloads\Erp Database\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + 
		CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

		PRINT '--------------------------------------------------------------------------------------------';


		--===========================================================
		-- ERP TABLE: Location Data
		--===========================================================

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT '>> Inserting Data Into: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\DELL\Downloads\Erp Database\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + 
		CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

		PRINT '--------------------------------------------------------------------------------------------';


		--===========================================================
		-- ERP TABLE: Customer Data
		--===========================================================

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT '>> Inserting Data Into: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\DELL\Downloads\Erp Database\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + 
		CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

		PRINT '--------------------------------------------------------------------------------------------';


		-- Overall load duration
		SET @end_time = GETDATE();

		PRINT '>> Bronze Layer Load Duration: ' + 
		CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

		PRINT '--------------------------------------------------------------------------------------------';

	END TRY

	BEGIN CATCH

		PRINT '==========================================================================';
		PRINT 'ERROR OCCURRED DURING LOADING BRONZE LAYER';
		PRINT 'Error Message: ' + ERROR_MESSAGE();
		PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error State : ' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '==========================================================================';

	END CATCH

END
