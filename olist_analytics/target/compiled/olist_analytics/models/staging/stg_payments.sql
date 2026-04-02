

WITH raw_payments AS(
    SELECT *
    FROM `olist-e-commerce-analytics-jfd`.`raw`.`orders_payments`
), 
payments AS(
    SELECT 
        CAST(TRIM(order_id) AS STRING) AS order_id, 
        CAST(payment_sequential AS INT64) AS payment_sequential, 
        CAST(TRIM(payment_type) AS STRING) AS payment_type, 
        CAST(payment_installments AS INT64) AS payment_installments,
        CAST(payment_value AS FLOAT64) AS payment_value
    FROM raw_payments
)

SELECT * FROM payments