with source as (
    select * from {{ source('raw_client', 'access_logs') }}
),
renamed as (
    SELECT 
        id AS access_log_id
        , user_id
        , school_id
        , role_id
        , role_name
        , created_at
        , created_at::date AS created_date
    FROM source
)
select * from renamed