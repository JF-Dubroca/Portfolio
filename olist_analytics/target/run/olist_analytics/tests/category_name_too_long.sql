
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  SELECT product_category_name
FROM `olist-e-commerce-analytics-jfd`.`staging`.`stg_categories`
WHERE LENGTH(product_category_name) > 50
  
  
      
    ) dbt_internal_test