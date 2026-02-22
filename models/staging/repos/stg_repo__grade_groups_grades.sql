with source as (
    select * from {{ source('raw_material', 'grade_groups_grades') }}
),
renamed as (
SELECT 
        id AS grade_group_grade_id
        , grade_group_id
        , grade_external_id
        , status AS status_id
        , created_at::date AS created_date
        , updated_at::date AS updated_date
    from source
)
select * from renamed