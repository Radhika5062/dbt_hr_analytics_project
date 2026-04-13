{% macro clean_strings(column_name, flag=1) %}
    {% if flag == 1 %}
        initcap(trim(lower({{ column_name }})))
    {% else %}
        trim(lower({{ column_name }}))
    {% endif %}
{% endmacro %}