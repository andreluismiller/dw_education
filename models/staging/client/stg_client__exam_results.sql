with source as (
    select * from {{ source('raw_client', 'exam_results') }}
),
renamed as (
    SELECT 
        id AS exam_result_id
        , user_id
        , activity_id
        , exam_id
        , exam_external_id
        , status AS status_id
        , CASE status
            WHEN 1 THEN 'started'
            WHEN 2 THEN 'finished'
            WHEN 3 THEN 'expired'
            WHEN 4 THEN 'closed'
            WHEN 5 THEN 'invalidated'
            ELSE 'other'
            END AS status
        , COALESCE(
            (SELECT COUNT(*)
            FROM json_each(result) AS j
            WHERE (j.value->>'chosen_alternative_id')::int = (j.value->>'correct_answer')::int),
            0
        ) AS right_answers
        , COALESCE(
            (SELECT COUNT(*)
            FROM json_each(result) AS j
            WHERE (j.value->>'chosen_alternative_id')::int != (j.value->>'correct_answer')::int),
            0
        ) AS wrong_answers
        , ROUND(CAST(score AS numeric), 2) AS points
        , COALESCE(time_elapsed, 0) AS time_elapsed
        , created_at
        , created_at::date AS created_date
        , updated_at
        , updated_at::date AS updated_date
    FROM source
)
select * from renamed   