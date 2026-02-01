--Create Database named Climate_Change_Impact_on_Agric
CREATE DATABASE Climate_Change_Impact_on_Agric_UPDATE;

--Select Database to be used
USE Climate_Change_Impact_on_Agric_UPDATE;
GO

--Create Table climate_change_impact_on_agric
CREATE TABLE climate_change_impact_on_agric(
	ID INT NOT NULL,
	[Year] DATE NOT NULL,
	Country VARCHAR (50) NOT NULL,
	Region VARCHAR (50) NOT NULL,
	Crop_Type VARCHAR (50) NOT NULL,
	Average_Temperature_C FLOAT NOT NULL,
	Total_Precipitation_mm FLOAT NOT NULL,
	CO2_Emissions_MT FLOAT NOT NULL,
	Crop_Yield_MT_per_HA FLOAT NOT NULL,
	Extreme_Weather_Events INT NOT NULL,
	[Irrigation_Access_%] FLOAT NOT NULL,
	Pesticide_Use_KG_per_HA FLOAT NOT NULL,
	Fertilizer_Use_KG_per_HA FLOAT NOT NULL,
	Soil_Health_Index FLOAT NOT NULL,
	Adaptation_Strategies VARCHAR (50) NOT NULL,
	Economic_Impact_Million_USD FLOAT
	CONSTRAINT FK_climate_change_impact_on_agric_ID PRIMARY KEY (ID)
);

BULK INSERT climate_change_impact_on_agric
FROM 'C:\Users\Hams12\Documents\Documents\P_Work\My_Project\Excel\Dataset\Climate change impact on agriculture\climate_change_impact_on_agric_CSV.csv'
WITH(
	ROWTERMINATOR = '\n',
	FIRSTROW = 2,
	FORMAT = 'CSV'
	);

SELECT * FROM climate_change_impact_on_agric;