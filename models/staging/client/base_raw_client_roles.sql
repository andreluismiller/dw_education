with source as (
        select * from {{ source('raw_client', 'roles') }}
  ),
  renamed as (
      select 
        id AS role_id,
	      name AS role_name,
	      description AS role_description,
        created_at,
        created_at::date AS created_date,
        updated_at,
        updated_at::date AS updated_date
      from source
  )
  select * from renamed
    