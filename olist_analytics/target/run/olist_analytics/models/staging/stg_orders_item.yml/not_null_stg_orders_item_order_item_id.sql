
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select order_item_id
from `olist-e-commerce-analytics-jfd`.`staging`.`stg_orders_item`
where order_item_id is null



  
  
      
    ) dbt_internal_test