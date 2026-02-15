with source as (
    select * from {{ source('raw_client', 'pokz_bankings') }}
),
renamed as (
    SELECT 
        id AS pokz_banking_id
        , student_id
        , event_type
        , CASE
            WHEN event_type = 'C' AND reference_type IS NULL THEN
                CASE
                    WHEN event ILIKE '%Desafio do AVA%' THEN 'ava_challenge'
                    WHEN event ILIKE '%Desafio do Parque%' THEN 'park_challenge'
                    WHEN event ILIKE '%Desafio do Dia%' THEN 'daily_challenge'
                    WHEN event ILIKE 'Bônus' THEN 'reward'
                    ELSE 'activity'
                END
            WHEN event_type = 'C' AND reference_type IS NOT NULL THEN
                CASE
                    WHEN reference_type = 'activity' THEN 'activity'
                    WHEN reference_type = 'investment' THEN 'redemption_investment'
                    WHEN reference_type = 'level' THEN 'level_reward'
                    WHEN reference_type = 'transaction' THEN 'received_transaction'
                END
        END AS pokz_source
        , event AS event_description 
        , value AS pokz_value
        , CASE
            WHEN event_type = 'C' AND reference_type IS NULL THEN 'sem_ref'
            WHEN event_type = 'C' AND reference_type IS NOT NULL THEN 'com_ref'
        END AS source_group
        , created_at
        , created_at::date AS created_date
        , updated_at
        , updated_at::date AS updated_date
    FROM source 
    WHERE event_type = 'C'
)
select * from renamed