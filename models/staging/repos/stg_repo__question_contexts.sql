with source as (
    select * from {{ source('raw_material', 'question_contexts') }}
),
renamed as (
    SELECT
        id AS question_context_id
        , reference_id
        , reference_type
        , platform
        , context AS question_context
        , status AS status_id
        , created_at
        , created_at::date AS created_date
        , updated_at
        , updated_at::date AS updated_date
    from source
)
select * from renamed