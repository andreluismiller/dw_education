with source as (
    select * from {{ source('raw_client', 'students') }}
),
renamed as (
    SELECT 
      id AS student_id
    , id AS student_id
    , user_id
    , school_id
    , grade_id
    , classroom_id
    , avatar_id
    , {{ map_status_code('status') }}
    , COALESCE((level_up ->> 'unique_accesses')::INTEGER, 0) AS unique_accesses
    , COALESCE((level_up ->> 'total_games_played')::INTEGER, 0) AS total_games_played 
    , score_total
    , pokz_total
    , credits
    , COALESCE(interactive_map, TRUE) AS has_interactive_map
    , COALESCE(interactive_map_energy, 0) AS interactive_map_energy
    , created_at
    , created_at::date AS created_date
    , updated_at
    , updated_at::date AS updated_date
    FROM source
)