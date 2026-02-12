with source as (
    select * from {{ source('raw_client', 'discipline_types') }}
),
renamed as (
    SELECT 
        id AS discipline_type_id
        , code AS discipline_type_code
        , description AS discipline_type
        , color AS discipline_type_color
        , custom_order
        , created_at::date AS created_date
        , updated_at::date AS updated_date      
    FROM source
)
SELECT * FROM renamed