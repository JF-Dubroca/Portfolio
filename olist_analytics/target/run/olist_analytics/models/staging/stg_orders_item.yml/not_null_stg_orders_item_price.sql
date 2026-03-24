
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select price
from `olist-e-commerce-analytics-jfd`.`staging`.`stg_orders_item`
where price is null



  
  
      
    ) dbt_internal_test