with source as (
    select * from {{ source('raw_client', 'activities_games') }}
),
renamed as (
    SELECT 
        activity_id
        , game_id
        , '2025-09-01'::date AS extracted_date
    FROM source
)
select * from renamed