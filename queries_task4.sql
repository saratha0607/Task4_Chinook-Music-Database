-- =============================================
-- Chinook Database – SQL Joins & Business Insights
-- Task 4: Data Analyst Internship
-- =============================================

-- ==========================================================
-- 1. INNER JOIN: List all customer who have made purchases
-- ==========================================================
SELECT 
    c.CustomerId,
    c.FirstName,
    c.LastName,
    i.InvoiceId,
    i.InvoiceDate,
    i.Total
FROM Customer AS c
INNER JOIN Invoice AS i
    ON c.CustomerId = i.CustomerId
ORDER BY i.InvoiceDate;

-- ==========================================================
-- 2. LEFT JOIN: Find customers who have NEVER placed orders
-- ==========================================================
SELECT 
    c.CustomerId,
    c.FirstName,
    c.LastName
FROM Customer AS c
LEFT JOIN Invoice AS i
    ON c.CustomerId = i.CustomerId
WHERE i.InvoiceId IS NULL
ORDER BY c.LastName;

-- ==========================================================
-- 3. Total revenue per track
-- ==========================================================
SELECT 
    t.Name AS TrackName,
    SUM(il.UnitPrice * il.Quantity) AS TotalRevenue
FROM InvoiceLine AS il
INNER JOIN Track AS t
    ON il.TrackId = t.TrackId
GROUP BY t.Name
ORDER BY TotalRevenue DESC
LIMIT 10;

-- ==========================================================
-- 4. Total revenue per genre
-- ==========================================================
SELECT 
    g.Name AS Genre,
    SUM(il.UnitPrice * il.Quantity) AS GenreRevenue
FROM InvoiceLine AS il
INNER JOIN Track AS t
    ON il.TrackId = t.TrackId
INNER JOIN Genre AS g
    ON t.GenreId = g.GenreId
GROUP BY g.Name
ORDER BY GenreRevenue DESC;

-- ==========================================================
-- 5. Total revenue per artist
-- ==========================================================
SELECT 
    ar.Name AS Artist,
    SUM(il.UnitPrice * il.Quantity) AS ArtistRevenue
FROM InvoiceLine AS il
INNER JOIN Track AS t
    ON il.TrackId = t.TrackId
INNER JOIN Album AS al
    ON t.AlbumId = al.AlbumId
INNER JOIN Artist AS ar
    ON al.ArtistId = ar.ArtistId
GROUP BY ar.Name
ORDER BY ArtistRevenue DESC
LIMIT 5;

-- ==========================================================
-- 6. Total sales by country and date range
-- ==========================================================
SELECT 
    c.Country,
    SUM(i.Total) AS TotalSales
FROM Invoice AS i
INNER JOIN Customer AS c
    ON i.CustomerId = c.CustomerId
WHERE i.InvoiceDate BETWEEN '2010-01-01' AND '2013-12-31'
AND c.Country = 'USA'
GROUP BY c.Country;

-- ==========================================================
-- 7. Top-selling tracks by quantity
-- ==========================================================
SELECT 
    t.Name AS TrackName,
    SUM(il.Quantity) AS TotalUnitsSold
FROM InvoiceLine AS il
INNER JOIN Track AS t
    ON il.TrackId = t.TrackId
GROUP BY t.Name
ORDER BY TotalUnitsSold DESC
LIMIT 10;

-- ==========================================================
-- 8. Customers and total spending
-- ==========================================================
SELECT 
    c.CustomerId,
    c.FirstName,
    c.LastName,
    SUM(i.Total) AS TotalSpent
FROM Customer AS c
INNER JOIN Invoice AS i
    ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId, c.FirstName, c.LastName
ORDER BY TotalSpent DESC
LIMIT 10;

-- ==========================================================
-- 9. Tracks with genre and artist info
-- ==========================================================
SELECT 
    t.Name AS TrackName,
    g.Name AS Genre,
    ar.Name AS Artist
FROM Track AS t
INNER JOIN Genre AS g
    ON t.GenreId = g.GenreId
INNER JOIN Album AS al
    ON t.AlbumId = al.AlbumId
INNER JOIN Artist AS ar
    ON al.ArtistId = ar.ArtistId
ORDER BY ar.Name, t.Name;

-- ==========================================================
-- End of Chinook SQL Joins Queries
-- =============================================