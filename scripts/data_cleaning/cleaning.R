"""
============================================
Data Cleaning Script
============================================
Script Purpose:
    This is an R script that connects to PostgreSQL, accesses the tables and
    transforms the data using dplyr and other similar libraries in R. It 
    Then, it overwrites the tables in Postgres with the transformed data.
============================================
"""

#Install Packages ====
library(stringr)
library(DBI)
library(RPostgres)
library(dplyr)
library(tidyverse)
library(tidyr)
library(janitor)
library(lubridate)

# Connect R to db ====
con <- dbConnect(
  RPostgres::Postgres(),
  dbname = "airflow",
  host = "postgres",
  port = 5432,
  user = "airflow",
  password = "airflow"
)

dbListTables(con)
print("Connected to Postgres starting to clean the departments...")


#CUSTOMER DEPARTMENT ====
user_data <- dbGetQuery(con, "SELECT * FROM user_data;")
user_credit_card <- dbGetQuery(con, "SELECT * FROM user_credit_card;")
user_job <- dbGetQuery(con, "SELECT * FROM user_job;")

#Replacing null with a value and removing column named "Unnamed:0"
user_job <- user_job %>%
  select(-`Unnamed: 0`) %>%
  mutate(job_level = replace_na(job_level, "Student"))
  
#Correcting data types
user_data$creation_date <- ymd_hms(user_data$creation_date)
user_data$creation_date <- as_date(user_data$creation_date)
user_data$user_type <- as.factor(user_data$user_type)

