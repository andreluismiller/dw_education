with source as (
    select * from {{ source('raw_client', 'tag_groups') }}
),
renamed as (
    SELECT id AS tag_group_id
        , tag_type
        , name AS tag_group
        , status AS status_id
        , platform
        , created_at::date AS created_date
        , updated_at::date AS updated_date    
        FROM source
)
SELECT * FROM renamed