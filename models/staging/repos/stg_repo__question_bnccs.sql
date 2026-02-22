with source as (
    select * from {{ source('raw_material', 'questions') }}
),
renamed as (
    SELECT 
        q.id AS question_id,
        q.question_context_id,
        k AS bncc_code
    FROM source q
    CROSS JOIN LATERAL json_object_keys(q.bncc) AS k
    WHERE json_typeof(q.bncc) = 'object'
)
select * from renamed