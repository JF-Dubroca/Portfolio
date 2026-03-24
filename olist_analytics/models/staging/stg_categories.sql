{{ config(
    materialized = 'table'
)}}

-- read raw table 
WITH raw_categories AS(
    SELECT *
    FROM {{ source('raw', 'categories')}}
), 
cleaned_categories AS(
    SELECT 
        CAST(TRIM(product_category_name) AS STRING) AS product_category_name, 
        CAST(TRIM(product_category_name_english) AS STRING) AS product_category_name_english
    FROM raw_categories
)

SELECT * FROM cleaned_categories