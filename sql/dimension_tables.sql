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

ALTER TABLE dim_user 
	ADD CONSTRAINT dim_user_pk PRIMARY KEY (user_reference_number),
	ALTER COLUMN user_reference_number SET NOT NULL,
	ALTER COLUMN user_id SET NOT NULL;

CREATE TABLE dim_product AS
SELECT 
	ROW_NUMBER() OVER (ORDER BY product_id) AS product_reference_number,
  product_id, 
  product_name, 
  product_type
FROM product_list;

ALTER TABLE dim_product 
	ADD CONSTRAINT dim_product_pk PRIMARY KEY (product_reference_number),
	ALTER COLUMN product_reference_number SET NOT NULL,
	ALTER COLUMN product_id SET NOT NULL;

INSERT INTO dim_product
VALUES (-1, 'PRODUCT00000', 'No Product', 'No Product');

CREATE TABLE dim_campaign AS
SELECT 
	ROW_NUMBER() OVER (ORDER BY campaign_id) AS campaign_reference_number,
  campaign_id,
  campaign_name,
  campaign_description,
  discount AS campaign_discount
FROM campaign_data;

ALTER TABLE dim_campaign 
	ADD CONSTRAINT dim_campaign_pk PRIMARY KEY (campaign_reference_number),
	ALTER COLUMN campaign_reference_number SET NOT NULL,
	ALTER COLUMN campaign_id SET NOT NULL;

INSERT INTO dim_campaign
VALUES (-1, 'CAMPAIGN00000', 'No Campaign', 'No Campaign', '0.0');

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

ALTER TABLE dim_merchant
	ADD CONSTRAINT dim_merchant_pk PRIMARY KEY (merchant_reference_number),
	ALTER COLUMN merchant_reference_number SET NOT NULL,
	ALTER COLUMN merchant_id SET NOT NULL;

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

ALTER TABLE dim_staff
	ADD CONSTRAINT dim_staff_pk PRIMARY KEY (staff_reference_number),
	ALTER COLUMN staff_reference_number SET NOT NULL,
	ALTER COLUMN staff_id SET NOT NULL;




	


