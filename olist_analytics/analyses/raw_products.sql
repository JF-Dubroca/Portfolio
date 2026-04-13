/*
-- Dimensions
SELECT COUNT(*) FROM {{ source('raw', 'products')}}
-- 32951 lines

-- Looking for NULL
SELECT 
    COUNTIF(product_id IS NULL) AS null_product_id,
    COUNTIF(product_category_name IS NULL) AS null_product_category_name,
    COUNTIF(product_name_lenght IS NULL) AS null_product_name_lenght,
    COUNTIF(product_description_lenght IS NULL) AS null_product_description_lenght,
    COUNTIF(product_photos_qty IS NULL) AS null_product_photos_qty,
    COUNTIF(product_weight_g IS NULL) AS null_product_weight_g,
    COUNTIF(product_length_cm IS NULL) AS null_product_length_cm,
    COUNTIF(product_height_cm IS NULL) AS null_product_height_cm,
    COUNTIF(product_width_cm IS NULL) AS null_product_width_cm,
FROM {{ source('raw', 'products')}}
/*
null_product_category_name = 610
null_product_name_lenght = 610
null_product_description_lenght = 610
null_product_photos_qty = 610
null_product_weight_g = 2
null_product_length_cm = 2
null_product_height_cm = 2
null_product_width_cm = 2
*/
-- Looking for rows where product_category_name, product_name_lenght, product_description_lenght, product_photos_qty are NULL
SELECT 
    *
FROM {{ source('raw', 'products')}}
WHERE product_category_name IS NULL
    OR product_name_lenght IS NULL
    OR product_description_lenght IS NULL
    OR product_photos_qty IS NULL
-- 610 rows returned, all null values are on the same line but products exist because dimensions exist
-- Looking for some of these products in order_item
SELECT *
FROM {{ source('raw', 'orders_item')}}
WHERE product_id = 'c4ceee876c82b8328e9c293fa0e1989b'
    OR product_id = 'fa51e914046aab32764c41356b9d4ea4'
    OR product_id = 'bd2ada37b58ae94cc838b9c0569fecd8'
    OR product_id = '10dbe0fbaa2c505123c17fdc34a63c56'
    OR product_id = 'b0a0c5dd78e644373b199380612c350a'
    OR product_id = '5fb61f482620cb672f5e586bb132eae9'
    OR product_id = '46b48281eb6d663ced748f324108c733'
    OR product_id = '56139431d72cd51f19eb9f7dae4d1617'
    OR product_id = 'd8dee61c2034d6d075997acef1870e9b'
-- Looking for sales number for some of these products
SELECT 
    COUNT(*)
FROM {{ source('raw','orders_item')}}
GROUP BY product_id
HAVING product_id = 'c4ceee876c82b8328e9c293fa0e1989b'
-- Only few quantity of these products have been sold. They might not be referenced in o-list catalog
-- Lookig for raws where product dimension are NULL
SELECT *
FROM {{ source('raw', 'products')}}
WHERE product_weight_g IS NULL
    OR product_length_cm IS NULL
    OR product_height_cm IS NULL
    OR product_width_cm IS NULL
-- One line concern a bebes category product, the other line have only NULL value
-- Looking for these products in oreders_item
SELECT *
FROM {{ source('raw', 'orders_item')}}
WHERE product_id = '09ff539a621711667c43eba6a3bd8466'
    OR product_id = '5eb564652db742ff8f28759cd8d2652a'
-- The bebes category products has been sold once
-- The other product has been sold 17 times
-- Products with missing attributes are rarely sold

-- Looking for duplicates
SELECT 
    *,
    COUNT(*) AS duplicates
FROM {{ source('raw', 'products')}}
GROUP BY ALL
HAVING duplicates > 1
-- 0 duplicates detected

-- Primary Key and individual duplicates values
SELECT
    COUNT(*) AS total_raws,
    COUNT(DISTINCT(product_id)) AS distinct_product_id
FROM {{ source('raw', 'products')}}
-- Primary key = product_id, it's possible to find duplicates in others columns

-- Aberrants values
SELECT 
    MIN(LEN(product_id)) AS min_len_product_id, 
    MAX(LEN(product_id)) AS max_len_product_id, 
    MIN(LEN(product_category_name)) AS min_len_product_category_name, 
    MAX(LEN(product_category_name)) AS max_len_product_category_name,
    MIN(product_name_lenght) AS min_product_name_lenght,
    MAX(product_name_lenght) AS max_product_name_lenght,
    MIN(product_description_lenght) AS min_product_description_lenght,
    MAX(product_description_lenght) AS max_pproduct_description_lenght,
    MIN(product_photos_qty) AS min_product_photos_qty,
    MAX(product_photos_qty) AS max_product_photos_qty,
    MIN(product_weight_g) AS min_product_weight_g,
    MAX(product_weight_g) AS max_product_weight_g,
    MIN(product_length_cm) AS min_product_length_cm,
    MAX(product_length_cm) AS max_product_length_cm,
    MIN(product_height_cm) AS min_product_height_cm,
    MAX(product_height_cm) AS max_product_height_cm,
    MIN(product_width_cm) AS min_product_width_cm,
    MAX(product_width_cm) AS max_product_width_cm,
FROM {{ source('raw', 'products')}}
/*
min_len_product_id = 32
max_len_product_id = 32
min_len_product_category_name = 3
max_len_product_category_name = 46
min_product_name_lenght = 5
max_product_name_lenght = 76
min_product_description_lenght = 4
max_pproduct_description_lenght = 3992
min_product_photos_qty = 1
max_product_photos_qty = 20
min_product_weight_g = 0
max_product_weight_g = 40425
min_product_length_cm = 7
max_product_length_cm = 105
min_product_height_cm= 2
max_product_height_cm = 105
min_product_width_cm = 6 
max_product_width_cm = 118 
*/
-- Which product have max_pproduct_description_lenght = 3992?
SELECT *
FROM {{ source('raw', 'products')}}
WHERE product_description_lenght = 3992
-- It's a dvd_blue_ray player, so might have a long description
-- Which product have a min_product_weight_g = 0?
SELECT *
FROM {{ source('raw', 'products')}}
WHERE product_weight_g = 0
-- Category name translation
SELECT *
FROM {{ source('raw', 'categories')}}
WHERE product_category_name = 'cama_mesa_banho'
-- English category name: bed_bath_table 
-- This is likely a data quality issue, products with 30 cm long, 25 cm height, 30 cm width cannot weigh 0 g
-- Which category have only 3 letters?
SELECT DISTINCT(product_category_name)
FROM {{ source('raw', 'products')}}
WHERE LEN(product_category_name) = 3
*/