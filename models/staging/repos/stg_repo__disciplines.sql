with source as (
    select * from {{ source('raw_material', 'disciplines') }}
),
renamed as (
    SELECT 
        id AS discipline_id
        , external_id AS discipline_external_id
        , color AS discipline_color
        , discipline_code
        , grade_external_id 
        , grade_group_external_id AS grade_group_code
        , created_at::date AS created_date
        , status AS status_id
    FROM source
)
select * from renamed