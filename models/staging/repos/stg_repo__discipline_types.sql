with source as (
    select * from {{ source('raw_material', 'discipline_types') }}
),
renamed as (
    SELECT 
        id AS discipline_type_id
        , code AS discipline_type_code
        , description AS discipline_type
        , color AS discipline_type_color
        , custom_order
        , created_at::date AS created_date
        , status AS status_id
    FROM source
)
select * from renamed