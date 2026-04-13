{{
    config(
        database = get_database(var('env'))
    )
}}

with config as 
(
    select config_key, config_value
    from {{ ref('stg_config_threshold') }}
    qualify row_number() over (partition by config_key order by updated_at desc) = 1
),
config_pivoted as
(
    select
        max(case when config_key = 'risk_band_critical_min' then config_value end) as risk_band_critical_min,
        max(case when config_key = 'risk_band_high_min'     then config_value end) as risk_band_high_min,
        max(case when config_key = 'risk_band_medium_min'   then config_value end) as risk_band_medium_min
    from config
),

add_score as 
(
    select
        b.employee_number,
        b.department,
        b.job_role,
        b.gender,
        b.marital_status,
        b.education_field,
        b.business_travel,

        b.bucket_age_groups,
        b.bucket_tenure_groups,
        b.bucket_seniority_band,
        b.bucket_income_band,
        b.bucket_experience_band,
        b.bucket_mobility_band,

        b.flag_high_performer,
        b.flag_long_tenure,
        b.flag_low_job_satisfaction,
        b.flag_poor_work_life_balance,
        b.flag_overtime,
        b.flag_career_stagnation,
        b.flag_long_commute,
        b.flag_no_training,
        b.flag_low_salary_hike,
        b.flag_new_manager,


        -- risk score
        -- max possible score = 8 standard flags (x1) + 2 weighted flags (x2) = 12
        (
            b.flag_low_job_satisfaction +
            b.flag_poor_work_life_balance +
            b.flag_overtime +
            b.flag_career_stagnation +
            b.flag_long_commute +
            b.flag_no_training +
            b.flag_low_salary_hike +
            b.flag_new_manager +
            (b.flag_high_performer * 2) +
            (b.flag_long_tenure * 2)
        ) as attrition_risk_score,

        12                                                      as attrition_risk_score_max,
        round((attrition_risk_score / 12.0) * 100, 1)          as attrition_risk_score_pct,

        -- audit columns
        c.risk_band_critical_min,
        c.risk_band_high_min,
        c.risk_band_medium_min,

        -- target variable
        b.attrition,

        -- metadata
        b.created_at_gold_features

    from {{ ref('gold_employee_features') }} b
    cross join config_pivoted c
)

select
    -- identifiers
    employee_number,
    department,
    job_role,
    gender,
    marital_status,
    education_field,
    business_travel,

    -- buckets
    bucket_age_groups,
    bucket_tenure_groups,
    bucket_seniority_band,
    bucket_income_band,
    bucket_experience_band,
    bucket_mobility_band,

    -- descriptor flags
    flag_high_performer,
    flag_long_tenure,

    -- standard risk flags
    flag_low_job_satisfaction,
    flag_poor_work_life_balance,
    flag_overtime,
    flag_career_stagnation,
    flag_long_commute,
    flag_no_training,
    flag_low_salary_hike,
    flag_new_manager,

    -- risk score and band
    attrition_risk_score,
    12                                                          as attrition_risk_score_max,
    round((attrition_risk_score / 12.0) * 100, 1)              as attrition_risk_score_pct,
    case
        when attrition_risk_score >= risk_band_critical_min     then 'Critical'
        when attrition_risk_score >= risk_band_high_min         then 'High'
        when attrition_risk_score >= risk_band_medium_min       then 'Medium'
        else 'Low'
    end                                                         as attrition_risk_band,

    -- audit columns
    risk_band_critical_min                                      as config_risk_band_critical_min,
    risk_band_high_min                                          as config_risk_band_high_min,
    risk_band_medium_min                                        as config_risk_band_medium_min,

    -- target variable
    attrition,

    -- metadata
    created_at_gold_features,
    cast(current_timestamp as timestamp)                        as updated_at

from add_score
order by attrition_risk_score desc