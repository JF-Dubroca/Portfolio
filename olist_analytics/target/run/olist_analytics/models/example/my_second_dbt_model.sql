

  create or replace view `olist-e-commerce-analytics-jfd`.`staging`.`my_second_dbt_model`
  OPTIONS()
  as -- Use the `ref` function to select from other models

select *
from `olist-e-commerce-analytics-jfd`.`staging`.`my_first_dbt_model`
where id = 1;

