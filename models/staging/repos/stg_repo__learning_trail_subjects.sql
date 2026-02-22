with source as (
    select * from {{ source('raw_material', 'learning_trail_subjects') }}
),
renamed as (
    SELECT 
        id AS learning_trail_subject_id
        , learning_trail_id
        , learning_trail_external_id
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