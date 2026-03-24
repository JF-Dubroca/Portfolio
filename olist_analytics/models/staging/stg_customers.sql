{{ config(
    materialized = 'table'
)}}

WITH raw_customers AS(
    SELECT *
    FROM {{ source('raw', 'customer')}}
), 
cleaned_customers AS(
    SELECT 
    CAST(TRIM(customer_id) AS STRING) AS customer_id, 
    CAST(TRIM(customer_unique_id) AS STRING) AS customer_unique_id, 
    TRIM(CAST(customer_zip_code_prefix AS STRING)) AS customer_zip_code_prefix,
    CAST(TRIM(customer_city) AS STRING) AS customer_city, 
    CAST(TRIM(customer_state) AS STRING) AS customer_state
    FROM raw_customers
)

SELECT * FROM cleaned_customers