{% test test_less_than_val(model, column_name, val)%}

with validation as
    (
        select {{column_name}} as test_column
        from {{model}}
    ),
    validation_errors as
    (
        select test_column
        from validation
        where test_column < {{val}}
    )
    select * 
    from validation_errors

{% endtest%}