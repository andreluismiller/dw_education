with source as (
    select * from {{ source('raw_client', 'homework_games') }}
),
renamed as (
    SELECT 
        id AS homework_game_id
        , activity_user_id
        , game_id
        , game_result_id
        , num_of_challenges AS qty_questions
        , score
        , ROUND(CAST(points*10 AS numeric), 2) AS points
        , time_elapsed
        , created_at
        , created_at::date AS created_date
        , updated_at
        , updated_at::date AS updated_date
    FROM source
)
select * from renamed