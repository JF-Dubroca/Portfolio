{{ config (materialized = 'table')}}

WITH product_aggregate AS(
    SELECT
        product_id, 
        COUNT(DISTINCT order_id) AS nb_order,
        COUNT(product_id) AS nb_item_sold,
        SUM(price) AS total_revenue,
        AVG(price) AS avg_price
    FROM {{ ref('stg_orders_item') }} 
    GROUP BY product_id
)

SELECT 
    p.product_id,
    c.product_category_name_english AS category, 
    COALESCE(pa.nb_order, 0),
    COALESCE(pa.nb_item_sold, 0),
    COALESCE(pa.total_revenue, 0),
    COALESCE(pa.avg_price, 0)
FROM {{ ref('stg_products') }} AS p 
LEFT JOIN {{ ref('stg_categories') }} AS c 
    ON p.product_category_name = c.product_category_name
LEFT JOIN product_aggregate AS pa 
    ON p.product_id = pa.product_id