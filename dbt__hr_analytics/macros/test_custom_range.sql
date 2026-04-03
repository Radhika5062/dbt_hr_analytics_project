{% test test_custom_range(model, column_name, min_val, max_val)%}
    select * 
    from {{ model }}
    where {{ column_name }} < {{min_val}}
    or {{ column_name }} > {{max_val}}

{% endtest %}