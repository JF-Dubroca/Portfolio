-- Dimension
SELECT COUNT(*) FROM {{ source('raw', 'customer')}}
-- 99441 lines

-- Looking for Null
SELECT
    COUNTIF(customer_id IS NULL) AS null_custormer_id,
    COUNTIF(customer_unique_id IS NULL) AS null_customer_unique_id,
    COUNTIF(customer_zip_code_prefix IS NULL) AS null_customer_zip_code_prefix, 
    COUNTIF(customer_city IS NULL) AS null_customer_city, 
    COUNTIF(customer_state IS NULL) AS null_customer_state
FROM {{source ('raw', 'customer')}}
-- 0 Null detected

-- Looking for duplicates
SELECT 
    *, 
    COUNT(*) AS number
FROM {{source ('raw', 'customer')}}
GROUP BY ALL
HAVING NUMBER > 1

SELECT 
    customer_id, 
    customer_unique_id, 
    COUNT (*) AS number
FROM {{source ('raw', 'customer')}}
GROUP BY  customer_id, customer_unique_id
HAVING number > 1
-- 0 duplicates detected

-- Primary key
SELECT 
    COUNT (*) AS total_raw, 
    COUNT(DISTINCT (customer_id)) AS distinct_customer_id_number, 
    COUNT(DISTINCT(customer_unique_id)) AS distinct_customer_unique_id_number, 
    COUNT(DISTINCT (customer_id, customer_unique_id)) AS both_number
FROM {{source ('raw', 'customer')}}
-- Primary key = customer_id

-- customer_zip_code_prefix extrems values
SELECT 
    MAX(customer_zip_code_prefix) AS max_customer_zip_code_prefix, 
    MIN(customer_zip_code_prefix) AS min_customer_zip_code_prefix
FROM {{source ('raw', 'customer')}}
-- max_customer_zip_code_prefix = 99990
-- min_customer_zip_code_prefix = 1003
-- No aberrant value

-- customer_state exploration
SELECT DISTINCT(customer_state) FROM {{source ('raw', 'customer')}}
SELECT MAX(LEN(customer_state)) AS max_lenght FROM {{source ('raw', 'customer')}}
-- 27 unique values, max lenght = 2

-- Does customer_zip_code_prefix, customer_city and customer_state should be limited in characters? 