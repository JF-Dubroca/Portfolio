{{ config(materialized = 'table')}}

WITH raw_sellers AS(
    SELECT * FROM {{ source('raw', 'sellers')}}
),

cleaned_sellers AS(
    SELECT 
        CAST(TRIM(seller_id) AS STRING) AS seller_id,
        CAST(seller_zip_code_prefix AS STRING) AS seller_zip_code_prefix, 
        CAST(TRIM(seller_city) AS STRING) AS seller_city,
        CAST(TRIM(seller_state) AS STRING) AS seller_state
    FROM raw_sellers
)

SELECT * FROM cleaned_sellers