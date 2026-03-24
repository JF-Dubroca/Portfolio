SELECT product_category_name_english
FROM {{ ref ('stg_categories')}}
WHERE LENGTH(product_category_name_english) > 40