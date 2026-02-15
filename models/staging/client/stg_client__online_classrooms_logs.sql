with source as (
    select * from {{ source('raw_client', 'online_classroom_logs') }}
),
renamed as (
    SELECT 
        id AS online_class_log_id
        , user_id 
        , role_name
        , online_classroom_id
        , room_id AS room_code
        , total_time
        , date AS created_date
    FROM source
)
select * from renamed