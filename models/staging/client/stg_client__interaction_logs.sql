with source as (
    select * from {{ source('raw_client', 'user_interaction_logs') }}
),
renamed as (
    SELECT 
        id AS user_interaction_log_id
        , user_id
        , role_name
        , date AS interaction_date
        , total_time
    FROM source
)
select * from renamed