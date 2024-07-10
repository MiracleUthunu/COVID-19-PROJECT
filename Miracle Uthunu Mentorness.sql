SELECT *
FROM ['Corona Virus']


-- check NULL values
SELECT 
    COUNT(*) AS Null_Values_Count
FROM 
    ['Corona Virus']
WHERE 
    Province IS NULL OR
    [Country/Region] IS NULL OR
    Latitude IS NULL OR
Longitude IS NULL OR
    Date IS NULL OR
    Confirmed IS NULL OR
    Deaths IS NULL OR
    Recovered IS NULL;

-- update NULL values them with zeros for all columns if present
-- No NULL present 


--total number of rows
SELECT 
    COUNT(*) AS Total_Rows
FROM 
    ['Corona Virus'];


--start_date and end_date
SELECT 
    MIN(Date) AS Start_Date,
    MAX(Date) AS End_Date
FROM 
    ['Corona Virus'];


-- Unique Count of months present in dataset
SELECT COUNT(DISTINCT(CONVERT(VARCHAR(7), Date, 120))) AS NumberofMonths
FROM ['Corona Virus'];


--Monthly average for confirmed, deaths, recovered
SELECT 
    CONVERT(VARCHAR(7), Date, 120) AS Month,
    AVG(Confirmed) AS Average_Confirmed,
    AVG(Deaths) AS Average_Deaths,
    AVG(Recovered) AS Average_Recovered
FROM 
    ['Corona Virus']
GROUP BY 
    CONVERT(VARCHAR(7), Date, 120);


-- The most frequent value for confirmed, deaths, recovered each month
SELECT 
    CONVERT(VARCHAR(7), Date, 120) AS Month,
    MAX(Confirmed) AS Max_Confirmed,
    MAX(Deaths) AS Max_Deaths,
    MAX(Recovered) AS Max_Recovered
FROM 
    ['Corona Virus']
GROUP BY CONVERT(VARCHAR(7), Date, 120);



--minimum values for confirmed, deaths, recovered per year
SELECT 
    CONVERT(VARCHAR(7), Date, 120) AS Year,
    MIN(Confirmed) AS Min_Confirmed,
    MIN(Deaths) AS Min_Deaths,
    MIN(Recovered) AS Min_Recovered
FROM 
    ['Corona Virus']
GROUP BY 
   CONVERT(VARCHAR(7), Date, 120)
ORDER BY Year DESC;


-- maximum values of confirmed, deaths, recovered per year
SELECT 
    CONVERT(VARCHAR(7), Date, 120) AS Year,
    MAX(Confirmed) AS Max_Confirmed,
    MAX(Deaths) AS Max_Deaths,
    MAX(Recovered) AS Max_Recovered
FROM 
    ['Corona Virus']
GROUP BY 
   CONVERT(VARCHAR(7), Date, 120)
ORDER BY Year ASC;


-- total number of cases of confirmed, deaths, recovered each month
SELECT 
    CONVERT(VARCHAR(7), Date, 120) AS Year,
    SUM(Confirmed) AS Total_Confirmed,
    SUM(Deaths) AS Total_Deaths,
    SUM(Recovered) AS Total_Recovered
FROM 
    ['Corona Virus']
GROUP BY 
   CONVERT(VARCHAR(7), Date, 120)
ORDER BY Year DESC;


--coronavirus spread with respect to confirmed case
SELECT 
    COUNT(Confirmed) AS Total_Confirmed_Cases,
    AVG(Confirmed) AS Average_Confirmed,
    VARP(Confirmed) AS Variance_Confirmed,
    STDEV(Confirmed) AS Stdev_Confirmed
FROM 
    ['Corona Virus'];

-- coronavirus spread  with respect to death case per month
SELECT 
   CONVERT(VARCHAR(7), Date, 120) AS Month,
    COUNT(Deaths) AS Total_Death_Cases,
    AVG(Deaths) AS Average_Deaths,
    VAR(Deaths) AS Variance_Deaths,
    STDEV(Deaths) AS Stdev_Deaths
FROM 
    ['Corona Virus']
GROUP BY 
    CONVERT(VARCHAR(7), Date, 120);


-- Check how coronavirus spread out with respect to recovered case
SELECT 
    COUNT(Recovered) AS Total_Recovered_Cases,
    AVG(Recovered) AS Average_Recovered,
    VARP(Recovered) AS Variance_Recovered,
    STDEV(Recovered) AS Stdev_Recovered
FROM 
    ['Corona Virus'];

--Country having the highest number of Confirmed cases
SELECT TOP 1 [Country/Region],
    MAX(Confirmed) AS Max_Confirmed_Cases
FROM 
    ['Corona Virus']
GROUP BY 
    [Country/Region]
ORDER BY 
    Max_Confirmed_Cases DESC;


--Country having the lowest number of death cases
SELECT 
    TOP 1 [Country/Region],
    MIN(Deaths) AS Min_Death_Cases
FROM 
    ['Corona Virus']
GROUP BY 
    [Country/Region]
ORDER BY 
    Min_Death_Cases ASC;


-- top 5 countries having the highest recovered cases
SELECT 
    TOP 5 [Country/Region],
    MAX(Recovered) AS Max_Recovered_Cases
FROM 
    ['Corona Virus']
GROUP BY 
    [Country/Region]
ORDER BY 
    Max_Recovered_Cases DESC;
