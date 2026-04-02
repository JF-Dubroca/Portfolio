/*
-- Dimension
SELECT COUNT(*) FROM `olist-e-commerce-analytics-jfd`.`raw`.`categories`
-- 71 lines

-- Looking for NULL
SELECT 
    COUNTIF(product_category_name IS NULL) AS product_category_name_null,
    COUNTIF(product_category_name_english IS NULL) AS product_category_name_english_null
FROM `olist-e-commerce-analytics-jfd`.`raw`.`categories`
-- 0 NULL value detected

-- looking for duplicates
SELECT 
    product_category_name,
    product_category_name_english,
    COUNT (*) AS number_of_duplicates
FROM `olist-e-commerce-analytics-jfd`.`raw`.`categories`
GROUP BY ALL
HAVING number_of_duplicates > 1

SELECT 
    product_category_name,
    COUNT (*) AS number_of_duplicates
FROM `olist-e-commerce-analytics-jfd`.`raw`.`categories`
GROUP BY product_category_name
HAVING number_of_duplicates > 1

SELECT 
    product_category_name_english,
    COUNT (*) AS number_of_duplicates
FROM `olist-e-commerce-analytics-jfd`.`raw`.`categories`
GROUP BY product_category_name_english
HAVING number_of_duplicates > 1
-- 0 duplicates detected, iether product_category_name and product_category_name_english can be primary key

-- Looking for extrem value 
SELECT 
    MAX(LEN(product_category_name)) AS max_len_product_category_name, 
    MIN(LEN(product_category_name)) AS min_len_product_category_name, 
    MAX(LEN(product_category_name_english)) AS max_len_product_category_name_english, 
    MIN(LEN(product_category_name_english)) AS min_len_product_category_name_english
FROM `olist-e-commerce-analytics-jfd`.`raw`.`categories`
-- max_len_product_category_name = 46
-- min_len_product_category_name = 3
-- max_len_product_category_name_english = 39
-- min_len_product_category_name_english = 3

-- Viewing these values
SELECT *
FROM `olist-e-commerce-analytics-jfd`.`raw`.`categories`
WHERE
    LEN(product_category_name) = 46 
    OR LEN(product_category_name) = 3
    OR LEN(product_category_name_english) = 39
    OR LEN(product_category_name_english) = 3
-- max_len_product_category_name = movies_cozinha_area_de_servico_jantar_e_jardim
-- min_len_product_category_name = pcs
-- max_len_product_category_name_english = kitchen_dining_laundry_garden_furniture
-- min_len_product_category_name_english = art
-- No aberrant value
*/