with source as (
    select * from {{ source('raw_client', 'users') }}
),
renamed as (
    SELECT 
        id AS user_id
        , username
        , role_id
        , role_name
        , {{ map_status_code('status') }}
        , logged_at IS NOT NULL AS has_login    
        , logged_at  
        , created_at
        , created_at::date AS created_date
        , updated_at
        , updated_at::date AS updated_date
        , COALESCE(virtual_tour, false) AS has_virtual_tour
        , profile_img_type
    from source
)
SELECT * FROM renamed