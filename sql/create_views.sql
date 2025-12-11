/*
============================================
Create Views Script
============================================
Script Purpose:
    This is a script in SQL that uses our data warehouse 
    and star schema to create views for analysis that will
    be used for our Dashboards in Tableau.
============================================
*/

-- Top Product Categories
CREATE VIEW top_product_types AS 
SELECT
	p.product_type,
	SUM(o.price * o.quantity) AS profit
FROM dim_product AS p
LEFT JOIN fact_order as o
ON p.product_reference_number = o.order_reference_number
GROUP BY p.product_type
ORDER BY profit DESC;

-- Top Revenue by Merchant Country
CREATE VIEW top_revenue_country AS
SELECT
	m.merchant_country,
	ROUND(SUM(o.quantity * o.price)::double precision:: numeric,2) AS profit
FROM dim_merchant AS m
LEFT JOIN fact_order AS o
ON o.merchant_reference_number = m.merchant_reference_number
GROUP BY m.merchant_country
ORDER BY profit DESC;

-- Sales Trend
CREATE VIEW sales_trend AS
SELECT
	transaction_date,
	SUM(quantity * price) AS profit
FROM fact_order
GROUP BY transaction_date
ORDER BY profit DESC;

-- Performance By Staff
CREATE VIEW staff_performance AS
SELECT 
	staff_name,
	COUNT(o.staff_reference_number) AS Number_Orders
FROM dim_staff AS s
LEFT JOIN fact_order AS o
ON s.staff_reference_number = o.staff_reference_number
GROUP BY staff_name
ORDER BY Number_Orders DESC;

-- Campaign Profit
CREATE VIEW campaign_profit AS
SELECT 
	c.campaign_id,
	SUM(o.quantity * o.price) AS profit
FROM dim_campaign AS c
LEFT JOIN fact_order AS o
ON o.campaign_reference_number = c.campaign_reference_number
WHERE o.availed LIKE 'Availed'
GROUP BY c.campaign_id
ORDER BY profit DESC;

-- Order by User Country Data
CREATE VIEW order_by_country_user AS
SELECT
	u.user_country AS country,
	COUNT(o.user_reference_number) AS count_orders
FROM dim_user AS u
LEFT JOIN fact_order AS o
ON u.user_reference_number = o.user_reference_number
GROUP BY country
ORDER BY count_orders DESC;

