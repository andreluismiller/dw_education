with source as (
    select * from {{ source('raw_client', 'themes') }}
),
renamed as (
    SELECT 
    id AS theme_id
    , external_id AS theme_external_id
    , code AS theme_code
    , description AS theme
    , discipline_id
    , created_at::date AS created_date
    , updated_at::date AS updated_date     
    FROM source
)
SELECT * FROM renamed