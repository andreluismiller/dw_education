with source as (
    select * from {{ source('raw_material', 'subjects') }}
),
renamed as (
    SELECT 
        id AS subject_id
        , external_id AS subject_external_id
        , code AS subject_code
        , description AS subject
        , theme_external_id
        , created_at::date AS created_date
        , status AS status_id
    from source
)
select * from renamed