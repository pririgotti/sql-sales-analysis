SELECT 
    SUM(SalesAmount) AS TotalInternetSales

FROM FactInternetSales;


Renevue by country

SELECT 
    st.SalesTerritoryCountry AS Country,
    SUM(fs.SalesAmount) AS TotalRevenue
FROM FactInternetSales fs
JOIN DimSalesTerritory st 
    ON fs.SalesTerritoryKey = st.SalesTerritoryKey
GROUP BY st.SalesTerritoryCountry
ORDER BY TotalRevenue DESC;


Sales Trend Over Time

SELECT 
    d.CalendarYear,
    d.MonthNumberOfYear,
    SUM(fs.SalesAmount) AS TotalRevenue
FROM FactInternetSales fs
JOIN DimDate d 
    ON fs.OrderDateKey = d.DateKey
GROUP BY 
    d.CalendarYear,
    d.MonthNumberOfYear
ORDER BY 
    d.CalendarYear,
    d.MonthNumberOfYear;

Top 05 Products

SELECT TOP 5
    p.EnglishProductName AS Product,
    SUM(fs.SalesAmount) AS TotalRevenue
FROM FactInternetSales fs
JOIN DimProduct p 
    ON fs.ProductKey = p.ProductKey
GROUP BY p.EnglishProductName
ORDER BY TotalRevenue DESC;

Top 10 Product Group

SELECT TOP 10

    CASE 
        WHEN CHARINDEX(',', p.EnglishProductName) > 0 
        THEN LEFT(p.EnglishProductName, CHARINDEX(',', p.EnglishProductName) - 1)
        ELSE p.EnglishProductName
    END AS ProductGroup,
    SUM(fs.SalesAmount) AS Revenue
FROM FactInternetSales fs
JOIN DimProduct p 
    ON fs.ProductKey = p.ProductKey
GROUP BY 
    CASE 
        WHEN CHARINDEX(',', p.EnglishProductName) > 0 
        THEN LEFT(p.EnglishProductName, CHARINDEX(',', p.EnglishProductName) - 1)
        ELSE p.EnglishProductName
    END
ORDER BY Revenue DESC;

Top 10 Customers

SELECT TOP 10
    c.FirstName + ' ' + c.LastName AS CustomerName,
    SUM(fs.SalesAmount) AS TotalSpent
FROM FactInternetSales fs

JOIN DimCustomer c 
    ON fs.CustomerKey = c.CustomerKey
GROUP BY 
    c.FirstName,
    c.LastName
ORDER BY TotalSpent DESC
