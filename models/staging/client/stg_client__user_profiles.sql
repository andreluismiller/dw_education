with source as (
    select * from {{ source('raw_client', 'user_profiles') }}
),
renamed as (
    SELECT 
        id AS user_profile_id
        , user_id
        , COALESCE(special_conditions, FALSE) AS flag_pcd
    FROM source
)
select * from renamed