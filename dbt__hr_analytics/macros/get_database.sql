{% macro get_database(env) %}
    {% if env == 'prod' %}
        prod_hr_analytics
    {% elif env == 'dev' %}
        dev_hr_analytics
    {% else %}
        hr_analytics
    {% endif %}
{% endmacro %}