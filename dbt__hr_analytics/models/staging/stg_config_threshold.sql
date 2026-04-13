{{
    config(
        database = get_database(var('env'))
    )
}}

select
    {{clean_strings('config_key', 0)}} as config_key,
    cast(config_value as float) as config_value,
    {{clean_strings('description', 0)}} as description,
    {{clean_strings('updated_by', 0)}} as updated_by,
    cast(updated_at as timestamp) as updated_at
from {{ ref('bronze_config_threshold') }}