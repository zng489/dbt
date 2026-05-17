{% macro add_constant(column_name, value) %}
    {{ value }} as {{ column_name }}
{% endmacro %}
