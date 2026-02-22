with source as (
    select * from {{ source('raw_material', 'grades') }}
),
renamed as (
    SELECT 
        id AS grade_id
        , external_id AS grade_external_id
        , external_code AS grade_code
        , description AS grade_description
        , CASE 
            WHEN external_code ILIKE 'EF1%' THEN 'Ensino Fundamental - Anos iniciais'
            WHEN external_code ILIKE 'EF2%' THEN 'Ensino Fundamental - Anos finais'
            WHEN external_code ILIKE 'EM%' THEN 'Ensino Médio'
            WHEN external_code ILIKE 'INF%' THEN 'Educação Infantil'
            WHEN external_code ILIKE 'EJA%' THEN 'Educação de Jovens e Adultos'
            WHEN external_code ILIKE 'NEM%' THEN 'Novo Ensino Médio'
            WHEN external_code ILIKE 'MS%' THEN 'Multisseriado'
            ELSE 'Outro'
            END AS grade_stage
        , user_map    
        , grade_sequence
        , grade_type
        , created_at::date AS created_date
        , updated_at::date AS updated_date
        , status AS status_id
    from source
)
select * from renamed