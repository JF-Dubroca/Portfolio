SELECT review_comment_message
FROM {{ ref('stg_reviews')}}
WHERE review_comment_message IS NOT NULL 
)AND LENGTH(review_comment_message) > 1000