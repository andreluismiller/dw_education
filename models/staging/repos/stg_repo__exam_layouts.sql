with source as (
    select * from {{ source('raw_material', 'exam_layouts') }}
),
renamed as (
    SELECT 
        id AS exam_layout_id
        , user_id
        , user_role
        , blob_key
        , filename
        , platform
        , layout_type
        , title AS layout_title
        , status AS status_id
        , created_at
        , created_at::date AS created_date
        , updated_at
        , updated_at::date AS updated_date
    from source
)
select * from renamed