/*
-- Dimension
SELECT COUNT(*) FROM {{ source('raw', 'orders_payments')}}
-- 103886 lines

-- Looking for null
SELECT 
    COUNTIF(order_id IS NULL) AS null_order_id, 
    COUNTIF(payment_sequential IS NULL) AS null_payment_sequential,
    COUNTIF(payment_type IS NULL) AS null_payment_type,
    COUNTIF(payment_installments IS NULL) AS null_payment_installments,
    COUNTIF(payment_value IS NULL) AS null_payment_value,
FROM {{ source('raw', 'orders_payments')}}
-- 0 NULL detected

-- Looking for duplicates
SELECT 
    *,
    COUNT(*) AS duplicates_number,
FROM {{ source('raw', 'orders_payments')}}
GROUP BY ALL
HAVING duplicates_number > 1
-- 0 duplicates detected

-- Primary key and duplicates values
SELECT 
    COUNT(*) AS total_raw,
    COUNT(DISTINCT(order_id)) AS distinct_order_id,
    COUNT(DISTINCT(payment_sequential)) AS distinct_payment_seq,
    COUNT(DISTINCT(payment_type)) AS distinct_payment_type,
    COUNT(DISTINCT(payment_installments)) AS distinct_payment_inst,
    COUNT(DISTINCT(payment_value)) AS distinct_payment_value,
FROM {{ source('raw', 'orders_payments')}}
-- 0 Primary key found
-- Visualisation of lines where order_id is duplicated
SELECT 
    *, 
    COUNT() OVER(PARTITION BY order_id ORDER BY order_id) AS order_id_number
FROM {{ source('raw', 'orders_payments')}}
QUALIFY order_id_number > 2
-- Primary key seems to be order_id + payment_sequential
SELECT 
    COUNT(*) AS total_raw,
    COUNT(DISTINCT(order_id, payment_sequential)) AS distinct_order_payment
FROM {{ source('raw', 'orders_payments')}}
-- Primary key = order_id + payement_sequential

-- Aberrants values
SELECT 
    MIN(payment_sequential) AS min_payment_sequential, 
    MAX(payment_sequential) AS max_payment_sequential,
    MIN(payment_installments) AS min_payment_installments,
    MAX(payment_installments) AS max_payment_installments, 
    MIN(payment_value) AS min_payment_value, 
    MAX(payment_value) AS max_payment_value
FROM {{ source('raw', 'orders_payments')}}
-- 0 aberrants values detected
-- Some payment_value = 0. How many of them?
SELECT COUNT(*) AS number_0_payment_value
FROM {{ source('raw', 'orders_payments')}}
WHERE payment_value = 0
-- 9 payment_values = 0 with voucher or not defined payment type. 
-- Ask the commercial departement the reason why. 
-- Valuable payment_type
SELECT DISTINCT(payment_type) AS disctinct_payment_type
FROM {{ source('raw', 'orders_payments')}}
/*
 - debit_card
 - credit_card
 - boleto
 - voucher
 - not defined
 */
 */
