with source as (
    select * from {{ source('raw_client', 'subjects') }}
),
renamed as (
    SELECT 
    id AS subject_id
    , external_id AS subject_external_id
    , code AS subject_code
    , description AS subject
    , theme_id
    , created_at::date AS created_date
    , updated_at::date AS updated_date   
    FROM source
)
SELECT * FROM renamed