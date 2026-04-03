{{
    config(
        database = get_database(var('env'))
    )
}}

with get_raw_data_and_cast as
    (  
        select
        cast(Age as int) as age,
        Attrition as attrition,	
        BusinessTravel as business_travel,	
        cast(DailyRate as int) as daily_rate,
        {{ clean_strings('Department') }} as department,
        cast(DistanceFromHome as int) as distance_from_home,
        cast(Education as int) as education,
        {{ clean_strings('EducationField') }} as education_field,
        cast(EmployeeNumber as int) as employee_number,
        cast(EnvironmentSatisfaction as int) as environment_satisfaction,
        {{ clean_strings('Gender')}}  as gender,
        cast(HourlyRate as int) as hourly_rate,
        cast(JobInvolvement as int) as job_involvement,
        cast(JobLevel as int) as job_level,
        {{ clean_strings('JobRole') }}  as job_role,
        cast(JobSatisfaction as int) as job_satisfaction,
        {{ clean_strings('MaritalStatus')}}  as marital_status,
        cast(MonthlyIncome as int) as monthly_income,
        cast(MonthlyRate as int) as monthly_rate,
        cast(NumCompaniesWorked as int) as num_companies_worked,
        Over18 as over_18,
        OverTime as overtime,
        cast(PercentSalaryHike as int) as percent_salary_hike,	
        cast(PerformanceRating as int) as performance_rating,	
        cast(RelationshipSatisfaction as int) as relationship_satisfaction,
        cast(StandardHours as int) as standard_hours,
        cast(StockOptionLevel as int)  as stock_option_level,
        cast(TotalWorkingYears as int) as total_working_years,	
        cast(TrainingTimesLastYear as int)  as training_times_last_year,
        cast(WorkLifeBalance as int) as work_life_balance,
        cast(YearsAtCompany as int) as years_at_company,
        cast(YearsInCurrentRole as int) AS years_in_current_role,
        cast(YearsSinceLastPromotion as int) as years_since_last_promotion,
        cast(YearsWithCurrManager as int) as years_with_current_manager,
        created_at
        from {{ source('staging', 'hr_data')}}
    ),
    clean_strings as (
         select 
            age,
            case when attrition = 'No'
                then 0 
                when attrition = 'Yes'
                then 1
                else -1 end as attrition,	
            case when business_travel = 'Travel_Rarely'
                then 'Travel Rarely'
                when business_travel = 'Travel_Frequently'
                then 'Travel Frequently' 
                when business_travel = 'Non-Travel'
                then 'Non Travel'
                else 'Not Allowed'
            end as business_travel,	
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
            case when over_18 = 'Y' 
                then 1
                else 0
            end as over_18,
            case when overtime = 'Yes' 
                then 1
                when overtime = 'No'
                then 0
                else -1
            end as overtime,
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
            created_at
            from get_raw_data_and_cast
    )
select * 
from clean_strings