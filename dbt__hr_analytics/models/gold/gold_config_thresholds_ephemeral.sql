{{
    config(
        database = get_database(var('env')),
        materialized='ephemeral'
    )
}}

with config as 
(
    select config_key, config_value
    from {{ ref('stg_config_threshold') }}
    qualify row_number() over (partition by config_key order by updated_at desc) = 1
),
config_pivot as
(
    select
        max(case when config_key = 'income_band_low_max'         then config_value end) as income_band_low_max,
        max(case when config_key = 'income_band_high_min'        then config_value end) as income_band_high_min,
        max(case when config_key = 'experience_band_junior_max'  then config_value end) as experience_band_junior_max,
        max(case when config_key = 'experience_band_mid_max'     then config_value end) as experience_band_mid_max,
        max(case when config_key = 'senior_employee_min_level'   then config_value end) as senior_employee_min_level,
        max(case when config_key = 'high_performer_min_rating'   then config_value end) as high_performer_min_rating,
        max(case when config_key = 'low_satisfaction_max'        then config_value end) as low_satisfaction_max,
        max(case when config_key = 'poor_work_life_balance_max'  then config_value end) as poor_work_life_balance_max,
        max(case when config_key = 'stagnation_years_min'        then config_value end) as stagnation_years_min,
        max(case when config_key = 'new_manager_max_years'       then config_value end) as new_manager_max_years,
        max(case when config_key = 'long_tenure_min_years'       then config_value end) as long_tenure_min_years,
        max(case when config_key = 'low_salary_hike_max'         then config_value end) as low_salary_hike_max,
        max(case when config_key = 'risk_band_critical_min' then config_value end) as risk_band_critical_min,
        max(case when config_key = 'risk_band_high_min'     then config_value end) as risk_band_high_min,
        max(case when config_key = 'risk_band_medium_min'   then config_value end) as risk_band_medium_min
    from config
)
select * 
from config_pivot