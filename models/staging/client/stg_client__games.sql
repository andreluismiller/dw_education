with source as (
        select * from {{ source('raw_client', 'games') }}
),
renamed as (
    SELECT 
        id as game_id
        , oed_content_id AS game_external_id
        , uid AS game_uid
        , image_url
        , objective
        , keywords
        , title
        , creator_id
        , creator_name
        , creator_role
        , CASE difficulty
            WHEN 0 THEN 'easy'
            WHEN 1 THEN 'medium'
            WHEN 2 THEN 'hard'
            ELSE 'other'
            END AS difficulty
        , status AS status_id
        , CASE status
            WHEN 0 THEN 'undefined'
            WHEN 1 THEN 'active'
            WHEN 2 THEN 'draft'
            WHEN 3 THEN 'blocked'
            WHEN 8 THEN 'new'
            WHEN 9 THEN 'deleted'
            WHEN 10 THEN 'hidden'
            ELSE 'other'
            END AS status
        , platform_status AS platform_status_id     
        , game_repo_id    
        , layout
        , engine
        , COALESCE(json_array_length(details), 0) AS qty_questions
        , question_time
        , CASE 
            WHEN COALESCE(ratings, 0) = 0 OR COALESCE(total_rating, 0) = 0 THEN 0
            ELSE ROUND(total_rating / ratings)::integer
            END AS rating    
        , pcd_voice
        , pcd_sign
        , created_at
        , created_at::date AS created_date
        , updated_at
        , updated_at::date AS updated_date
    from source 
)
select * from renamed