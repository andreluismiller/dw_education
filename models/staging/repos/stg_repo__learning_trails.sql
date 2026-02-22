with source as (
    select * from {{ source('raw_material', 'learning_trails') }}
),
renamed as (
    SELECT 
        id AS learning_trail_id
        , external_id AS learning_trail_external_id
        , status AS status_id
        , CASE status
            WHEN 1 THEN 'active'
            WHEN 2 THEN 'draft'
            WHEN 3 THEN 'blocked'
            WHEN 8 THEN 'archived'
            WHEN 9 THEN 'deleted'
            ELSE 'other'
            END AS status
        , learning_trail_repo_id
        , author_id
        , author_name
        , platform
        , title
        , objective
        , guidance
        , keywords
        , layout_url
        , total_trails
        , CASE 
            WHEN COALESCE(ratings, 0) = 0 OR COALESCE(total_rating, 0) = 0 THEN 0
            ELSE ROUND(total_rating / ratings)::integer
            END AS rating    
        , pcd_voice AS flag_pcd_voice
        , pcd_sign AS flag_pcd_sign
        , created_at
        , created_at::date AS created_date
        , updated_at
        , updated_at::date AS updated_date
    from source
)
select * from renamed