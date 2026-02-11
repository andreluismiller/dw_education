with source as (
        select * from {{ source('raw_client', 'roles') }}
  ),
  renamed as (
      select 
        id AS role_id,
	      name AS role_name,
	      description AS role_description,
        CASE 
          WHEN name IN ('private_teacher', 'school_teacher', 'school_coordinator', 'school_assistant') THEN 1
          WHEN name IN ('b2c_student', 'private_student', 'school_student') THEN 2
          WHEN name IN ('guardian') THEN 3
          WHEN name IN ('master_pedagogy', 'atheva_master_pedagogy') THEN 4
          ELSE 5
        END AS role_category_id, 
        CASE 
          WHEN name IN ('private_teacher', 'school_teacher', 'school_coordinator', 'school_assistant') THEN 'educator'
          WHEN name IN ('b2c_student', 'private_student', 'school_student') THEN 'student'
          WHEN name IN ('guardian') THEN 'responsable'
          WHEN name IN ('master_pedagogy', 'atheva_master_pedagogy') THEN 'reviewer'
          ELSE 'admin'
        END AS role_category,        
        created_at,
        created_at::date AS created_date,
        updated_at,
        updated_at::date AS updated_date
      from source
  )
  select * from renamed
    