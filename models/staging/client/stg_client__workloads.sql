with source as (
    select * from {{ source('raw_client', 'workloads') }}
),
renamed as (
    SELECT 
        id AS workload_id
        , user_id
        , school_id
        , reference_id AS event_reference_id
        , reference_type AS event_type
        , event AS user_event
        , value AS event_value
        , CASE
            WHEN reference_type ILIKE 'Desafio%' THEN 'Desafios'
            WHEN reference_type ILIKE 'Atividade%' THEN 'Minha classe'
            WHEN reference_type IN ('Avatar', 'Pet', 'Loja') THEN 'Diversão'
            ELSE 'Biblioteca'
            END AS event_module
        , created_at
        , created_at::date AS created_date
    FROM source
)
select * from renamed