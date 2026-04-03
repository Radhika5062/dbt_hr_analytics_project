{% macro clean_strings(column_name) %}
    initcap(trim({{column_name}}))
{% endmacro %}