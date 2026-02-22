with source as (
    select * from {{ source('raw_material', 'learning_trail_repos') }}
),
renamed as (
    SELECT 
        id AS learning_trail_repo_id
        , platform
        , reference_id
        , repo_type
        , name AS repo
        , learning_trail_count
        , status AS status_id
        , created_at
        , created_at::date AS created_date
        , updated_at
        , updated_at::date AS updated_date
    from source
)
select * from renamed