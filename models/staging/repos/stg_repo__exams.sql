with source as (
    select * from {{ source('raw_material', 'exams') }}
),
renamed as (
    SELECT 
        id AS exam_id
        , external_id AS exam_external_id
        , status AS status_id
        , CASE status
            WHEN 1 THEN 'active'
            WHEN 2 THEN 'draft'
            WHEN 3 THEN 'blocked'
            WHEN 7 THEN 'unnaproved'
            WHEN 8 THEN 'archived'
            WHEN 9 THEN 'deleted'
            ELSE 'other'
            END AS status
        , question_code_type AS question_code_type_id
        , CASE question_code_type
            WHEN 1 THEN 'generated'
            WHEN 2 THEN 'specified'
            WHEN 3 THEN 'bncc'
            ELSE 'other'
            END AS question_code_type
        , exam_repo_id
        , author_id
        , author_name
        , platform
        , title
        , description
        , guidance
        , keywords
        , layout_url
        , COALESCE(total_questions, 0) AS total_questions
        , duration
        , CASE 
            WHEN COALESCE(ratings, 0) = 0 OR COALESCE(total_rating, 0) = 0 THEN 0
            ELSE ROUND(total_rating / ratings)::integer
            END AS rating    
        , COALESCE(randomize, FALSE) AS flag_randomize
        , randomize_question AS flag_randomize_question
        , can_cheat AS flag_can_cheat
        , fullscreen AS flag_fullscreen
        , used AS flag_used
        , pcd_voice AS flag_pcd_voice
        , pcd_sign AS flag_pcd_sign
        , created_at
        , created_at::date AS created_date
        , updated_at
        , updated_at::date AS updated_date
    from source
)
select * from renamed