with source as (
    select * from {{ source('raw_client', 'hall_of_fames') }}
),
renamed as (
    SELECT 
        id AS fame_hall_id
        , month AS ref_month
        , year AS ref_year
        , school_id
        , classroom_id
        , grade_id
        , user_id
        , games_played
        , score 
        , created_at
        , created_at::date AS created_date
        , updated_at
        , updated_at::date AS updated_date
    FROM source
)
select * from renamed