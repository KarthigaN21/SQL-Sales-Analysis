-- ============================================
-- PROJECT: Sales Data Analysis using SQL
-- TABLE: K1_SALES_DATA
-- ============================================

-- ============================================
-- STEP 1: DATA PREVIEW
-- ============================================
SELECT *
FROM K1_SALES_DATA
WHERE ROWNUM <= 10;

-- ============================================
-- STEP 2: DATA CLEANING CHECKS
-- ============================================

-- NULL Check
SELECT
COUNT(*) AS total_rows,
COUNT(REGION) AS region_not_null,
COUNT(CATEGORY) AS category_not_null,
COUNT(PAYMENT_METHOD) AS payment_not_null
FROM K1_SALES_DATA;

-- Identify NULL rows
SELECT *
FROM K1_SALES_DATA
WHERE REGION IS NULL
OR CATEGORY IS NULL
OR PAYMENT_METHOD IS NULL;

-- Check zero / invalid sales
SELECT *
FROM K1_SALES_DATA
WHERE TOTAL <= 0;

-- ============================================
-- STEP 3: BASIC ANALYSIS (VALID SALES ONLY)
-- ============================================

-- Total Revenue
SELECT SUM(TOTAL) AS total_revenue
FROM K1_SALES_DATA
WHERE TOTAL > 0
AND STATUS != 'refund';

-- Total Orders
SELECT COUNT(DISTINCT ORDER_ID) AS total_orders
FROM K1_SALES_DATA
WHERE TOTAL > 0
AND STATUS != 'refund';

-- Total Quantity Sold
SELECT SUM(QTY_ORDERED) AS total_quantity
FROM K1_SALES_DATA
WHERE TOTAL > 0
AND STATUS != 'refund';

-- Refund Orders Count
SELECT COUNT(*) AS refund_orders
FROM K1_SALES_DATA
WHERE STATUS = 'refund';

-- Refund Impact
SELECT
COUNT(*) AS refund_count,
SUM(QTY_ORDERED) AS total_items_refunded
FROM K1_SALES_DATA
WHERE STATUS = 'refund';

-- ============================================
-- STEP 4: PRODUCT ANALYSIS
-- ============================================

-- Top 5 Products
SELECT * FROM (
SELECT SKU, SUM(QTY_ORDERED) AS total_sold
FROM K1_SALES_DATA
WHERE TOTAL > 0
AND STATUS != 'refund'
GROUP BY SKU
ORDER BY total_sold DESC
)
WHERE ROWNUM <= 5;

-- Category-wise Revenue
SELECT CATEGORY, SUM(TOTAL) AS revenue
FROM K1_SALES_DATA
WHERE TOTAL > 0
AND STATUS != 'refund'
GROUP BY CATEGORY
ORDER BY revenue DESC;

-- Average Order Value per Category
SELECT CATEGORY, ROUND(AVG(TOTAL),2) AS avg_order_value
FROM K1_SALES_DATA
WHERE TOTAL > 0
AND STATUS != 'refund'
GROUP BY CATEGORY
ORDER BY avg_order_value DESC;

-- ============================================
-- STEP 5: TIME ANALYSIS
-- ============================================

-- Monthly Sales Trend
SELECT
TO_CHAR(ORDER_DATE, 'YYYY-MM') AS month,
SUM(TOTAL) AS revenue
FROM K1_SALES_DATA
WHERE TOTAL > 0
AND STATUS != 'refund'
GROUP BY TO_CHAR(ORDER_DATE, 'YYYY-MM')
ORDER BY month;

-- Year-wise Sales
SELECT YEAR, SUM(TOTAL) AS revenue
FROM K1_SALES_DATA
WHERE TOTAL > 0
AND STATUS != 'refund'
GROUP BY YEAR
ORDER BY YEAR;

-- Monthly Order Count
SELECT
TO_CHAR(ORDER_DATE, 'YYYY-MM') AS month,
COUNT(DISTINCT ORDER_ID) AS total_orders
FROM K1_SALES_DATA
WHERE TOTAL > 0
AND STATUS != 'refund'
GROUP BY TO_CHAR(ORDER_DATE, 'YYYY-MM')
ORDER BY month;

-- ============================================
-- STEP 6: CUSTOMER ANALYSIS
-- ============================================

-- Top 5 Customers
SELECT * FROM (
SELECT FULL_NAME, SUM(TOTAL) AS total_spent
FROM K1_SALES_DATA
WHERE TOTAL > 0
AND STATUS != 'refund'
GROUP BY FULL_NAME
ORDER BY total_spent DESC
)
WHERE ROWNUM <= 5;

-- Gender-wise Revenue
SELECT GENDER, SUM(TOTAL) AS revenue
FROM K1_SALES_DATA
WHERE TOTAL > 0
AND STATUS != 'refund'
GROUP BY GENDER;

-- Age Group Analysis
SELECT
CASE
WHEN AGE < 20 THEN 'Teen'
WHEN AGE BETWEEN 20 AND 40 THEN 'Adult'
WHEN AGE BETWEEN 41 AND 60 THEN 'Middle Age'
ELSE 'Senior'
END AS age_group,
SUM(TOTAL) AS revenue
FROM K1_SALES_DATA
WHERE TOTAL > 0
AND STATUS != 'refund'
GROUP BY
CASE
WHEN AGE < 20 THEN 'Teen'
WHEN AGE BETWEEN 20 AND 40 THEN 'Adult'
WHEN AGE BETWEEN 41 AND 60 THEN 'Middle Age'
ELSE 'Senior'
END
ORDER BY revenue DESC;

-- ============================================
-- STEP 7: PAYMENT ANALYSIS
-- ============================================

-- Payment Method Analysis
SELECT PAYMENT_METHOD, SUM(TOTAL) AS revenue
FROM K1_SALES_DATA
WHERE TOTAL > 0
AND STATUS != 'refund'
GROUP BY PAYMENT_METHOD
ORDER BY revenue DESC;

-- Average Discount Impact
SELECT
ROUND(AVG(DISCOUNT_PERCENT),2) AS avg_discount,
SUM(TOTAL) AS revenue
FROM K1_SALES_DATA
WHERE TOTAL > 0
AND STATUS != 'refund';

-- ============================================
-- END OF PROJECT
-- ============================================

