/*
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
    COUNT(*) AS duplicates_number
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

-- customer_zip_code_prefix extrems values
SELECT 
    MAX(customer_zip_code_prefix) AS max_customer_zip_code_prefix, 
    MIN(customer_zip_code_prefix) AS min_customer_zip_code_prefix
FROM `olist-e-commerce-analytics-jfd`.`raw`.`customer`
-- max_customer_zip_code_prefix = 99990
-- min_customer_zip_code_prefix = 1003
-- No aberrant value

-- customer_state exploration
SELECT DISTINCT(customer_state) FROM `olist-e-commerce-analytics-jfd`.`raw`.`customer`
SELECT MAX(LEN(customer_state)) AS max_lenght FROM `olist-e-commerce-analytics-jfd`.`raw`.`customer`
-- 27 unique values, max lenght = 2

-- What's the difference between customer_id and customer_unique_id? 
-- Retrieving customer_unique_id that appear mutiple times 
SELECT 
    customer_unique_id, 
    COUNT(*) AS occurence
FROM `olist-e-commerce-analytics-jfd`.`raw`.`customer` 
GROUP BY 1
HAVING occurence > 2
-- examination of some of these lines
SELECT *
FROM `olist-e-commerce-analytics-jfd`.`raw`.`customer`
WHERE customer_unique_id IN ('d75acd4c5b7b4dfd32b9d9172b195419', 
                            'f50ca6544a0ed8a52cc964e15cbe9cf9', 
                            'a1874c5550d2f0bc14cc122164603713', 
                            '738ffcf1017b584e9d2684b36e07469c',
                            '8cd6f80d3c3994e2060d46ec07ff0b0a')
ORDER BY customer_unique_id
-- customer_unique_id seems to be the real customer identifiant (same zip code, city and states)
-- as customer_id seems to be the order identifiant (many customer_id for one customer_unique_id)

-- Should customer_zip_code_prefix, customer_city and customer_state be limited in characters? 
*/