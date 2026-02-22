with source as (
    select * from {{ source('raw_material', 'user_quizzes') }}
),
renamed as (
    SELECT 
        id AS user_quiz_id
        , user_id
        , name As user_name
        , role AS role_name
        , platform
        , (classifiers->0->>'external_id')::int AS grade_external_id
        , title
        , quiz
        , status AS status_id
        , created_at
        , created_at::date AS created_date
        , updated_at
        , updated_at::date AS updated_date
    from source
)
select * from renamed