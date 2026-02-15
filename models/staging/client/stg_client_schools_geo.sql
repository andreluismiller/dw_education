with source as (
    select * from {{ source('raw_client', 'school_addresses') }}
),
renamed as (
    SELECT 
        id AS school_address_id
        , school_id
        , city
        , state AS uf
        , created_at
        , created_at::date AS created_date
        , updated_at
        , updated_at::date AS updated_date 
    FROM source
)
select * from renamed