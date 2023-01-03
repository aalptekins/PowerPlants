--Exploring the data

SELECT *
FROM PowerPlants

SELECT DISTINCT primary_fuel
FROM PowerPlants

--Looking at the top 10 plants in the world according to their capacity

SELECT TOP 10 country_long,[capacity in MW],primary_fuel,[name of powerplant]
FROM PowerPlants
ORDER BY [capacity in MW] DESC

-- What is the most used fuel to generate electricity 

SELECT country_long,primary_fuel,SUM([capacity in MW]) AS TotalPower
FROM PowerPlants
GROUP BY primary_fuel,country_long
ORDER BY TotalPower DESC

--Countries total power

SELECT country_long,SUM([capacity in MW]) AS TotalPower
FROM PowerPlants
GROUP BY country_long
ORDER BY TotalPower DESC

--Countries total power top 10

SELECT TOP 10 country_long,SUM([capacity in MW]) AS TotalPower
FROM PowerPlants
GROUP BY country_long
ORDER BY TotalPower DESC


--Let's look at which country uses renewable energy most to genereate electricity

SELECT country_long,SUM([capacity in MW]) AS TotalPower
FROM PowerPlants
WHERE primary_fuel IN ('Hydro','Wind','Solar','Geothermal','Wave and Tidal')
GROUP BY country_long
ORDER BY TotalPower DESC


--Looking at the top 10 plants in Turkey according to their capacity

SELECT TOP 10 country_long,[capacity in MW],primary_fuel,[name of powerplant]
FROM PowerPlants
WHERE country_long = 'Turkey'
ORDER BY [capacity in MW] DESC


--Looking at plants in the Turkey to analyze what is the primary fuel for plants

SELECT primary_fuel,SUM([capacity in MW]) AS TotalPower
FROM PowerPlants
WHERE country_long = 'Turkey'
GROUP BY primary_fuel
ORDER BY TotalPower DESC

--Most used renewable energy sources in Turkey

SELECT primary_fuel,SUM([capacity in MW]) AS TotalPower
FROM PowerPlants
WHERE country_long = 'Turkey' and primary_fuel NOT IN ('Coal','Gas','Oil')
GROUP BY primary_fuel
ORDER BY TotalPower DESC


--Number of plants that uses renewable and unrenewable sources in Turkey

SELECT RenewableSource,COUNT(RenewableSource) AS NumberOfPlants
FROM PowerPlants
WHERE country_long='Turkey'
GROUP BY RenewableSource



--Most used fossil sources in Turkey

SELECT primary_fuel,SUM([capacity in MW]) AS TotalPower
FROM PowerPlants
WHERE country_long = 'Turkey' and primary_fuel IN ('Coal','Gas','Oil')
GROUP BY primary_fuel
ORDER BY TotalPower DESC

--Most used fuel sources in Turkey

SELECT primary_fuel,SUM([capacity in MW]) AS TotalPower
FROM PowerPlants
WHERE country_long = 'Turkey' 
GROUP BY primary_fuel
ORDER BY TotalPower DESC


--Looking at biggest plants owner in Turkey

SELECT TOP 10 [owner of plant],SUM([capacity in MW]) AS TotalPower
FROM PowerPlants
WHERE country_long = 'Turkey'
	AND [owner of plant] IS NOT NULL
GROUP BY [owner of plant]
ORDER BY TotalPower DESC


SELECT *
FROM PowerPlants
WHERE country_long = 'Turkey'



--Query for to see plants according to their primaryfuel

SELECT primary_fuel,count(primary_fuel) as NumberofPlants
FROM PowerPlants
GROUP BY primary_fuel


--Create a newcolumn according to if it uses renewable energy sources or not

ALTER TABLE PowerPlants
ADD RenewableSource NVARCHAR(50)

UPDATE PowerPlants
SET RenewableSource =( CASE 
	WHEN primary_fuel IN ('Coal','Gas','Oil') THEN 'No'
	WHEN primary_fuel NOT IN ('Coal','Gas','Oil') THEN 'Yes'
	END);

--Number of plants that uses renewable and unrenewable sources

SELECT RenewableSource,COUNT(RenewableSource) AS NumberOfPlants
FROM PowerPlants
GROUP BY RenewableSource

