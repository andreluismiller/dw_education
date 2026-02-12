with source as (
    select * from {{ source('raw_client', 'classrooms') }}
),
renamed as (
    select
        id as classroom_id,
        grade_id,
        school_id,
        name as classroom,
        description as classroom_description,
        period as classroom_period,
        created_at,
        created_at::date as created_date,
        updated_at,
        updated_at::date as updated_date,
        {{ map_status_code('status') }},
        split_part(external_id, '_deleted', 1) as classroom_external_id
    from source
)
select * from renamed