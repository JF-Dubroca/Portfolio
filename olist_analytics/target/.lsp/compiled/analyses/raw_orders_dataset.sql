/*
-- Dimensions
SELECT COUNT(*) FROM `olist-e-commerce-analytics-jfd`.`raw`.`orders_dataset`
-- 99441 lines

-- Looking for NULL
SELECT 
    COUNTIF(order_id IS NULL) AS null_order_id, 
    COUNTIF(customer_id IS NULL) AS null_customer_id,
    COUNTIF(order_status IS NULL) AS null_order_status,
    COUNTIF(order_purchase_timestamp IS NULL) AS null_order_purchase_timestamp,
    COUNTIF(order_approved_at IS NULL) AS null_order_approved_at,
    COUNTIF(order_delivered_carrier_date IS NULL) AS null_order_delivered_carrier_date,
    COUNTIF(order_delivered_customer_date IS NULL) AS null_order_delivered_customer_date,
    COUNTIF(order_estimated_delivery_date IS NULL) AS null_order_estimated_delivery_date
FROM `olist-e-commerce-analytics-jfd`.`raw`.`orders_dataset`
/*
NULL values
 - order_approved_at = 160
 - order_delivered_carrier_date = 1783
 - order_delivered_customer_date = 2965
 */

-- Looking for duplicates
SELECT 
    *,
    COUNT(*) AS duplicates_number
FROM `olist-e-commerce-analytics-jfd`.`raw`.`orders_dataset`
GROUP BY ALL
HAVING duplicates_number > 1
-- 0 duplicates

-- Primary key and duplicates values 
SELECT 
    COUNT(*) AS total_raws,
    COUNT(DISTINCT(order_id)) AS n_order_id, 
    COUNT(DISTINCT(customer_id)) AS n_customer_id,
    COUNT(DISTINCT(order_status)) AS n_order_status,
    COUNT(DISTINCT(order_purchase_timestamp)) AS n_order_purchase_timestamp,
    COUNT(DISTINCT(order_approved_at)) AS n_order_approved_at,
    COUNT(DISTINCT(order_delivered_carrier_date)) AS n_order_delivered_carrier_date,
    COUNT(DISTINCT(order_delivered_customer_date)) AS n_order_delivered_customer_date,
    COUNT(DISTINCT(order_estimated_delivery_date)) AS n_order_estimated_delivery_date
FROM `olist-e-commerce-analytics-jfd`.`raw`.`orders_dataset`
-- Primary key : order_id
-- Foreign key : customer_id --> customers

-- Unique order_status values
SELECT DISTINCT(order_status) FROM `olist-e-commerce-analytics-jfd`.`raw`.`orders_dataset`
/*
Unique values
 - shipped
 - processing
 - unavailable
 - approved
 - delivered
 - created
 - invoiced
 - canceled
 */

 -- Aberrants values
SELECT 
    MIN(order_purchase_timestamp) AS min_order_purchase_timestamp, 
    MIN(order_approved_at) AS min_order_approved_at,
    MIN(order_delivered_carrier_date) AS min_order_delivered_carrier_date,
    MIN(order_delivered_customer_date) AS min_order_delivered_customer_date,
    MIN(order_estimated_delivery_date) AS min_order_estimated_delivery_date
FROM `olist-e-commerce-analytics-jfd`.`raw`.`orders_dataset`

SELECT 
    MAX(order_purchase_timestamp) AS max_order_purchase_timestamp, 
    MAX(order_approved_at) AS max_order_approved_at,
    MAX(order_delivered_carrier_date) AS max_order_delivered_carrier_date,
    MAX(order_delivered_customer_date) AS max_order_delivered_customer_date,
    MAX(order_estimated_delivery_date) AS max_order_estimated_delivery_date
FROM `olist-e-commerce-analytics-jfd`.`raw`.`orders_dataset`
-- 0 aberrant values detected 
*/