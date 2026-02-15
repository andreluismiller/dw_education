with source as (
    select * from {{ source('raw_client', 'activity_users') }}
),
renamed as (
    SELECT 
        id AS activity_user_id
        , user_id
        , activity_id
        , end_time AS end_date
        , status AS status_id
        , CASE status
            WHEN 1 THEN 'pending'
            WHEN 2 THEN 'urgent'
            WHEN 3 THEN 'done'
            WHEN 5 THEN 'redo'
            WHEN 7 THEN 'paused'
            ELSE 'other'
        END AS status
        , COALESCE(num_games, 0) AS num_games
        , COALESCE(games_played, 0) AS games_played
        , ROUND(CAST(points AS numeric), 2) AS points
        , pokz AS qty_pokz
        , created_at
        , created_at::date AS created_date
        , updated_at
        , updated_at::date AS updated_date
        , last_access AS last_access_at
    FROM source
)
select * from renamed