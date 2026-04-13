{% macro flag(condition) %}
    cast(case when {{condition}} then 1 else 0 end as int)
{% endmacro %}