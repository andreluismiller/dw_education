with source as (
    select * from {{ source('raw_client', 'content_tags') }}
),
renamed as (
    SELECT 
        id AS content_tag_id
        , base_curricular_id AS bncc_id
        , content_id
        , content_external_id
        , content_type
        , created_at
        , updated_at
    FROM source
)
select * from renamed