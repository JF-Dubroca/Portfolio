SELECT product_category_name
FROM {{ ref('stg_categories')}}
WHERE LENGTH(product_category_name) > 50