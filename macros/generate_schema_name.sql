{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}
    
    {# Se um schema customizado for definido na pasta/model, use APENAS ele #}
    {%- if custom_schema_name is not none -%}

        {{ custom_schema_name | trim }}

    {# Caso contrário, usa o schema padrão do profiles.yml #}
    {%- else -%}

        {{ default_schema }}

    {%- endif -%}

{%- endmacro %}