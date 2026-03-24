-- Dimension
SELECT COUNT(*) FROM `olist-e-commerce-analytics-jfd`.`raw`.`customer`
-- 99441 lines

-- Looking for Null
SELECT
    COUNTIF(customer_id IS NULL) AS null_custormer_id,
    COUNTIF(customer_unique_id IS NULL) AS null_customer_unique_id,
    COUNTIF(customer_zip_code_prefix IS NULL) AS null_customer_zip_code_prefix, 
    COUNTIF(customer_city IS NULL) AS null_customer_city, 
    COUNTIF(customer_state IS NULL) AS null_customer_state
FROM `olist-e-commerce-analytics-jfd`.`raw`.`customer`
-- 0 Null detected

-- Looking for duplicates
SELECT 
    *, 
    COUNT(*) AS number
FROM `olist-e-commerce-analytics-jfd`.`raw`.`customer`
GROUP BY ALL
HAVING NUMBER > 1

SELECT 
    customer_id, 
    customer_unique_id, 
    COUNT (*) AS number
FROM `olist-e-commerce-analytics-jfd`.`raw`.`customer`
GROUP BY  customer_id, customer_unique_id
HAVING number > 1
-- 0 duplicates detected

-- Primary key
SELECT 
    COUNT (*) AS total_raw, 
    COUNT(DISTINCT (customer_id)) AS distinct_customer_id_number, 
    COUNT(DISTINCT(customer_unique_id)) AS distinct_customer_unique_id_number, 
    COUNT(DISTINCT (customer_id, customer_unique_id)) AS both_number
FROM `olist-e-commerce-analytics-jfd`.`raw`.`customer`
-- Primary key = customer_id