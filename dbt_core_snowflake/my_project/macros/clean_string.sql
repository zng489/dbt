{% macro clean_string(column_name) %}
    upper(trim({{ column_name }}))
{% endmacro %}

-- upper(trim(c.DSC_RECLAMACAO)) like '%CONSUMIDOR%'