with source as (
    select * from {{ source('raw_client', 'help_center_calls') }}
),
renamed as (
    SELECT 
        id
        , protocol_number
        , school_id
        , user_id
        , user_role AS role_id
        , subject
        , status AS status_id
        , CASE status
            WHEN 1 THEN 'Analysis'
            WHEN 2 THEN 'Ongoing'
            WHEN 3 THEN 'Ended'
            WHEN 9 THEN 'Deleted'
            ELSE 'Other'
            END AS status
        , COALESCE(json_array_length(comments), 0) AS messages_qty    
        , created_at
        , created_at::date AS created_date
        , updated_at
        , updated_at::date AS updated_date
    FROM source
)
select * from renamed