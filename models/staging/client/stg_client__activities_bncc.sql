with source as (
    select * from {{ source('raw_client', 'activities') }}
),
renamed as (
    SELECT
        a.id AS activity_id
        , key AS bncc_code
    FROM 
        source a
    CROSS JOIN LATERAL (
        SELECT 
            jsonb_object_keys(a.bncc::jsonb) AS key
        WHERE 
            jsonb_typeof(a.bncc::jsonb) = 'object'
    ) keys
)
select * from renamed