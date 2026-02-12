with source as (
        select * from {{ source('raw_client', 'activities') }}
),
renamed as (
    SELECT
        id AS activity_id
        , user_id
        , classroom_id
        , project_id
        , title
        , activity_type AS activity_type_code
        , CASE 
            WHEN activity_type = 'K' THEN 'homework'
            WHEN activity_type = 'LT' THEN 'learning_trail'
            WHEN activity_type = 'DE' THEN 'exam'
            WHEN activity_type = 'R' THEN 'essay'
            WHEN activity_type = 'M' THEN 'handmade'
            WHEN activity_type = 'F' THEN 'forum'
            WHEN activity_type = 'T' THEN 'task'
            WHEN activity_type = 'A' THEN 'schedule'
            WHEN activity_type = 'PG' THEN 'project_game'
            WHEN activity_type = 'PE' THEN 'project_exam'
            WHEN activity_type = 'PT' THEN 'project_trail'
            WHEN activity_type = 'PV' THEN 'project_video'
            WHEN activity_type = 'PB' THEN 'project_book'
            WHEN activity_type = 'PA' THEN 'project_audio'
            WHEN activity_type = 'PO' THEN 'project_other'
            ELSE 'other'
            END AS activity_type
        , status AS status_id
        , CASE status
            WHEN 1 THEN 'active'
            WHEN 2 THEN 'scheduled'
            WHEN 3 THEN 'draft'
            WHEN 4 THEN 'finished'
            WHEN 5 THEN 'archived'
            WHEN 7 THEN 'paused'
            WHEN 9 THEN 'deleted'
            END AS status
        , total_students
        , COALESCE(participation, 0) AS participation
        , COALESCE(workload, 0) AS workload_int
        , CASE
            WHEN status IN (2, 3) OR participation = 0 THEN '0%'
            WHEN status IN (1, 4, 5, 7, 9) AND participation >= total_students THEN '100%'
            WHEN status IN (1, 4, 5, 7, 9) AND participation > 0 AND participation < total_students THEN
            ROUND((participation::numeric / total_students::numeric) * 100, 2)::text || '%'
            ELSE NULL
            END AS participation_rate
        , CASE
            WHEN workload IS NOT NULL AND workload > 0 THEN
            CASE
                WHEN workload % 60 = 0 THEN
                (workload / 60)::text || 'h'
                ELSE
                (workload / 60)::text || 'h' || LPAD((workload % 60)::text, 2, '0') || 'min'
            END
            ELSE NULL
        END AS workload_time    
        , ai_generated
        , CASE 
            WHEN created_at > start_time THEN created_at
            ELSE start_time
            END AS start_at
        , CASE 
            WHEN created_at > start_time THEN created_at::date
            ELSE start_time::date 
            END AS start_date
        , end_at
        , end_time::date AS end_date
        , last_access AS last_access_at
        , last_access::date AS last_access_date
        , created_at
        , created_at::date AS created_date
        , updated_at
        , updated_at::date AS updated_date
        from source
)
select * from renamed