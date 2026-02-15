with source as (
    select * from {{ source('raw_client', 'project_contents') }}
),
grade_level as (
    SELECT 
        id,
        COALESCE(
            array_agg(DISTINCT (elem->>'gradeId')::integer) FILTER (WHERE elem->>'gradeId' IS NOT NULL),
            '{}'::integer[]
        ) AS grades_list
    FROM 
        source
    LEFT JOIN LATERAL 
        jsonb_array_elements(classification) AS elem ON true
    GROUP BY 
        id
),
renamed as (
    SELECT p.id AS project_content_id
        , p.external_id AS project_content_external_id
        , p.project_id
        , p.project_external_id
        , g.grades_list
        , p.platform
        , p.type AS content_type
        , p.material_id
        , p.uid AS content_uid
        , p.content AS content_external_id
        , p.name AS content_title
        , CAST(p.rating AS numeric) AS content_rating
        , p.content_order
        , COALESCE(p.layout, 'NA') AS layout
        , COALESCE(p.engine, 'NA') AS engine
        , CASE p.difficulty
            WHEN 0 THEN 'Easy'
            WHEN 1 THEN 'Medium'
            WHEN 2 THEN 'Hard'
            ELSE 'NA'
            END AS difficulty
        , p.created_at
        , p.created_at::date AS created_date
        , p.updated_at
        , p.updated_at::date AS updated_date
    FROM source p
    LEFT JOIN grade_level g ON p.id = g.id
)
select * from renamed