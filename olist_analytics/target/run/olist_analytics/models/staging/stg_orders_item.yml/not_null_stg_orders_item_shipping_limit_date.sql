
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select shipping_limit_date
from `olist-e-commerce-analytics-jfd`.`staging`.`stg_orders_item`
where shipping_limit_date is null



  
  
      
    ) dbt_internal_test