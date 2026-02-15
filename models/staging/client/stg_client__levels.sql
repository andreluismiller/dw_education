with source as (
    select * from {{ source('raw_client', 'levels') }}
),
renamed as ( 
    SELECT 
        id AS level_id
        , status AS status_id
        , name AS level_name
        , color AS level_color
        , total_users AS qty_users
        , updated_at
    FROM source
)
select * from renamed