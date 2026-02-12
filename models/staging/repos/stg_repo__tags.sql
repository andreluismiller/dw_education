with source as (
    select * from {{ source('raw_material', 'tag_groups') }}
),
renamed as (
    select
        tag_id,
        tag_type,
        name AS tag_group,
        status AS status_id,
        platform AS client_platform,
        created_at,
        created_at::date AS created_date,
        updated_at,
        updated_at::date AS updated_date
    from source
)
select * from renamed