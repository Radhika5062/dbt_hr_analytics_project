with base as
    (
        select 
            age,
            attrition,
            business_travel,
            daily_rate,
            department,
            distance_from_home, 
            education,
            education_field, 
            employee_number,
            environment_satisfaction,
            gender,
            hourly_rate,
            job_involvement,
            job_level,
            job_role,
            job_satisfaction,
            marital_status,
            monthly_income,
            monthly_rate,
            num_companies_worked,
            overtime,
            percent_salary_hike,	
            performance_rating,	
            relationship_satisfaction,
            standard_hours,
            stock_option_level,
            total_working_years,	
            training_times_last_year,
            work_life_balance,
            years_at_company,
            years_in_current_role,
            years_since_last_promotion,
            years_with_current_manager,
            try_to_date(created_at, 'DD/MM/YYYY') as created_at
        from {{ ref("bronze_hr_data")}}
    ),
final as
(
    select 
        b.age as age,
        b.attrition as attrition,	
        b.business_travel as business_travel,	
        b.daily_rate as daily_rate,
        b.department as department,
        b.distance_from_home as distance_from_home,
        el.Education_Value as education_value,
        b.education as education,
        b.education_field as education_field,
        b.employee_number as employee_number,
        b.environment_satisfaction as environment_satisfaction,
        esl.Environment_Satisfaction_Value as environment_satisfaction_value,
        b.gender as gender,
        b.hourly_rate as hourly_rate,
        jil.Job_Involvement_Value as job_involvement_value,
        b.job_involvement as job_involvement,
        jll.Job_Level_Value as job_level_value,
        b.job_level as job_level,
        b.job_role as job_role,
        b.job_satisfaction as job_satisfaction,
        jsl.Job_Satisfaction_Value as job_satisfaction_value,
        b.marital_status as marital_status,
        b.monthly_income as monthly_income,
        b.monthly_rate as monthly_rate,
        b.num_companies_worked as num_companies_worked,
        b.overtime as overtime,
        b.percent_salary_hike as percent_salary_hike,	
        b.performance_rating as performance_rating,
        prl.Performance_Rating_Value as performance_rating_value,	
        b.relationship_satisfaction as relationship_satisfaction,
        rsl.Relationship_Satisfaction_Value as relationship_satisfaction_value,
        b.standard_hours as standard_hours,
        b.stock_option_level as stock_option_level,
        b.total_working_years as total_working_years,	
        b.training_times_last_year as training_times_last_year,
        b.work_life_balance as work_life_balance,
        b.years_at_company as years_at_company,
        b.years_in_current_role as years_in_current_role,
        b.years_since_last_promotion as years_since_last_promotion,
        b.years_with_current_manager as years_with_current_manager,
        b.created_at as created_at,
        case when b.created_at is null then 'INVALID CREATED_AT' end as quarantine_reason, 
        current_timestamp as quarantine_date
    from base b 
    left join {{ ref("Education_Lookup")}} el
    on b.education = el.Education_Level
    left join {{ ref('Job_Involvement_lookup') }} as jil 
    on b.job_involvement = jil.Job_Involvement_Level
    left join {{ ref('Job_Level_Lookup') }} as jll 
    on b.job_level = jll.Job_Level
    left join {{ ref('Job_Satisfaction_Lookup') }} as jsl 
    on b.job_satisfaction = jsl.Job_Satisfaction_Level 
    left join {{ ref('Performance_Rating_Lookup') }} as prl 
    on b.performance_rating = prl.Performance_Rating_Level
    left join {{ ref('Relationship_Satisfaction_Lookup') }} as rsl 
    on b.relationship_satisfaction = rsl.Relationship_Satisfaction_Level
    left join {{ ref('Work_Life_Balance_Lookup') }} as wlbl 
    on b.work_life_balance = wlbl.Work_Life_Balance
    left join {{ ref('Environment_Satisfaction_Lookup') }} as esl 
    on b.environment_satisfaction = esl.Environment_Satisfaction_Level
)
select * 
from final
where created_at is null