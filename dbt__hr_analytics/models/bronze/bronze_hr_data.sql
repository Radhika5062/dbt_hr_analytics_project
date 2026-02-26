with get_raw_data_and_cast as
    (  
        select
        cast(Age as int) as age,
        Attrition as attrition,	
        BusinessTravel as business_travel,	
        cast(DailyRate as int) as daily_rate,
        Department as department,
        cast(DistanceFromHome as int) as distance_from_home,
        cast(Education as int) as education,
        EducationField as education_field,
        cast(EmployeeNumber as int) as employee_number,
        cast(EnvironmentSatisfaction as int) as environment_satisfaction,
        Gender as gender,
        cast(HourlyRate as int) as hourly_rate,
        cast(JobInvolvement as int) as job_involvement,
        cast(JobLevel as int) as job_level,
        JobRole as job_role,
        cast(JobSatisfaction as int) as job_satisfaction,
        MaritalStatus as marital_status,
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
            case when department = 'Sales'
                then 'Sales'
                when department = 'Research & Development'
                then 'Research & Development'
                when department = 'Human Resources'
                then 'Human Resources'
                else 'Not Allowed'
            end as department,
            distance_from_home,
            education,
            case when education_field = 'Human Resources' 
                then 'Human Resources'
                when education_field = 'Life Sciences'
                then 'Life Sciences'
                when education_field = 'Marketing'
                then 'Marketing'
                when education_field ='Medical'
                then 'Medical'
                when education_field ='Other'
                then 'Other'
                when education_field ='Technical Degree'
                then 'Technical Degree'
                else 'Not Allowed'
            end as education_field,
            employee_number,
            environment_satisfaction,
            case when gender = 'Male'
                then 'Male'
                when gender = 'Female'
                then 'Female'
                else 'Other'  
            end as gender,
            hourly_rate,
            job_involvement,
            job_level,
            case when job_role = 'Healthcare Representative'
                then 'Healthcare Representative' 
                when job_role = 'Human Resources'
                then 'Human Resources'
                when job_role = 'Laboratory Technician'
                then 'Laboratory Technician'
                when job_role = 'Manager'
                then 'Manager'
                when job_role = 'Manufacturing Director'
                then 'Manufacturing Director'
                when job_role = 'Research Director'
                then 'Research Director'
                when job_role = 'Research Scientist'
                then 'Research Scientist'
                when job_role = 'Sales Executive'
                then 'Sales Executive'
                when job_role = 'Sales Representative'
                then 'Sales Representative'
                else 'Not Allowed'
            end as job_role,
            job_satisfaction,
            case when marital_status = 'Single'
                then 'Single'
                when marital_status = 'Married'
                then 'Married'
                when marital_status = 'Divorced'
                then 'Divorced'
                else 'Not Allowed'
            end as marital_status,
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