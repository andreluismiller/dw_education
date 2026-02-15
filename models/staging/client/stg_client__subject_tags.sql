with source as (
    select * from {{ source('raw_client', 'subject_tags') }}
),
renamed as (
    SELECT 
        id AS subject_tag_id
        , subject_external_id
        , base_curricular_code AS bncc_code
        , created_at
    FROM source
)
select * from renamed