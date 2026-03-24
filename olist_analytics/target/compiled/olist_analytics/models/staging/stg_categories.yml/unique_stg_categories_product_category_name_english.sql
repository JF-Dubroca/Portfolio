
    
    

with dbt_test__target as (

  select product_category_name_english as unique_field
  from `olist-e-commerce-analytics-jfd`.`staging`.`stg_categories`
  where product_category_name_english is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


