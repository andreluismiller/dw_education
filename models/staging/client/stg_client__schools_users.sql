with source as (
    select * from {{ source('raw_client', 'schools_users') }}
),
renamed as (
    SELECT 
      id AS school_user_id
    , school_id
    , user_id
    , role_id
    , role_name
    , {{ map_status_code('status') }}
    , logged_at IS NOT NULL AS flag_login
    , logged_at
    , created_at
    , created_at::date AS created_date
    , updated_at
    , updated_at::date AS updated_date  
    FROM source
)
select * from renamed