with source as (
    select * from {{ source('raw_client', 'pokz_bankings') }}
),
renamed as (
    SELECT 
        id AS pokz_banking_id
        , student_id
        , event_type
        , CASE
            WHEN event_type = 'D' AND reference_type IS NULL THEN
                CASE
                    WHEN event ILIKE 'Liberação de jogos%' THEN 'game_release'
                    WHEN event ILIKE 'Estorno de%' THEN 'reversal'
                    WHEN event ILIKE '%Avatar%' THEN 'avatar'
                    WHEN event ILIKE '%Pet%' THEN 'pet'
                    WHEN event ILIKE 'Serviço na Casa%' THEN 'house'
                END
            WHEN event_type = 'D' AND reference_type IS NOT NULL THEN
                CASE
                    WHEN reference_type = 'investment' THEN 'investment_done'
                    WHEN reference_type = 'park_ticket' THEN 'park_ticket'
                    WHEN reference_type = 'store' THEN 'purchase'
                    WHEN reference_type = 'transaction' THEN 'send_transaction'
                END
        END AS pokz_source
        , event AS event_description 
        , value AS pokz_value
        , CASE
            WHEN event_type = 'D' AND reference_type IS NULL THEN 'sem_ref'
            WHEN event_type = 'D' AND reference_type IS NOT NULL THEN 'com_ref'
        END AS source_group
        , created_at
        , created_at::date AS created_date
        , updated_at
        , updated_at::date AS updated_date
    FROM source 
    WHERE event_type = 'D'
)
select * from renamed