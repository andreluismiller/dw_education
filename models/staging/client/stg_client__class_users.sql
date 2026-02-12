with source as (
    select * from {{ source('raw_client', 'classrooms_users') }}
),
renamed as (
    SELECT 
      id AS classroom_user_id
    , id AS classroom_user_id
    , classroom_id
    , user_id
    , {{ map_status_code('status') }}
    , created_at
    , created_at::date AS created_date
    , updated_at
    , updated_at::date AS updated_date
    FROM source
)
select * from renamed