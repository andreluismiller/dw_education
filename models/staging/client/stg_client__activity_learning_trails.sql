with source as (
    select * from {{ source('raw_client', 'activity_learning_trails') }}
),
renamed as (
    SELECT 
        id AS trail_result_id
        , activity_id
        , learning_trail_external_id
        , COALESCE(
            (SELECT count(*) FROM jsonb_object_keys(learning_trail_details)),
            0
        ) AS total_trail_itens
        , COALESCE(
            (SELECT COUNT(*)
            FROM jsonb_each(learning_trail_details) AS j
            WHERE j.value->>'trail_type' = 'game'),
            0
        ) AS qty_game_itens
        , participation AS total_students
        , ROUND(CAST(total_score AS numeric), 2) AS total_points
    FROM source
)
select * from renamed