with source as (
    select * from {{ source('raw_material', 'tag_groups') }}
),
renamed as (
    select
	id AS tag_group_id
	, tag_type
	, name AS tag_group
	, status AS status_id
	, platform
	, created_at::date AS created_date
	, updated_at::date AS updated_date
    from source
)
select * from renamed