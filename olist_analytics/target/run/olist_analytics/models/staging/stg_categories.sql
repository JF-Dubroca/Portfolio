
  
    

    create or replace table `olist-e-commerce-analytics-jfd`.`staging`.`stg_categories`
      
    
    

    
    OPTIONS()
    as (
      

-- read raw table 
WITH raw_categories AS(
    SELECT *
    FROM `olist-e-commerce-analytics-jfd`.`raw`.`categories`
), 
cleaned_categories AS(
    SELECT 
        CAST(TRIM(product_category_name) AS STRING) AS product_category_name, 
        CAST(TRIM(product_category_name_english) AS STRING) AS product_category_name_english
    FROM raw_categories
)

SELECT * FROM cleaned_categories
    );
  