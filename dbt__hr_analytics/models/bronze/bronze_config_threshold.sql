{{
    config(
        database = get_database(var('env'))
        )
}}

select
    config_key,
    config_value,
    description,
    updated_by,
    updated_at
from {{ source('staging', 'config_thresholds') }}