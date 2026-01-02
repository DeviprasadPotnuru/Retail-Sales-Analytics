CREATE DATABASE retail_sales_analytics;
USE retail_sales_analytics;
CREATE TABLE retail_orders (
    order_id            VARCHAR(50),
    order_date          DATE,
    order_year          INT,
    order_month         INT,
    order_month_name    VARCHAR(20),

    ship_mode           VARCHAR(50),
    segment             VARCHAR(50),

    country             VARCHAR(50),
    city                VARCHAR(50),
    state               VARCHAR(50),
    postal_code         INT,
    region              VARCHAR(50),

    category             VARCHAR(50),
    sub_category         VARCHAR(50),
    product_id           VARCHAR(50),

    quantity             INT,
    list_price           DECIMAL(10,2),
    discount_percent     DECIMAL(5,2),
    selling_price        DECIMAL(10,2),
    sales                DECIMAL(12,2),
    total_cost           DECIMAL(12,2),
    profit               DECIMAL(12,2),
    profit_margin_pct    DECIMAL(6,2)
);
USE retail_sales_analytics;

SELECT COUNT(*) FROM retail_orders;

USE retail_sales_analytics;

SELECT COUNT(*) AS total_orders FROM retail_orders;

SELECT 
    MIN(order_date) AS first_order,
    MAX(order_date) AS last_order
FROM retail_orders;

SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM retail_orders;

SELECT
    category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM retail_orders
GROUP BY category
ORDER BY total_sales DESC;  

SELECT
    category,
    sub_category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM retail_orders
GROUP BY category, sub_category
ORDER BY total_profit ASC;

SELECT
    region,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM retail_orders
GROUP BY region
ORDER BY total_sales DESC;

SELECT
    region,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM retail_orders
GROUP BY region
ORDER BY total_sales DESC;

SELECT SUM(sales) AS total_sales
FROM retail_orders;

SELECT COUNT(DISTINCT order_id) AS total_orders
FROM retail_orders;

SELECT 
    ROUND(SUM(sales) / COUNT(DISTINCT order_id), 2) AS avg_order_value
FROM retail_orders;  

SELECT SUM(profit) AS total_profit
FROM retail_orders;  

SELECT 
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM retail_orders;

SELECT
    category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM retail_orders
GROUP BY category;

SELECT
    category,
    sub_category,
    SUM(profit) AS total_profit
FROM retail_orders
GROUP BY category, sub_category
HAVING SUM(profit) < 0
ORDER BY total_profit;

SELECT
    region,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM retail_orders
GROUP BY region;

SELECT
    discount_percent,
    COUNT(*) AS order_count,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM retail_orders
GROUP BY discount_percent
ORDER BY discount_percent;










