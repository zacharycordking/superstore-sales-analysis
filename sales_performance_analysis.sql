/* =====================================================
   SALES PERFORMANCE & REVENUE ANALYSIS PROJECT
   App: DBeaver / PostgreSQL
   Dataset: SampleSuperstore.csv
   Table name: samplesuperstore
   ===================================================== */

/* =====================================================
   SECTION 1 — VERIFY CURRENT DATABASE
   Objective: Confirms the connected database.
   ===================================================== */

SELECT current_database();

/* =====================================================
   SECTION 2 — FIND IMPORTED TABLE
   Objective: Confirms Sample Superstore table exists.
   ===================================================== */

SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_name ILIKE '%sample%';

/* =====================================================
   SECTION 3 — PREVIEW THE DATA
   Objective: Shows the first 10 rows of dataset.
   ===================================================== */

SELECT *
FROM samplesuperstore
LIMIT 10;

/* =====================================================
   SECTION 4 — CHECK FOR MISSING SALES VALUES
   Objective: Finds rows where sales data is missing.
   ===================================================== */

SELECT *
FROM samplesuperstore
WHERE sales IS NULL;

/* =====================================================
   SECTION 5 — CHECK FOR DUPLICATE ORDER IDS
   Objective: Shows repeated order IDs.
   ===================================================== */

SELECT order_id, COUNT(*) AS duplicate_count
FROM samplesuperstore
GROUP BY order_id
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;

/* =====================================================
   SECTION 6 — VERIFY PRODUCT CATEGORIES
   Objective: Checks the main product categories.
   ===================================================== */

SELECT DISTINCT category
FROM samplesuperstore
ORDER BY category;

/* =====================================================
   SECTION 7 — VERIFY REGIONS
   Objective: Checks the sales regions in the dataset.
   ===================================================== */

SELECT DISTINCT region
FROM samplesuperstore
ORDER BY region;

/* =====================================================
   SECTION 8 — TOTAL REVENUE
   Focus: How much total revenue did the company generate?
   ===================================================== */

SELECT ROUND(SUM(sales), 2) AS total_revenue
FROM samplesuperstore;

/* =====================================================
   SECTION 9 — TOTAL PROFIT
   Focus: How much total profit did the company generate?
   ===================================================== */

SELECT ROUND(SUM(profit), 2) AS total_profit
FROM samplesuperstore;

/* =====================================================
   SECTION 10 — PROFIT MARGIN
   Focus: What percentage of revenue became profit?
   ===================================================== */

SELECT
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin_percentage
FROM samplesuperstore;

/* =====================================================
   SECTION 11 — SALES BY REGION
   Focus: Which region generated the most revenue?
   ===================================================== */

SELECT
    region,
    ROUND(SUM(sales), 2) AS revenue
FROM samplesuperstore
GROUP BY region
ORDER BY revenue DESC;

/* =====================================================
   SECTION 12 — PROFIT BY REGION
   Focus: Which region generated the most profit?
   ===================================================== */

SELECT
    region,
    ROUND(SUM(profit), 2) AS profit
FROM samplesuperstore
GROUP BY region
ORDER BY profit DESC;

/* =====================================================
   SECTION 13 — TOP 10 PRODUCTS BY REVENUE
   Focus: Which products produced the most sales?
   ===================================================== */

SELECT
    product_name,
    ROUND(SUM(sales), 2) AS revenue
FROM samplesuperstore
GROUP BY product_name
ORDER BY revenue DESC
LIMIT 10;

/* =====================================================
   SECTION 14 — WORST 10 PRODUCTS BY PROFIT
   Focus: Which products lost the most money?
   ===================================================== */

SELECT
    product_name,
    ROUND(SUM(profit), 2) AS profit
FROM samplesuperstore
GROUP BY product_name
ORDER BY profit ASC
LIMIT 10;

/* =====================================================
   SECTION 15 — MONTHLY REVENUE TRENDS
   Focus: How does revenue change over time?
   ===================================================== */

SELECT
    DATE_TRUNC('month', order_date) AS month,
    ROUND(SUM(sales), 2) AS revenue
FROM samplesuperstore
GROUP BY month
ORDER BY month;

/* =====================================================
   SECTION 16 — CUSTOMER SEGMENTATION
   Focus: Which customer segment performs best?
   ===================================================== */

SELECT
    segment,
    ROUND(SUM(sales), 2) AS revenue,
    ROUND(SUM(profit), 2) AS profit
FROM samplesuperstore
GROUP BY segment
ORDER BY revenue DESC;

/* =====================================================
   SECTION 17 — DISCOUNT IMPACT ON PROFIT
   Focus: Do higher discounts reduce profit?
   ===================================================== */

SELECT
    discount,
    ROUND(AVG(profit), 2) AS average_profit
FROM samplesuperstore
GROUP BY discount
ORDER BY discount;

/* =====================================================
   SECTION 18 — REVENUE BY CATEGORY
   Focus: Which product category creates the most revenue?
   ===================================================== */

SELECT
    category,
    ROUND(SUM(sales), 2) AS revenue
FROM samplesuperstore
GROUP BY category
ORDER BY revenue DESC;

/* =====================================================
   SECTION 19 — PROFIT BY CATEGORY
   Focus: Which product category creates the most profit?
   ===================================================== */

SELECT
    category,
    ROUND(SUM(profit), 2) AS profit
FROM samplesuperstore
GROUP BY category
ORDER BY profit DESC;

/* =====================================================
   SECTION 20 — REVENUE BY SUB-CATEGORY
   Focus: Which sub-categories drive the most sales?
   ===================================================== */

SELECT
    sub_category,
    ROUND(SUM(sales), 2) AS revenue
FROM samplesuperstore
GROUP BY sub_category
ORDER BY revenue DESC;

/* =====================================================
   SECTION 21 — PROFIT BY SUB-CATEGORY
   Focus: Which sub-categories are most and least profitable?
   ===================================================== */

SELECT
    sub_category,
    ROUND(SUM(profit), 2) AS profit
FROM samplesuperstore
GROUP BY sub_category
ORDER BY profit DESC;

/* =====================================================
   SECTION 22 — TOP 10 CUSTOMERS BY REVENUE
   Focus: Which customers generated the most revenue?
   ===================================================== */

SELECT
    customer_name,
    ROUND(SUM(sales), 2) AS revenue
FROM samplesuperstore
GROUP BY customer_name
ORDER BY revenue DESC
LIMIT 10;

/* =====================================================
   SECTION 23 — AVERAGE ORDER VALUE
   Focus: What is the average revenue per order?
   ===================================================== */

SELECT
    ROUND(SUM(sales) / COUNT(DISTINCT order_id), 2) AS average_order_value
FROM samplesuperstore;

/* =====================================================
   SECTION 24 — RUNNING REVENUE TOTAL
   Objective: Shows cumulative sales over time.
   ===================================================== */

SELECT
    order_date,
    sales,
    ROUND(SUM(sales) OVER (ORDER BY order_date), 2) AS running_revenue_total
FROM samplesuperstore
ORDER BY order_date;

/* =====================================================
   SECTION 25 — PRODUCT PROFIT RANKING
   Objective: Ranks products by total profit.
   ===================================================== */

SELECT
    product_name,
    ROUND(SUM(profit), 2) AS total_profit,
    RANK() OVER (ORDER BY SUM(profit) DESC) AS profit_rank
FROM samplesuperstore
GROUP BY product_name
ORDER BY profit_rank;