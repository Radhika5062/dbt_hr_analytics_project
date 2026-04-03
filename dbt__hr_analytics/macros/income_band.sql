{% macro income_band(column_name) %}
    case when {{ column_name }} >2000 and {{ column_name }} <=10000 then 'low'
        when {{ column_name }} >10000 and {{ column_name }} <= 20000 then 'medium'
        else 'high'
    end
{% endmacro %}