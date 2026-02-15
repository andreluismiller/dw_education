with source as (
    select * from {{ source('raw_client', 'online_classrooms') }}
),
renamed as (
    SELECT 
        id AS online_classroom_id
        , school_id
        , classroom_id
        , user_id
        , room_code
        , domain AS classroom_domain
        , is_online
        , is_owner_on
        , created_at
        , updated_at
    FROM source
)
select * from renamed