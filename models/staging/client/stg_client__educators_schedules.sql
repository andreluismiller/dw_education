with source as (
    select * from {{ source('raw_client', 'educators_work_schedules') }}
),
renamed as (
    SELECT 
      id AS educator_schedule_id
    , user_id
    , educator_id
    , school_id
    , grade_id
    , classroom_id
    , {{ map_status_code('status') }}
    , created_at
    , created_at::date AS created_date
    , updated_at
    , updated_at::date AS updated_date    
    FROM source
)
select * from renamed