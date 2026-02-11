with source as (
    select * from {{ source('raw_client', 'school_groups') }}
),
renamed as (
    select
        id AS school_group_id,
        split_part(external_id, '_deleted', 1) AS school_group_external_id,
        name AS school_group,
        {{ map_status_code('status') }},
        created_at,
        created_at::date AS created_date,
        updated_at,
        updated_at::date AS updated_date
    from source
)
select * from renamed