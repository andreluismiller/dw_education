with source as (
    select * from {{ source('raw_material', 'base_curriculars') }}
),
renamed as (
    SELECT id AS bncc_id
        , code AS bncc_code
        , description AS bncc
        , tag_group_id 
        , tag_type
        , status AS status_id
        , created_at::date AS created_date
	FROM source
)
select * from renamed