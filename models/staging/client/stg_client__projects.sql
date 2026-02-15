WITH source AS (
	SELECT * FROM {{ source('raw_client', 'projects') }}
),
grade_level AS (
-- agrupa todos os valores distintos de "grade_id" no campo "classification" em array 
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
renamed AS (
    SELECT p.id AS project_id
        , p.external_id AS project_external_id
        , p.owner_id
        , p.owner_name
        , g.grades_list
        , p.status AS status_id
        , CASE p.status
            WHEN 0 THEN 'Created'    
            WHEN 1 THEN 'Active'
            WHEN 2 THEN 'Inactive'
            WHEN 3 THEN 'Blocked'
            WHEN 4 THEN 'Experimental'
            WHEN 5 THEN 'Promotional'
            WHEN 6 THEN 'Free'
            WHEN 8 THEN 'Transition'
            WHEN 9 THEN 'Deleted'
            WHEN 10 THEN 'Trial'
            WHEN 11 THEN 'Trial expired'            
            ELSE 'Other'
        END AS status
        , p.platform
        , p.keywords
        , p.title
        , p.objective
        , p.description
        , p.created_at
        , p.created_at::date AS created_date
        , p.updated_at
        , p.updated_at::date AS updated_date
        FROM source p 
        LEFT JOIN grade_level g ON p.id = g.id
)
select * from renamed