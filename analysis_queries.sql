-- Retail Sales & Customer Insights - SQL Analysis
-- Dataset: Sample Superstore (Kaggle), 9,994 orders, 2014-2017
-- Table: sales

-- 1. Overview numbers - total sales, profit, orders, margin
SELECT
    COUNT(DISTINCT "Order ID")   AS total_orders,
    ROUND(SUM(Sales), 2)          AS total_sales,
    ROUND(SUM(Profit), 2)         AS total_profit,
    ROUND(SUM(Profit) * 100.0 / SUM(Sales), 2) AS profit_margin_pct
FROM sales;


-- 2. Which region makes the most money?
SELECT
    Region,
    COUNT(DISTINCT "Order ID")    AS orders,
    ROUND(SUM(Sales), 2)          AS total_sales,
    ROUND(SUM(Profit), 2)         AS total_profit
FROM sales
GROUP BY Region
ORDER BY total_sales DESC;


-- 3. Top 10 products by sales
SELECT
    "Product Name",
    Category,
    "Sub-Category",
    ROUND(SUM(Sales), 2)   AS total_sales,
    ROUND(SUM(Profit), 2)  AS total_profit,
    SUM(Quantity)          AS units_sold
FROM sales
GROUP BY "Product Name", Category, "Sub-Category"
ORDER BY total_sales DESC
LIMIT 10;


-- 4. Monthly sales trend across the whole dataset
SELECT
    strftime('%Y', "Order Date")  AS year,
    strftime('%m', "Order Date")  AS month,
    ROUND(SUM(Sales), 2)          AS monthly_sales
FROM sales
GROUP BY year, month
ORDER BY year, month;


-- 5. Sub-categories with low or negative margin
-- (this is the one that flagged Tables and Bookcases as loss-making)
SELECT
    Category,
    "Sub-Category",
    ROUND(SUM(Sales), 2)   AS total_sales,
    ROUND(SUM(Profit), 2)  AS total_profit,
    ROUND(SUM(Profit) * 100.0 / SUM(Sales), 2) AS profit_margin_pct
FROM sales
GROUP BY Category, "Sub-Category"
HAVING profit_margin_pct < 10
ORDER BY profit_margin_pct ASC;


-- 6. Top 10 customers by how much they've spent
SELECT
    "Customer ID",
    "Customer Name",
    COUNT(DISTINCT "Order ID")  AS orders_placed,
    ROUND(SUM(Sales), 2)        AS total_spend
FROM sales
GROUP BY "Customer ID", "Customer Name"
ORDER BY total_spend DESC
LIMIT 10;


-- 7. Does discount level actually hurt profit margin?
-- bucketing discounts into bands to compare average margin
SELECT
    CASE
        WHEN Discount = 0 THEN 'No Discount'
        WHEN Discount <= 0.15 THEN 'Low (up to 15%)'
        WHEN Discount <= 0.20 THEN 'Medium (up to 20%)'
        ELSE 'High (>20%)'
    END AS discount_band,
    COUNT(*)                                    AS orders,
    ROUND(AVG(Profit * 100.0 / Sales), 2)        AS avg_profit_margin_pct
FROM sales
GROUP BY discount_band
ORDER BY avg_profit_margin_pct DESC;


-- 8. How do the 3 customer segments compare?
SELECT
    Segment,
    COUNT(DISTINCT "Customer ID")  AS unique_customers,
    ROUND(SUM(Sales), 2)           AS total_sales,
    ROUND(AVG(Sales), 2)           AS avg_order_value
FROM sales
GROUP BY Segment
ORDER BY total_sales DESC;


-- 9. Drilling into states within the top region (subquery)
SELECT
    State,
    ROUND(SUM(Sales), 2)  AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM sales
WHERE Region = (
    SELECT Region FROM sales
    GROUP BY Region
    ORDER BY SUM(Sales) DESC
    LIMIT 1
)
GROUP BY State
ORDER BY total_sales DESC
LIMIT 10;


-- 10. Does shipping speed relate to order value at all?
SELECT
    "Ship Mode",
    COUNT(*)                AS orders,
    ROUND(AVG(Sales), 2)    AS avg_order_value,
    ROUND(SUM(Sales), 2)    AS total_sales
FROM sales
GROUP BY "Ship Mode"
ORDER BY total_sales DESC;


-- 11. Products that are consistently losing money
-- candidates for discontinuing or re-pricing
SELECT
    "Product Name",
    Category,
    "Sub-Category",
    COUNT(*)               AS times_ordered,
    ROUND(SUM(Sales), 2)   AS total_sales,
    ROUND(SUM(Profit), 2)  AS total_profit
FROM sales
GROUP BY "Product Name", Category, "Sub-Category"
HAVING total_profit < 0
ORDER BY total_profit ASC
LIMIT 10;
