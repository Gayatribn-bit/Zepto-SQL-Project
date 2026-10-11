----------------------------------------------------
-- DATA EXPLORATION
----------------------------------------------------

-- Count of rows
SELECT COUNT(*) AS total_rows FROM zepto;

-- Sample data
SELECT TOP 10 * FROM zepto;

-- Null values check
SELECT * FROM zepto
WHERE name IS NULL
   OR category IS NULL
   OR mrp IS NULL
   OR discountPercent IS NULL
   OR discountedSellingPrice IS NULL
   OR weightInGms IS NULL
   OR availableQuantity IS NULL
   OR outOfStock IS NULL
   OR quantity IS NULL;

-- Different product categories
SELECT DISTINCT category
FROM zepto
ORDER BY category;

-- Products in stock vs out of stock
SELECT outOfStock, COUNT(sku_id) AS stock_count
FROM zepto
GROUP BY outOfStock;

-- Product names present multiple times
SELECT name, COUNT(sku_id) AS [Number of SKUs]
FROM zepto
GROUP BY name
HAVING COUNT(sku_id) > 1
ORDER BY COUNT(sku_id) DESC;


----------------------------------------------------
-- DATA CLEANING
----------------------------------------------------

-- Products with price = 0
SELECT * FROM zepto
WHERE mrp = 0 OR discountedSellingPrice = 0;

-- Delete rows with mrp = 0
DELETE FROM zepto
WHERE mrp = 0;

-- Convert paise to rupees (if applicable based on your data source)
UPDATE zepto
SET mrp = mrp / 100.0,
    discountedSellingPrice = discountedSellingPrice / 100.0;

SELECT mrp, discountedSellingPrice FROM zepto;


----------------------------------------------------
-- DATA ANALYSIS
----------------------------------------------------

-- Q1. Find the top 10 best-value products based on the discount percentage.
SELECT DISTINCT TOP 10 name, mrp, discountPercent
FROM zepto
ORDER BY discountPercent DESC;

-- Q2. What are the Products with High MRP but Out of Stock
-- (Note: outOfStock = 1 represents TRUE for BIT data type)
SELECT DISTINCT name, mrp
FROM zepto
WHERE outOfStock = 1 AND mrp > 300
ORDER BY mrp DESC;

-- Q3. Calculate Estimated Revenue for each category
SELECT category,
       SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto
GROUP BY category
ORDER BY total_revenue;

-- Q4. Find all products where MRP is greater than 500 and discount is less than 10%.
SELECT DISTINCT name, mrp, discountPercent
FROM zepto
WHERE mrp > 500 AND discountPercent < 10
ORDER BY mrp DESC, discountPercent DESC;

-- Q5. Identify the top 5 categories offering the highest average discount percentage.
SELECT TOP 5 category,
       ROUND(AVG(discountPercent), 2) AS avg_discount
FROM zepto
GROUP BY category
ORDER BY avg_discount DESC;

-- Q6. Find the price per gram for products above 100g and sort by best value.
SELECT DISTINCT name, weightInGms, discountedSellingPrice,
       ROUND(CAST(discountedSellingPrice AS FLOAT) / weightInGms, 2) AS price_per_gram
FROM zepto
WHERE weightInGms >= 100
ORDER BY price_per_gram;

-- Q7. Group the products into weight categories like Low, Medium, Bulk.
SELECT DISTINCT name, weightInGms,
       CASE 
           WHEN weightInGms < 1000 THEN 'Low'
           WHEN weightInGms < 5000 THEN 'Medium'
           ELSE 'Bulk'
       END AS weight_category
FROM zepto;

-- Q8. What is the Total Inventory Weight Per Category 
-- (CAST to BIGINT prevents arithmetic overflow with large quantities)
SELECT category,
       SUM(CAST(weightInGms AS BIGINT) * availableQuantity) AS total_weight
FROM zepto
GROUP BY category
ORDER BY total_weight;
