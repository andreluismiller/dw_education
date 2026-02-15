with source as (
    select * from {{ source('raw_client', 'trail_results') }}
),
renamed as (
    SELECT 
        id AS trail_result_id
        , user_id
        , activity_id
        , learning_trail_external_id
        , status AS status_id
        , CASE status
            WHEN 1 THEN 'started'
            WHEN 2 THEN 'finished'
            WHEN 3 THEN 'expired'
            WHEN 4 THEN 'closed'
            ELSE 'other'
            END AS status
        , COALESCE(
            (SELECT count(*) FROM jsonb_object_keys(results)),
            0
        ) AS done_itens
        , results
        , created_at
        , created_at::date AS created_date
        , updated_at
        , updated_at::date AS updated_date 
    FROM source
)
select * from renamed