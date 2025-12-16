# Part 3: Data Dictionary

## 1. FACT_ORDER

- **Purpose:** Stores transactional order data and connects to all related dimension tables.
- **Columns:**

| Column Name | Data Type | Description |
|------------|----------|-------------|
| order_reference_number | BIGINT | Surrogate key. |
| product_reference_number | BIGINT | A foreign key that connects the fact table to the related DIM_PRODUCT product. |
| campaign_reference_number | BIGINT | A foreign key that connects the fact table to the related DIM_CAMPAIGN product. |
| staff_reference_number | BIGINT | A foreign key that connects the fact table to the related DIM_STAFF product. |
| merchant_reference_number | BIGINT | A foreign key that connects the fact table to the related DIM_MERCHANT product. |
| user_reference_number | BIGINT | A foreign key that connects the fact table to the related DIM_USER product. |
| order_id | TEXT | The source system's original order ID. |
| order_date | DATE | Date when the order was placed. |
| quantity | DOUBLE PRECISION | Date of when the order was placed. |
| price | DOUBLE PRECISION | Price per item. |
| estimated_arrival | DOUBLE PRECISION | How long the delivery was delayed. |
| delay_in_days | BIGINT | How long the delivery was delayed. |
| availed | TEXT | If the order availed at that campaign. |
| transaction_date | DATE | When the transaction was made. |

---

## 2. DIM_PRODUCT

- **Purpose:** Stores descriptive information about products.
- **Columns:**

| Column Name | Data Type | Description |
|------------|----------|-------------|
| product_reference_number | BIGINT | Unique product surrogate key. |
| product_id | TEXT | Original product ID. |
| product_name | TEXT | Name of the product. |
| product_type | TEXT | Kind of the product. |

---

## 3. DIM_CAMPAIGN

- **Purpose:** Stores marketing campaign information.
- **Columns:**

| Column Name | Data Type | Description |
|------------|----------|-------------|
| campaign_reference_number | BIGINT | Unique campaign surrogate key. |
| campaign_id | TEXT | Original campaign ID. |
| campaign_name | TEXT | Name of the campaign. |
| campaign_description | TEXT | Details of the campaign. |
| campaign_discount | DOUBLE PRECISION | Amount of the discount. |

---

## 4. DIM_STAFF

- **Purpose:** Stores staff-related information for operational tracking.
- **Columns:**

| Column Name | Data Type | Description |
|------------|----------|-------------|
| staff_reference_number | BIGINT | Unique staff surrogate key. |
| staff_id | TEXT | Original staff ID. |
| staff_name | TEXT | Name of the staff member. |
| staff_job_level | TEXT | Position of the employee. |
| staff_street | TEXT | The specific street address of the employee. |
| staff_state | TEXT | State of the employee. |
| staff_city | TEXT | City of the employee. |
| staff_country | TEXT | Country of the employee. |
| staff_contact_number | TEXT | Contact number of the employee. |
| staff_creation_date | DATE | Record of when the staff made an account. |

---

## 5. DIM_MERCHANT

- **Purpose:** Stores merchant information related to transactions.
- **Columns:**

| Column Name | Data Type | Description |
|------------|----------|-------------|
| merchant_reference_number | BIGINT | Unique merchant surrogate key. |
| merchant_id | TEXT | Original merchant ID. |
| merchant_name | TEXT | Name of the merchant. |
| merchant_state | TEXT | State of the merchant. |
| merchant_street | TEXT | Street address of the merchant. |
| merchant_city | TEXT | City of the merchant. |
| merchant_country | TEXT | Country of the merchant. |
| merchant_contact_number | TEXT | Contact number of the merchant. |
| merchant_creation_date | DATE | Record of when the user made an account. |

---

## 6. DIM_USER

- **Purpose:** Stores user demographic and account information.
- **Columns:**

| Column Name | Data Type | Description |
|------------|----------|-------------|
| user_reference_number | BIGINT | Unique user surrogate key. |
| user_id | TEXT | Original user ID. |
| user_name | TEXT | Full name of the user. |
| user_credit_card_number | BIGINT | Credit card number of the user. |
| user_issuing_bank | TEXT | Bank that issued the credit card. |
| user_job_title | TEXT | Job title of the user. |
| user_job_level | TEXT | Job rank of the user. |
| user_creation_date | DATE | Record of when the user made an account. |
| user_street | TEXT | Specific street address of the user. |
| user_state | TEXT | State of the user. |
| user_city | TEXT | City of the user. |
| user_country | TEXT | Country of the user. |
| user_birthdate | TEXT | Date and time of birth of the user. |
| user_gender | TEXT | Gender of the user. |
| user_device_address | TEXT | IP address of the user's device. |
| user_type | TEXT | Membership type of the user. |