print("Customer Department has been cleaned!"

#OPERATIONS DEPARTMENT ====
line_item_data_prices1 <- dbGetQuery(con, "SELECT * FROM line_item_data_prices1;")
line_item_data_prices2 <- dbGetQuery(con, "SELECT * FROM line_item_data_prices2;")
line_item_data_prices3 <- dbGetQuery(con, "SELECT * FROM line_item_data_prices3;")
line_item_data_products1 <- dbGetQuery(con, "SELECT * FROM line_item_data_products1;")
line_item_data_products2 <- dbGetQuery(con, "SELECT * FROM line_item_data_products2;")
line_item_data_products3 <- dbGetQuery(con, "SELECT * FROM line_item_data_products3;")
order_data_20200101_20200701 <- dbGetQuery(con, "SELECT * FROM order_data_20200101_20200701;")
order_data_20200701_20211001 <- dbGetQuery(con, "SELECT * FROM order_data_20200701_20211001;")
order_data_20211001_20220101 <- dbGetQuery(con, "SELECT * FROM order_data_20211001_20220101;")
order_data_20220101_20221201 <- dbGetQuery(con, "SELECT * FROM order_data_20220101_20221201;")
order_data_20221201_20230601 <- dbGetQuery(con, "SELECT * FROM order_data_20221201_20230601;")
order_data_20230601_20240101 <- dbGetQuery(con, "SELECT * FROM order_data_20230601_20240101;")
order_delays <- dbGetQuery(con, "SELECT * FROM order_delays;")

#Remove the word "days"
order_data_20200101_20200701 <- order_data_20200101_20200701 %>%
  mutate(estimated arrival = estimated arrival %>%
           gsub("days?|Days?", "", .) %>%
           trimws() %>%
           as.numeric())

order_data_20200701_20211001 <- order_data_20200701_20211001 %>%
  mutate(estimated arrival = estimated arrival %>%
           gsub("days?|Days?", "", .) %>%
           trimws() %>%
           as.numeric())

order_data_20211001_20220101 <- order_data_20211001_20220101 %>%
  mutate(estimated arrival = estimated arrival %>%
           gsub("days?|Days?", "", .) %>%
           trimws() %>%
           as.numeric())

order_data_20220101_20221201 <- order_data_20220101_20221201 %>%
  mutate(estimated arrival = estimated arrival %>%
           gsub("days?|Days?", "", .) %>%
           trimws() %>%
           as.numeric())

order_data_20221201_20230601 <- order_data_20221201_20230601 %>%
  mutate(estimated arrival = estimated arrival %>%
           gsub("days?|Days?", "", .) %>%
           trimws() %>%
           as.numeric())

order_data_20230601_20240101 <- order_data_20230601_20240101 %>%
  mutate(estimated arrival = estimated arrival %>%
           gsub("days?|Days?", "", .) %>%
           trimws() %>%
           as.numeric())

#remove unnamed:0 column
order_delays <- order_delays %>%
  select(-`Unnamed: 0`)

order_data_20211001_20220101 <- order_data_20211001_20220101 %>%
  select(-`Unnamed: 0`)

order_data_20220101_20221201 <- order_data_20220101_20221201 %>%
  select(-`Unnamed: 0`)

order_data_20230601_20240101 <- order_data_20230601_20240101 %>%
  select(-`Unnamed: 0`)

line_item_data_prices1 <- line_item_data_prices1 %>%
  select(-`Unnamed: 0`)

line_item_data_prices2 <- line_item_data_prices2 %>%
  select(-`Unnamed: 0`)

line_item_data_prices3 <- line_item_data_prices3 %>%
  select(-`Unnamed: 0`)

line_item_data_products1 <- line_item_data_products1 %>%
  select(-`Unnamed: 0`)

line_item_data_products2 <- line_item_data_products2 %>%
  select(-`Unnamed: 0`)

line_item_data_products3 <- line_item_data_products3 %>%
  select(-`Unnamed: 0`)

#Removing duplicates and null rows
line_item_data_prices1 <- line_item_data_prices1 %>%
  drop_na() %>% 
  distinct()

line_item_data_prices2 <- line_item_data_prices2 %>%
  drop_na() %>% 
  distinct()

line_item_data_products1 <- line_item_data_products1 %>%
  drop_na() %>% 
  distinct()

line_item_data_products2 <- line_item_data_products2 %>%
  drop_na() %>% 
  distinct()

line_item_data_products3 <- line_item_data_products3 %>%
  drop_na() %>% 
  distinct()

order_data_20200101_20200701 <- order_data_20200101_20200701 %>%
  drop_na() %>% 
  distinct()

order_data_20200701_20211001 <- order_data_20200701_20211001 %>%
  drop_na() %>% 
  distinct()

order_data_20211001_20220101 <- order_data_20211001_20220101 %>%
  drop_na() %>% 
  distinct()

order_data_20220101_20221201 <- order_data_20220101_20221201 %>%
  drop_na() %>% 
  distinct()

order_data_20221201_20230601 <- order_data_20221201_20230601 %>%
  drop_na() %>% 
  distinct()

order_data_20230601_20240101 <- order_data_20230601_20240101 %>%
  drop_na() %>% 
  distinct()

#removing the pcs word
line_item_data_prices1 <- line_item_data_prices1 %>%
  mutate(quantity = str_extract(quantity, "\\d+")) %>%
  mutate(quantity = as.numeric(quantity))   

line_item_data_prices2 <- line_item_data_prices2 %>%
  mutate(quantity = str_extract(quantity, "\\d+")) %>%
  mutate(quantity = as.numeric(quantity))  

line_item_data_prices3 <- line_item_data_prices3 %>%
  mutate(quantity = str_extract(quantity, "\\d+")) %>%
  mutate(quantity = as.numeric(quantity)) 

# Correcting Data Types
order_data_20200101_20200701$transaction_date <- ymd(order_data_20200101_20200701$transaction_date)
order_data_20200701_20211001$transaction_date <- ymd(order_data_20200701_20211001$transaction_date)
order_data_20211001_20220101$transaction_date <- ymd(order_data_20211001_20220101$transaction_date)
order_data_20220101_20221201$transaction_date <- ymd(order_data_20220101_20221201$transaction_date)
order_data_20221201_20230601$transaction_date <- ymd(order_data_20221201_20230601$transaction_date)
order_data_20230601_20240101$transaction_date <- ymd(order_data_20230601_20240101$transaction_date)

print("Operations Department has been cleaned!")

#MARKETING DEPARTMENT ====
campaign_data <- dbGetQuery(con, "SELECT * FROM campaign_data;")
transactional_campaign_data <- dbGetQuery(con, "SELECT * FROM transactional_campaign_data;")

#Removing column named "Unnamed:0"
transactional_campaign_data <- transactional_campaign_data %>%
  select(-`Unnamed: 0`)
campaign_data <- campaign_data %>%
  select(-`Unnamed: 0`)

#Removing the word "days" from estimated arrival column
transactional_campaign_data <- transactional_campaign_data %>%
  mutate(estimated arrival = estimated arrival %>%
           gsub("days?|Days?", "", .) %>%
           trimws() %>%
           as.numeric())

#Cleaning the discount column
campaign_data <- campaign_data %>%
  mutate(
    discount = as.numeric(
      str_replace_all(
        string = discount, 
        pattern = regex("(pct|%|percent)", ignore_case = TRUE), 
        replacement = ""
      )
    ) / 100 
  )

# Correcting the data types
transactional_campaign_data$transaction_date <- ymd(transactional_campaign_data$transaction_date)
transactional_campaign_data$transaction_date <- as.factor(transactional_campaign_data$transaction_date)

print("Marketing Department has been cleaned!")


#ENTERPRISE DEPARTMENT ====
merchant_data <- dbGetQuery(con, "SELECT * FROM merchant_data;")
order_with_merchant_data1 <- dbGetQuery(con, "SELECT * FROM order_with_merchant_data1;")
order_with_merchant_data2 <- dbGetQuery(con, "SELECT * FROM order_with_merchant_data2;")
order_with_merchant_data3 <- dbGetQuery(con, "SELECT * FROM order_with_merchant_data3;")
staff_data <- dbGetQuery(con, "SELECT * FROM staff_data;")

#remove column named "unnamed:0"
staff_data <- staff_data %>%
  select(-`Unnamed: 0`)

merchant_data <- merchant_data %>%
  select(-`Unnamed: 0`)

order_with_merchant_data3 <- order_with_merchant_data3 %>%
  select(-`Unnamed: 0`)

#Cleaning staff table
staff_data <- staff_data %>% 
  select(everything()) %>% 
  mutate(contact_number = str_replace_all(contact_number, "[^0-9]", ""),
         contact_number = ifelse(
           nchar(contact_number) == 11 & str_starts(contact_number, "1"),
           str_sub(contact_number, start = 2), # Start from the second character
           contact_number
         ),
         contact_number = str_replace(
           contact_number, 
           "^(\\d{3})(\\d{3})(\\d{4})$", 
           "(\\1) \\2-\\3"
         )
  )

#Cleaning merchant table
merchant_data <- merchant_data %>% 
  select(everything()) %>% 
  mutate(contact_number = str_replace_all(contact_number, "[^0-9]", ""),
         contact_number = ifelse(
           nchar(contact_number) == 11 & str_starts(contact_number, "1"),
           str_sub(contact_number, start = 2), # Start from the second character
           contact_number
         ),
         contact_number = str_replace(
           contact_number, 
           "^(\\d{3})(\\d{3})(\\d{4})$", 
           "(\\1) \\2-\\3"
         )
  )

#Correcting data types
merchant_data$creation_date <- ymd_hms(merchant_data$creation_date)
merchant_data$creation_date <- as_date(merchant_data$creation_date)
staff_data$creation_date <- ymd_hms(staff_data$creation_date)
staff_data$creation_date <- as_date(staff_data$creation_date)

print("Enterprise Department has been cleaned!")

#BUSINESS DEPARTMENT ====
product_list <- dbGetQuery(con, "SELECT * FROM product_list;")

#Removing column named "unnamed:0"
product_list <- product_list %>%
  select(-`Unnamed: 0`)

#Editing the values
product_list <- product_list %>%
  select(product_id, product_name, product_type, price) %>%
  mutate(product_type = replace_na(product_type, "others")) %>% 
  mutate(product_type = case_when(
    product_type == "toolss" ~ "tools",
    product_type == "stationary" ~ "stationary and school supplies",
    product_type == "school supplies" ~ "stationary and school supplies",
    product_type == "cosmetic" ~ "cosmetics",
    product_type == "technology" ~ "electronics and technology",
    product_type == "readymade_breakfast" ~ "readymade_food",
    product_type == "readymade_lunch" ~ "readymade_food",
    product_type == "readymade_dinner" ~ "readymade_food",
    TRUE ~ product_type)
  )

print("Business Department has been cleaned!")

#
# PUTTING IT BACK INTO POSTGRE ====
#Marketing Department
dbWriteTable(con, "campaign_data", campaign_data, overwrite = TRUE)
dbWriteTable(con, "transactional_campaign_data", transactional_campaign_data, overwrite = TRUE)

#Business Department
dbWriteTable(con, "product_list", product_list, overwrite = TRUE)

#Enterprise Department
dbWriteTable(con, "merchant_data", merchant_data, overwrite = TRUE)
dbWriteTable(con, "staff_data", staff_data, overwrite = TRUE)
dbWriteTable(con, "order_with_merchant_data1", order_with_merchant_data1, overwrite = TRUE)
dbWriteTable(con, "order_with_merchant_data2", order_with_merchant_data2, overwrite = TRUE)
dbWriteTable(con, "order_with_merchant_data3", order_with_merchant_data3, overwrite = TRUE)

#Customer Department
dbWriteTable(con, "user_data", user_data, overwrite = TRUE)
dbWriteTable(con, "user_credit_card", user_credit_card, overwrite = TRUE)
dbWriteTable(con, "user_job", user_job, overwrite = TRUE)

#Operations Department
dbWriteTable(con, "line_item_data_prices1", line_item_data_prices1, overwrite = TRUE)
dbWriteTable(con, "line_item_data_prices2", line_item_data_prices2, overwrite = TRUE)
dbWriteTable(con, "line_item_data_prices3", line_item_data_prices3, overwrite = TRUE)
dbWriteTable(con, "line_item_data_products1", line_item_data_products1, overwrite = TRUE)
dbWriteTable(con, "line_item_data_products2", line_item_data_products2, overwrite = TRUE)
dbWriteTable(con, "line_item_data_products3", line_item_data_products3, overwrite = TRUE)
dbWriteTable(con, "order_data_20200101_20200701", order_data_20200101_20200701, overwrite = TRUE)
dbWriteTable(con, "order_data_20200701_20211001", order_data_20200701_20211001, overwrite = TRUE)
dbWriteTable(con, "order_data_20211001_20220101", order_data_20211001_20220101, overwrite = TRUE)
dbWriteTable(con, "order_data_20220101_20221201", order_data_20220101_20221201, overwrite = TRUE)
dbWriteTable(con, "order_data_20221201_20230601", order_data_20221201_20230601, overwrite = TRUE)
dbWriteTable(con, "order_data_20230601_20240101", order_data_20230601_20240101, overwrite = TRUE)
dbWriteTable(con, "order_delays", order_delays, overwrite = TRUE)
print("Departments successfully ingested back to Postgre!")
