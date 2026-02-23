with source as (
    select * from {{ source('raw_material', 'exams') }}
),
renamed as (
    select
        s.id as exam_id,
        s.external_id as exam_external_id,
        k as bncc_code
    from source s
    cross join lateral json_object_keys(s.bncc) as k
    where json_typeof(s.bncc) = 'object'
)
select * from renamed