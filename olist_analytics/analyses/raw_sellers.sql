/*
-- Dimensions
SELECT COUNT(*) FROM {{ source('raw', 'sellers')}}
-- 3095 rows

-- Looking for NULL
SELECT 
    COUNTIF(seller_id IS NULL) AS null_seller_id, 
    COUNTIF(seller_zip_code_prefix IS NULL) AS null_seller_zip_code_prefix, 
    COUNTIF(seller_city IS NULL) AS null_seller_city, 
    COUNTIF(seller_state IS NULL) AS null_seller_state
FROM {{ source('raw', 'sellers')}}
-- No NULL detected

-- Looking for duplicates
SELECT 
    *,
    COUNT(*) AS duplicates
FROM {{ source('raw', 'sellers')}}
GROUP BY ALL
HAVING duplicates > 1
-- 0 duplicates detected

-- Primary key
SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT(seller_id)) AS distinct_sellers 
FROM {{ source('raw', 'sellers')}}
-- Primary key = seller_id

-- Aberrants values 
SELECT
    MIN(LEN(seller_id)) AS min_len_seller_id, 
    MAX(LEN(seller_id)) AS max_len_seller_id,
    MIN(seller_zip_code_prefix) AS min_zip_code, 
    MAX(seller_zip_code_prefix) AS max_zip_code, 
    MIN(LEN(seller_city)) AS min_len_seller_city, 
    MAX(LEN(seller_city)) AS max_len_seller_city,
    MIN(LEN(seller_state)) AS min_len_seller_state, 
    MAX(LEN(seller_state)) AS max_len_seller_state,
FROM {{ source('raw', 'sellers')}}
/*
min_len_seller_id = 32
max_len_seller_id = 32
min_zip_code = 1001
max_zip_code = 99730
min_len_seller_city = 2
max_len_seller_city = 40
 min_len_seller_state = 2
 max_len_seller_state = 2
 */
 -- Looking for extrem values of seller city
 SELECT *
FROM {{ source('raw', 'sellers')}}
WHERE LEN(seller_city) = 2
    OR LEN(seller_city) = 40
/*
 - novo hamburgo, rio grande do sul, brasil
 - sp
 */
-- More exploration
SELECT *
FROM {{ source('raw', 'sellers')}}
WHERE LEN(seller_city) < 5
    OR LEN(seller_city) > 30
/* Some responses:  
 - rio de janeiro, rio de janeiro, brasil
 - jaci
 - itu
 - uba.... 
*/
-- There seem to be some quality issues in seller city name
*/