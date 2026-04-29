SELECT 
    SUM(SalesAmount) AS TotalInternetSales

FROM FactInternetSales;


SELECT *

FROM FactInternetSales;

SELECT 
    st.SalesTerritoryCountry AS Country,
    SUM(fs.SalesAmount) AS TotalRevenue
FROM FactInternetSales fs
JOIN DimSalesTerritory st 
    ON fs.SalesTerritoryKey = st.SalesTerritoryKey
GROUP BY st.SalesTerritoryCountry
ORDER BY TotalRevenue DESC;

SELECT 
    p.EnglishProductName AS Product,
    SUM(fs.SalesAmount) AS TotalRevenue
FROM FactInternetSales fs
JOIN DimProduct p 
    ON fs.ProductKey = p.ProductKey
GROUP BY p.EnglishProductName
ORDER BY TotalRevenue DESC;

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

SELECT TOP 100
    c.FirstName + ' ' + c.LastName AS CustomerName,
    SUM(fs.SalesAmount) AS TotalSpent
FROM FactInternetSales fs

JOIN DimCustomer c 
    ON fs.CustomerKey = c.CustomerKey
GROUP BY 
    c.FirstName,
    c.LastName
ORDER BY TotalSpent DESC
