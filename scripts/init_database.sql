/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'DataWarehouse' after checking if it already exists.
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas
    within the database: 'bronze', 'silver', and 'gold'.

WARNING:
    Running this script will drop the entire 'DataWarehouse' database if it exists.
    All data in the database will be permanently deleted. Proceed with caution
    and ensure you have proper backups before running this script.
*/

USE master;
GO

-- Drop and recreate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')

  /*ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  
   C’est la ligne la plus importante. SQL Server refuse de supprimer une base si quelqu’un y est 
  connecté (une autre fenêtre SSMS ouverte sur DataWarehouse, par exemple). 
  Cette ligne vide la base de ses occupants :

SET SINGLE_USER passe la base en mode un seul utilisateur, toi ;
WITH ROLLBACK IMMEDIATE coupe immédiatement les autres connexions et 
  annule leurs opérations en cours, sans attendre qu’elles finissent.
  
  DROP DATABASE DataWarehouse;*/
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END;
GO

-- Create the 'DataWarehouse' database
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-- Create Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
