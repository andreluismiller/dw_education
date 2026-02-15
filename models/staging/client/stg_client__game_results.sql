with source as (
    select * from {{ source('raw_client', 'game_results') }}
),
renamed as (
    SELECT 
        id AS game_result_id
        , user_id
        , game_id
        , oed_content_id
        , classroom_id
        , grade_id
        , scoring_rule AS scoring_rule_code
        , CASE 
            WHEN scoring_rule = 'D' THEN 'daily_challenge'
            WHEN scoring_rule = 'V' THEN 'ava_challenge'
            WHEN scoring_rule = 'P' THEN 'park_challenge'
            WHEN scoring_rule = 'K' THEN 'homework_game'
            WHEN scoring_rule = 'LT' THEN 'trail_game'
            WHEN scoring_rule = 'GS' THEN 'external_challenge'
            WHEN scoring_rule = 'T' THEN 'unknown'
            ELSE 'other'
            END AS scoring_rule
        , num_of_challenges AS qty_questions
        , score
        , ROUND(CAST(points*10 AS numeric), 2) AS points
        , time_elapsed
        , created_at::timestamp without time zone AS created_at
        , created_at::timestamp without time zone::date AS created_date
        , updated_at::timestamp without time zone AS updated_at
        , updated_at::timestamp without time zone::date AS updated_date
    FROM source
        WHERE points >= 0 AND points <= 1
)
select * from renamed