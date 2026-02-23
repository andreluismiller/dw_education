with source as (
    select * from {{ source('raw_material', 'question_subjects') }}
),
renamed as (
    SELECT 
        id AS question_subject_id
        , question_id
        , subject_id
        , platform
        , status AS status_id
        , created_at
        , created_at::date AS created_date
        , updated_at
        , updated_at::date AS updated_date
    from source
)
select * from renamed