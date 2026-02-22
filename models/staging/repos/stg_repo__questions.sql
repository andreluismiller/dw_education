with source as (
    select * from {{ source('raw_material', 'questions') }}
),
renamed as (
    SELECT 
        id AS question_id
        , question_context_id
        , reference_id
        , reference_type
        , uid
        , platform
        , difficulty AS difficulty_level_id
        , CASE difficulty
            WHEN 0 THEN 'easy'
            WHEN 1 THEN 'medium'
            WHEN 3 THEN 'hard'
            ELSE 'other'
            END AS difficulty_level
        , status AS status_id
        , CASE status
            WHEN 1 THEN 'active'
            WHEN 3 THEN 'blocked'
            WHEN 8 THEN 'archived'
            WHEN 9 THEN 'deleted'
            ELSE 'other'
            END AS status
        , COALESCE(json_array_length(challenges), 0) AS qty_challenges
        , challenges 
        , created_at
        , created_at::date AS created_date
        , updated_at
        , updated_at::date AS updated_date
    from source
)
select * from renamed