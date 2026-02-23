with source as (
    select * from {{ source('raw_material', 'exam_repos') }}
),
renamed as (
    SELECT 
        id AS exam_repo_id
        , platform
        , reference_id
        , repo_type
        , name AS repo
        , exam_count
        , status AS status_id
    from source
)
select * from renamed