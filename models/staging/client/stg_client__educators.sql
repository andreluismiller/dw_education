with source as (
    select * from {{ source('raw_client', 'educators') }}
),
renamed as (
    SELECT 
    , id AS educator_id
    , user_id
    , {{ map_status_code('status') }}
    , created_at
    , created_at::date AS created_date
    , updated_at
    , updated_at::date AS updated_date    
    FROM source
)
select * from renamed