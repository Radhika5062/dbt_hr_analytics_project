{{
    config(
        database = get_database(var('env'))
    )
}}

with base as 
(
    select
        -- identifiers
        employee_number,
        department,
        job_role,
        gender,
        marital_status,
        education_field,
        business_travel,

        -- employment details
        job_level,
        job_satisfaction,
        work_life_balance,
        performance_rating,
        overtime,
        distance_from_home,
        training_times_last_year,
        percent_salary_hike,
        years_since_last_promotion,
        years_with_current_manager,
        years_at_company,

        -- tenure & experience
        total_working_years,
        num_companies_worked,

        -- compensation
        monthly_income,

        -- pre-built enrichments from silver
        bucket_age_groups,
        bucket_tenure_groups,
        derived_prior_experience_years,
        derived_career_stagnation_years,
        derived_years_since_role_change,

        -- target variable
        attrition,

        -- metadata
        created_at

    from {{ ref('silver_employee_enriched') }}
),
avg_metrics as 
(
    select
        avg(distance_from_home)                                               as avg_commute,
        round(avg(total_working_years / nullif(num_companies_worked, 0)), 1)  as avg_mobility
    from base
),
config_pivoted as 
(
    select * 
    from {{ ref('gold_config_thresholds_ephemeral') }}
),
final as
(
    select 
        -- identifiers
        b.employee_number,
        b.department,
        b.job_role,
        b.gender,
        b.marital_status,
        b.education_field,
        b.business_travel,

        -- buckets
        b.bucket_age_groups,
        b.bucket_tenure_groups,

        case
            when b.job_level >= c.senior_employee_min_level then 'Senior Grade'
            else 'Junior Grade'
        end as bucket_seniority_band,
        case
            when b.monthly_income < c.income_band_low_max then 'Low'
            when b.monthly_income < c.income_band_high_min then 'Medium'
            else 'High'
        end as bucket_income_band,
        case
            when b.total_working_years <= c.experience_band_junior_max then 'Junior'
            when b.total_working_years = c.experience_band_mid_max  then 'Mid Level'
            else 'Experienced'
        end as bucket_experience_band,
        case
            when b.total_working_years < 2 then 'Unknown'
            when b.num_companies_worked = 1 then 'Stable Single Employer'
            when (b.total_working_years / nullif(b.num_companies_worked, 0)) < m.avg_mobility then 'Normal Mobility'
            else 'High Mobility'
        end as bucket_mobility_band,

        {{ flag('b.performance_rating >= c.high_performer_min_rating') }} as flag_high_performer,
        {{ flag('b.years_at_company >= c.long_tenure_min_years') }} as flag_long_tenure,
        {{ flag('b.job_satisfaction <= c.low_satisfaction_max') }} as flag_low_job_satisfaction,
        {{ flag('b.work_life_balance <= c.poor_work_life_balance_max') }} as flag_poor_work_life_balance,
        {{ flag('b.overtime = 1') }} as flag_overtime,
        {{ flag('b.years_since_last_promotion >= c.stagnation_years_min') }} as flag_career_stagnation,
        {{ flag('b.distance_from_home > m.avg_commute') }} as flag_long_commute,
        {{ flag('b.training_times_last_year = 0') }} as flag_no_training,
        {{ flag('b.percent_salary_hike <= c.low_salary_hike_max') }} as flag_low_salary_hike,
        {{ flag('b.years_with_current_manager <= c.new_manager_max_years') }} as flag_new_manager,

        b.attrition,
        b.created_at as silver_layer_ingestion_timestamp,
        cast(current_timestamp as timestamp) as created_at_gold_features

    from base b
    cross join avg_metrics m
    cross join config_pivoted c
)
select * 
from final
