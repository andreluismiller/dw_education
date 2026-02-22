with source as (
    select * from {{ source('raw_material', 'themes') }}
),
renamed as (
    SELECT 
        id AS theme_id
        , external_id AS theme_external_id
        , code AS theme_code
        , description AS theme
        , discipline_external_id
        , created_at::date AS created_date
        , status AS status_id
    from source
)
select * from renamed