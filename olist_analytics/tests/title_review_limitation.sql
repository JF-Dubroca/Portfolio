SELECT review_comment_title
FROM {{ ref('stg_reviews')}}
WHERE review_comment_title IS NOT NULL 
)AND LENGTH(review_comment_title) > 100