with source as (
    select * from {{ source('raw_client', 'disciplines') }}
),
renamed as (
    SELECT 
        id AS discipline_id
        , external_id AS discipline_external_id
        , color AS discipline_color
        , discipline_type_id
        , grade_id 
        , grade_group_external_id AS grade_group_code
        , created_at::date AS created_date
        , updated_at::date AS updated_date     
    FROM source
)
SELECT * FROM renamed