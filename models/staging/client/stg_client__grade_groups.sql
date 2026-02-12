with source as (
    select * from {{ source('raw_client', 'grade_groups') }}
),
renamed as (
    SELECT 
        id AS grade_group_id
        , external_id::bigint AS grade_group_external_id
        , name AS grade_group
        , status AS status_id
        , created_at::date AS created_date
        , updated_at::date AS updated_date      
    FROM source
)
SELECT * FROM renamed