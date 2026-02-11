{# macros/status_mapping.sql #}

{% macro map_status_code(column_name) %}
    {{ column_name }} AS status_id,
    CASE {{ column_name }}
        WHEN 0 THEN 'Created'    
        WHEN 1 THEN 'Active'
        WHEN 2 THEN 'Inactive'
        WHEN 3 THEN 'Blocked'
        WHEN 4 THEN 'Experimental'
        WHEN 5 THEN 'Promotional'
        WHEN 6 THEN 'Free'
        WHEN 8 THEN 'Transition'
        WHEN 9 THEN 'Deleted'
        WHEN 10 THEN 'Trial'
        WHEN 11 THEN 'Trial expired'            
        ELSE 'Other'
    END AS status
{% endmacro %}