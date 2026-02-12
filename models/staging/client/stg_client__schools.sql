with source as (
    select * from {{ source('raw_client', 'schools') }}
),
renamed as (
    select
        id AS school_id,
        school_group_id,
        name AS school,
        status AS status_id,
        CASE status
            WHEN 1 THEN 'Active'
            WHEN 2 THEN 'Inactive'
            WHEN 3 THEN 'Blocked'
            WHEN 4 THEN 'Experimental'
            WHEN 5 THEN 'Promotional'
            WHEN 6 THEN 'Free'
            WHEN 8 THEN 'Transition'
            WHEN 9 THEN 'Deleted'
            ELSE 'Other'
        END AS status,
        split_part(external_id, '_deleted', 1) as school_external_id,
        created_at,
        created_at::date AS created_date,
        updated_at,
        updated_at::date AS updated_date,
        email,
        phone,
        model_menu_id,
        COALESCE(data_confirmation, false) AS data_confirmation,
        grade_menu_id,
        COALESCE(subscription_enabled, false) AS subscription_enabled,
        COALESCE(subscription_trial_days, 30) AS subscription_trial_days
    from source
)
select * from renamed