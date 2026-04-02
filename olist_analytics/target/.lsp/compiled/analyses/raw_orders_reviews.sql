/*
-- Dimension
SELECT COUNT(*) FROM `olist-e-commerce-analytics-jfd`.`raw`.`orders_reviews`
-- 100000 lines

-- Looking for NULL 
SELECT
    COUNTIF(review_id IS NULL) AS null_review_id, 
    COUNTIF(order_id IS NULL) AS null_order_id, 
    COUNTIF(review_score IS NULL) AS null_review_score, 
    COUNTIF(review_comment_title IS NULL) AS null_review_comment_title,
    COUNTIF(review_comment_message IS NULL) AS null_review_comment_message,
    COUNTIF(review_creation_date IS NULL) AS null_review_creation_date,
    COUNTIF(review_answer_timestamp IS NULL) AS null_review_answer_timestamp
FROM `olist-e-commerce-analytics-jfd`.`raw`.`orders_reviews`
/*
NULL found
 - null_review_comment_title = 88285
 - null_review_comment_message = 58247
 */

 -- Looking for duplicates
 SELECT 
    *,
    COUNT(*) AS duplicate_number
FROM `olist-e-commerce-analytics-jfd`.`raw`.`orders_reviews`
GROUP BY ALL
HAVING duplicate_number > 1
-- 0 duplicates lines detected

-- Primary key and duplicates values
SELECT 
    COUNT(*) AS total_raws, 
    COUNT(DISTINCT(review_id)) AS distinct_review_id,
    COUNT(DISTINCT(order_id)) AS distinct_order_id,
    COUNT(DISTINCT(review_comment_title)) AS distinct_review_comment_title,
    COUNT(DISTINCT(review_comment_message)) AS distinct_review_comment_message,
    COUNT(DISTINCT(review_id, order_id)) AS review_id_order_id
FROM `olist-e-commerce-analytics-jfd`.`raw`.`orders_reviews`
-- Primary key: review_id + order_id
-- review_id and order_id are duplicated
SELECT 
    *, 
    COUNT() OVER(PARTITION BY review_id) AS n_review_id
FROM `olist-e-commerce-analytics-jfd`.`raw`.`orders_reviews`
QUALIFY n_review_id > 1
-- If a customer bought more than one product, a single review is generated for all products bought. 

-- Aberrants values
SELECT 
    MIN(review_score) AS min_review_score, 
    MAX(review_score) AS  max_review_score,
    MAX(LENGTH(review_comment_title)) AS max_length_title, 
    MAX(LENGTH(review_comment_message)) AS max_length_comment, 
    MIN(review_creation_date) AS min_review_creation_date, 
    MAX(review_creation_date) AS max_review_creation_date,
    MIN(review_answer_timestamp) AS min_review_answer_timestamp, 
    MAX(review_answer_timestamp) AS max_review_answer_timestamp
FROM `olist-e-commerce-analytics-jfd`.`raw`.`orders_reviews`
/*
min_review_score = 1
max_review_score = 5
max_length_title = 26
max_length_comment = 208
min_review_creation_date = 02-10-2026
max_review_creation_date = 31-08-2018
min_review_answer_timestamp = 07-10-2026
max_review_answer_timestamp = 29-10-2028
0 aberrant value detected
*/
*/