
/*
=========================================================
Procédure : bronze.load_bronze
Rôle      : charge les 6 CSV dans la couche bronze
            (TRUNCATE + BULK INSERT)
Usage     : EXEC bronze.load_bronze;
=========================================================*/
--CREER OU MODIFIER + SCHEMA.LOAT_COUCHE
CREATE OR ALTER PROCEDURE  bronze.load_bronze AS
BEGIN
    DECLARE @start_time DATETIME, 
	          @end_time DATETIME, 
			      @batch_start_time DATETIME,
		      	@batch_end_time DATETIME;
  	BEGIN TRY
	    SET @batch_start_time = GETDATE();
		PRINT'==========================================================='
		PRINT 'Loading Bronze Layer'
		PRINT'==========================================================='

		PRINT'-----------------------------------------------------------';
		PRINT 'Loading CRM Tables '
		PRINT'-----------------------------------------------------------';

		SET @start_time = GETDATE();
		--Vider la table avant recharge, si non double chargement
		PRINT'>> Truncating Table : bronze.crm_cust_info'
		TRUNCATE TABLE bronze.crm_cust_info;

		--Insertion en vrac 
		PRINT'>> Inserting Data Into: bronze.crm_cust_info'
		BULK INSERT bronze.crm_cust_info
		--Emplacement du fichier source
		FROM 'C:\Users\ebene\Desktop\Cours dataIngénieur BootCam\sql-data-warehouse-project\01_datasets\source_crm\cust_info.csv'
			WITH (
			--récupérer à partir de la ligne 2
			FIRSTROW = 2,
			--séparateur de données
			FIELDTERMINATOR = ',',
			/*Verouillage de la bande (SQL verouille la table lors du chargement)
			--pour améliorer la performance*/
			TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) +'seconds';
		PRINT'----------------------------';
		--On vient de charger 18493 lignes dans la base de données

		/*Validation des données 
		(données dans les colonnes ?)*/
		--SELECT * FROM bronze.crm_cust_info 

		/*et données dans les bonnes colonnes ? 
		Oui c'est le cas,(ça ne serait pas le cas si le séparateur ',' n'était pas le bon*/

		--Nombre de lignes
		--SELECT COUNT(*) FROM bronze.crm_cust_info
		--------------------------------------------
		--------------------------------------------
		SET @start_time = GETDATE();
		PRINT'>> Truncating Table : bronze.crm_prd_info'
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT'>> Inserting Data Into: bronze.crm_prd_info'
		--Insertion en vrac 
		BULK INSERT bronze.crm_prd_info
		--Emplacement du fichier source
		FROM 'C:\Users\ebene\Desktop\Cours dataIngénieur BootCam\sql-data-warehouse-project\01_datasets\source_crm\prd_info.csv'
		WITH (
			--récupérer à partir de la ligne 2
			FIRSTROW = 2,
			--séparateur de données
			FIELDTERMINATOR = ',',
			/*Verouillage de la bande (SQL verouille la table lors du chargement)
			--pour améliorer la performance*/
			TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) +'seconds';
		--SELECT COUNT(*) FROM bronze.crm_prd_info
		PRINT'----------------------------';

		SET @start_time = GETDATE();
		PRINT'>> Truncating Table : bronze.crm_sales_details'
		TRUNCATE TABLE bronze.crm_sales_details;
		--Insertion en vrac 

		PRINT'>> Inserting Data Into: bronze.crm_sales_details'
		BULK INSERT bronze.crm_sales_details
		--Emplacement du fichier source
		FROM 'C:\Users\ebene\Desktop\Cours dataIngénieur BootCam\sql-data-warehouse-project\01_datasets\source_crm\sales_details.csv'
			WITH (
			--récupérer à partir de la ligne 2
			FIRSTROW = 2,
			--séparateur de données
			FIELDTERMINATOR = ',',
			/*Verouillage de la bande (SQL verouille la table lors du chargement)
			--pour améliorer la performance*/
			TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) +'seconds';
		
		PRINT'-----------------------------------------------------------';
		PRINT 'Loading ERP Tables '
		PRINT'-----------------------------------------------------------';
	
		SET @start_time = GETDATE();
		PRINT'>> Truncating Table : bronze.erp_loc_a101'
		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT'>> Inserting Data Into: bronze.erp_loc_a101'
		--Insertion en vrac 
		BULK INSERT bronze.erp_loc_a101
		--Emplacement du fichier source
		FROM 'C:\Users\ebene\Desktop\Cours dataIngénieur BootCam\sql-data-warehouse-project\01_datasets\source_erp\LOC_A101.csv'
			WITH (
			--récupérer à partir de la ligne 2
			FIRSTROW = 2,
			--séparateur de données
			FIELDTERMINATOR = ',',
			/*Verouillage de la bande (SQL verouille la table lors du chargement)
			--pour améliorer la performance*/
			TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) +'seconds';
		--SELECT COUNT(*) FROM bronze.erp_loc_a101
		PRINT'-----------------------------------';

		SET @start_time = GETDATE();
		PRINT'>> Truncating Table : bronze.erp_cust_az12'
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT'>> Inserting Data Into: bronze.erp_cust_az12'
		--Insertion en vrac 
		BULK INSERT bronze.erp_cust_az12
		--Emplacement du fichier source
		FROM 'C:\Users\ebene\Desktop\Cours dataIngénieur BootCam\sql-data-warehouse-project\01_datasets\source_erp\CUST_AZ12.csv'
			WITH (
			--récupérer à partir de la ligne 2
			FIRSTROW = 2,
			--séparateur de données
			FIELDTERMINATOR = ',',
			/*Verouillage de la bande (SQL verouille la table lors du chargement)
			--pour améliorer la performance*/
			TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) +'seconds';
		--SELECT COUNT (*) FROM bronze.erp_cust_az12
		PRINT'-----------------------------------';

		SET @start_time = GETDATE();
		PRINT'>> Truncating Table : bronze.erp_px_cat_g1v2'
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT'>> Inserting Data Into: bronze.erp_px_cat_g1v2'
		--Insertion en vrac 
		BULK INSERT bronze.erp_px_cat_g1v2
		--Emplacement du fichier source
		FROM 'C:\Users\ebene\Desktop\Cours dataIngénieur BootCam\sql-data-warehouse-project\01_datasets\source_erp\PX_CAT_G1V2.csv'
			WITH (
			--récupérer à partir de la ligne 2
			FIRSTROW = 2,
			--séparateur de données
			FIELDTERMINATOR = ',',
			/*Verouillage de la bande (SQL verouille la table lors du chargement)
			--pour améliorer la performance*/
			TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) +'seconds';
		PRINT'----------------------';

		SET @batch_end_time = GETDATE();
		PRINT'====================================================================='
		PRINT'Loading Bronze Layer is Completed';
		PRINT '- Total Load Duration:' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) +'seconds';
		PRINT'====================================================================='
		--SELECT COUNT (*) FROM bronze.erp_px_cat_g1v2
	END TRY

	--Code d'erreur si le l'execution du TRY rencontre une erreur
	BEGIN CATCH 
		PRINT '=========================================='
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message:'+ ERROR_MESSAGE();
		PRINT 'Error Number:'+ CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Code:'+ CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '========================================='
	END CATCH
END
