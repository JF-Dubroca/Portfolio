
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select product_id
from `olist-e-commerce-analytics-jfd`.`staging`.`stg_orders_item`
where product_id is null



  
  
      
    ) dbt_internal_test