"""
============================================
Merging Data
============================================
Script Purpose:
   This is a SQL script that uses the UNION operator to combine the data 
   that is seperated in 2 or more tables into one.
============================================
"""

CREATE VIEW merchant_with_order_data AS 
SELECT 
	order_id,
	merchant_id,
	staff_id
FROM order_with_merchant_data1 
UNION
SELECT 
	order_id,
	merchant_id,
	staff_id
FROM order_with_merchant_data2
UNION
SELECT 
	order_id,
	merchant_id,
	staff_id
FROM order_with_merchant_data3;

CREATE VIEW line_item_data_prices AS
SELECT 
	order_id, 
	price,
	quantity,
FROM line_item_data_prices1
UNION
SELECT
order_id, 
	price,
	quantity,
FROM line_item_data_prices2
UNION
SELECT
order_id, 
	price,
	quantity,
FROM line_item_data_prices3;

CREATE VIEW line_item_data_products AS
SELECT
	order_id,
	product_name,
	product_id
FROM line_item_data_products1
UNION
SELECT
	order_id,
	product_name,
	product_id
FROM line_item_data_products2
UNION
SELECT
	order_id,
	product_name,
	product_id
FROM line_item_data_products3;

CREATE VIEW order_data AS
SELECT 
	order_id,
	user_id,
	"estimated arrival" AS estimated_arrival,
	transaction_date
FROM order_data_20200101_20200701
UNION
SELECT 
	order_id,
	user_id,
	"estimated arrival" AS estimated_arrival,
	transaction_date
FROM order_data_20200701_20211001
UNION
SELECT 
	order_id,
	user_id,
	"estimated arrival" AS estimated_arrival,
	transaction_date
FROM order_data_20211001_20220101
UNION
SELECT 
	order_id,
	user_id,
	"estimated arrival" AS estimated_arrival,
	transaction_date
FROM order_data_20220101_20221201
UNION 
SELECT 
	order_id,
	user_id,
	"estimated arrival" AS estimated_arrival,
	transaction_date
FROM order_data_20221201_20230601
UNION
SELECT 
	order_id,
	user_id,
	"estimated arrival" AS estimated_arrival,
	transaction_date
FROM order_data_20230601_20240101;

