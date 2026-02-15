with source as (
    select * from {{ source('raw_client', 'project_results') }}
),
renamed as (
    SELECT 
        id AS project_result_id
        , project_id
        , user_id
        , group_id AS school_group_id
        , school_id
        , grade_id
        , classroom_id
        , activity_id
        , content_id
        , content_type
        , score AS points
        , pokz
        , created_at::date AS created_date
        , updated_at
        , updated_at::date AS updated_date
    FROM source
)
select * from renamed