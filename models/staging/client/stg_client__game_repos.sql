with source as (
    select * from {{ source('raw_client', 'game_repos') }}
),
renamed as (
    SELECT 
        id AS game_repo_id
        , reference_id
        , repo_type
        , status AS status_id
        , name AS repo
        , game_count AS qty_games
        , created_at::date AS created_date
        , updated_at::date AS updated_date
    from source
)
select * from renamed