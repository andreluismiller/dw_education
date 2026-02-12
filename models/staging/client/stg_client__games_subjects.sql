with source as (
    select * from {{ source('raw_client', 'games_subjects') }}
),
renamed as (
    SELECT 
        game_id
        , subject_id
    from source 
)
select * from renamed