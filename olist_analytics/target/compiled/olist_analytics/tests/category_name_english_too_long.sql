SELECT product_category_name_english
FROM `olist-e-commerce-analytics-jfd`.`staging`.`stg_categories`
WHERE LENGTH(product_category_name_english) > 40