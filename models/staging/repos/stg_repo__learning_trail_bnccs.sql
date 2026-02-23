with source as (
    select * from {{ source('raw_material', 'learning_trails') }}
),
renamed as (
    SELECT 
        l.id AS learning_trail_id,
        l.external_id AS learning_trail_external_id,
        k AS bncc_code
    FROM source l
    CROSS JOIN LATERAL jsonb_object_keys(l.bncc) AS k
    WHERE jsonb_typeof(l.bncc) = 'object'
)
select * from renamed