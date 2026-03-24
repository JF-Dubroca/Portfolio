
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  





with validation_errors as (

    select
        order_id, order_item_id
    from `olist-e-commerce-analytics-jfd`.`staging`.`stg_orders_item`
    group by order_id, order_item_id
    having count(*) > 1

)

select *
from validation_errors



  
  
      
    ) dbt_internal_test