with source as (
    select * from {{ source('raw_material', 'exam_alternative_files') }}
),
renamed as (
    SELECT 
        id AS exam_alternative_file_id
        , exam_id
        , question_id
        , alternative_id
        , blob_key
        , blob_type
        , filename
        , platform
        , status AS status_id
        , created_at
        , created_at::date AS created_date
        , updated_at
        , updated_at::date AS updated_date
    from source
)
select * from renamed