with source as (
    select * from {{ source('raw_client', 'games') }}
),
renamed as (
    SELECT 
        id AS game_id
        , oed_content_id
        , REGEXP_REPLACE(match[1], '[\(\)]', '', 'g') AS bncc_code
        FROM source,
        LATERAL regexp_matches(pcn, '\(([A-Z][^ )]{0,9})\)', 'g') AS match
        WHERE pcn IS NOT NULL AND pcn <> ''
)
select * from renamed