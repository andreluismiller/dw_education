with source as (
    select * from {{ source('raw_material', 'exam_subjects') }}
),
renamed as (
    SELECT 
        id AS exam_subject_id
        , exam_id
        , exam_external_id
        , subject_id
        , subject_external_id
        , platform
        , status AS status_id
        , created_at
        , created_at::date AS created_date
        , updated_at
        , updated_at::date AS updated_date
    from source
)
select * from renamed