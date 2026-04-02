
  
    

    create or replace table `olist-e-commerce-analytics-jfd`.`staging`.`stg_reviews`
      
    
    

    
    OPTIONS()
    as (
      

WITH raw_reviews AS(
    SELECT * FROM `olist-e-commerce-analytics-jfd`.`raw`.`orders_reviews`
),

cleaned_reviews AS(
    SELECT
        CAST(TRIM(review_id) AS STRING) AS review_id, 
        CAST(TRIM(order_id) AS STRING) AS order_id, 
        CAST(review_score AS INT64) AS review_score,
        CAST(TRIM(review_comment_title) AS STRING) AS review_comment_title, 
        CAST(TRIM(review_comment_message) AS STRING) AS review_comment_message, 
        CAST(review_creation_date AS TIMESTAMP) AS review_creation_date, 
        CAST(review_answer_timestamp AS TIMESTAMP) AS review_answer_timestamp
    FROM raw_reviews
)

SELECT * FROM cleaned_reviews
    );
  