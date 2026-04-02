# 📊 Sales Data Analysis using SQL

## 📁 Dataset
- Table Name: K1_SALES_DATA
- Contains sales, customer, product, and regional data

## 🛠 Tools Used
- Oracle SQL

## 🔍 Project Overview
This project focuses on analyzing sales data using SQL.  
Data cleaning and transformation were performed using SQL before visualization.

## 📊 Key Analysis Performed
- Total revenue and order analysis
- Top-selling products (SKU-level)
- Category-wise revenue analysis
- Monthly and yearly sales trends
- Customer segmentation (age & gender)
- Region-wise and payment method analysis

## 🧠 Key Insights
- Identified top-performing products and customers
- Observed monthly sales trends and seasonal patterns
- Analyzed customer behavior using demographic data

## 💡 Skills Demonstrated
- SQL (GROUP BY, CASE, AGGREGATE FUNCTIONS)
- Data Cleaning & Filtering
- Analytical Thinking

  ## 🧾 Sample SQL Queries

```sql
-- Total Revenue
SELECT SUM(TOTAL) 
FROM K1_SALES_DATA
WHERE TOTAL > 0
AND STATUS != 'refund';

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
