{{ config(materialized = 'table')}}

SELECT DISTINCT
    customer_zip_code_prefix AS zip_code,
    customer_city AS city,
    customer_state AS country 
FROM {{ ref('stg_customers') }}