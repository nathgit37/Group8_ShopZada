"""
============================================
Creating the Facts Table
============================================
Script Purpose:
    This is a SQL script that creates the tables for our 
    Facts table based on our outline utilizing joins and
    ensuring no null values are in the Fact Table.
============================================
"""

CREATE TABLE fact_order AS
SELECT
	ROW_NUMBER () OVER (ORDER BY o.order_id) AS order_reference_number,
	u.user_reference_number,
	CASE 
		WHEN product.product_reference_number IS NULL
		THEN -1
		ELSE product.product_reference_number END AS product_reference_number,
	CASE 
		WHEN campaign.campaign_reference_number IS NULL 
		THEN -1 
		ELSE campaign.campaign_reference_number END AS campaign_reference_number,
	staff.staff_reference_number,
	merchant.merchant_reference_number,
	o.order_id,
	o.estimated_arrival, 
	o.transaction_date,
	COALESCE(l1.price, 0) AS price,
	COALESCE(l1.quantity, 0) AS quantity,
	COALESCE(d."delay in days", 0) AS delay_in_days,
	CASE
		WHEN t.availed = 1 
		THEN 'Availed'
		WHEN t.availed = 0
		THEN 'Not Availed'
		ELSE 'Not Applicable' END as availed
FROM order_data AS o
LEFT JOIN line_item_data_prices AS l1	
		ON o.order_id = l1.order_id
LEFT JOIN line_item_data_products AS l2
		ON o.order_id = l2.order_id
LEFT JOIN order_delays AS d
		ON o.order_id = d.order_id
LEFT JOIN transactional_campaign_data AS t
		ON o.order_id = t.order_id
LEFT JOIN dim_user AS u
		ON o.user_id = u.user_id
LEFT JOIN dim_product AS product
		ON l2.product_id = product.product_id
LEFT JOIN dim_campaign AS campaign
		ON t.campaign_id = campaign.campaign_id 
LEFT JOIN merchant_with_order_data AS oms
		ON o.order_id = oms.order_id
LEFT JOIN dim_staff AS staff
		ON oms.staff_id = staff.staff_id
LEFT JOIN dim_merchant AS merchant
		ON oms.merchant_id = merchant.merchant_id;

ALTER TABLE fact_order
	ADD CONSTRAINT fact_order_pk PRIMARY KEY (order_reference_number);

ALTER TABLE fact_order
	ALTER COLUMN order_reference_number SET NOT NULL,
	ALTER COLUMN user_reference_number SET NOT NULL,
	ALTER COLUMN campaign_reference_number SET NOT NULL,
	ALTER COLUMN staff_reference_number SET NOT NULL,
	ALTER COLUMN product_reference_number SET NOT NULL,
	ALTER COLUMN merchant_reference_number SET NOT NULL,
	ALTER COLUMN order_id SET NOT NULL,
	ALTER COLUMN transaction_date SET NOT NULL,
	ALTER COLUMN price SET NOT NULL,
	ALTER COLUMN quantity SET NOT NULL;

ALTER TABLE fact_order
	ALTER TABLE fact_order
	ADD CONSTRAINT fk_fact_order_user
	FOREIGN KEY (user_reference_number) REFERENCES dim_user (user_reference_number),

	ADD CONSTRAINT fk_fact_order_product
	FOREIGN KEY (product_reference_number) REFERENCES dim_product (product_reference_number),

	ADD CONSTRAINT fk_fact_order_campaign
	FOREIGN KEY (campaign_reference_number) REFERENCES dim_campaign (campaign_reference_number),

	ADD CONSTRAINT fk_fact_order_staff
	FOREIGN KEY (staff_reference_number) REFERENCES dim_staff (staff_reference_number),

	ADD CONSTRAINT fk_fact_order_merchant
	FOREIGN KEY (merchant_reference_number) REFERENCES dim_merchant (merchant_reference_number);

