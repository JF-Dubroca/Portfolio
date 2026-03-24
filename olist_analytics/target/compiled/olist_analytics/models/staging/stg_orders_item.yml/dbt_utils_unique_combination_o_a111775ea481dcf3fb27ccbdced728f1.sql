





with validation_errors as (

    select
        order_id, order_item_id
    from `olist-e-commerce-analytics-jfd`.`staging`.`stg_orders_item`
    group by order_id, order_item_id
    having count(*) > 1

)

select *
from validation_errors


