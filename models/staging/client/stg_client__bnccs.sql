with source as (
    select * from {{ source('raw_client', 'base_curriculars') }}
),
renamed as (
    SELECT 
        id AS bncc_id
        , code AS bncc_code
        , description AS bncc
        , tag_group_id AS tag_group_id
        , tag_type AS tag_type
        , created_at::date AS created_date
        , updated_at::date AS updated_date      
    FROM source
)
SELECT * FROM renamed