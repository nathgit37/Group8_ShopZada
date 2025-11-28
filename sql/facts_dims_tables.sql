"""
============================================
Creating the Facts and Dimensions Tables
============================================
Script Purpose:
    This is a SQL script that creates the tables for our 
    Facts and Dimension tables based on our outline.
============================================
"""

CREATE TABLE dim_user AS
SELECT 
  ROW_NUMBER() OVER (ORDER BY u1.user_id) AS user_reference_number,
  u1.user_id, 
  u1.creation_date AS user_creation_date, 
  u1.name AS user_name , 
  u1.street AS user_street,
  u1.city AS user_city, 
  u1.state AS user_state,
  u1.country AS user_country, 
  u1.birthdate AS user_birthdate, 
  u1.gender AS user_gender,
  u1.device_address AS user_device_address,
  u1.user_type AS user_membership_type,
  u2.job_title AS user_job_title,
  u2.job_level AS user_job_level,
  u3.credit_card_number AS user_credit_card_number,
  u3.issuing_bank AS user_issuing_bank
FROM user_data AS u1
LEFT JOIN user_job AS u2
          ON u1.user_id = u2.user_id
LEFT JOIN user_credit_card AS u3
          ON u1.user_id = u3.user_id;

CREATE TABLE dim_product AS
SELECT 
	ROW_NUMBER() OVER (ORDER BY product_id) AS product_reference_number,
  product_id, 
  product_name, 
  product_type
FROM product_list;

CREATE TABLE dim_campaign AS
SELECT 
	ROW_NUMBER() OVER (ORDER BY campaign_id) AS campaign_reference_number,
  campaign_id,
  campaign_name,
  campaign_description,
  discount AS campaign_discount
FROM campaign_data;

CREATE TABLE dim_merchant AS
SELECT
	ROW_NUMBER () OVER (ORDER BY merchant_id) AS merchant_reference_number,
	merchant_id,
	name AS merchant_name,
	street AS merchant_street,
	city AS merchant_city,
	state AS merchant_state,
	country AS merchant_country,
	contact_number AS merchant_contact_number,
	creation_date AS merchant_creation_date
FROM merchant_data;

CREATE TABLE dim_staff AS 
SELECT
	ROW_NUMBER () OVER (ORDER BY staff_id) AS staff_reference_number, 
	staff_id,
	name AS staff_name,
	job_level AS staff_job_level,
	street AS staff_street,
	city AS staff_city,
	state AS staff_state, 
	country AS staff_country,
	contact_number AS staff_contact_number,
	creation_date AS staff_creation_date
FROM staff_data;

CREATE TABLE fact_order AS
SELECT
	ROW_NUMBER () OVER (ORDER BY o.order_id) AS order_reference_number,
	u.user_reference_number,
	product.product_reference_number,
	campaign.campaign_reference_number,
	staff.staff_reference_number,
	merchant.merchant_reference_number,
	o.order_id,
	o.estimated_arrival, 
	o.transaction_date,
	l1.price,
	l1.quantity,
	d."delay in days",
	t.availed 
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


	


