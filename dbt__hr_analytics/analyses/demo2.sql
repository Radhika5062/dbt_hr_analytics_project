with base as
(
    select * 
    from {{ ref('silver_hr_data_clean_with_lookup_values')}}
)
select 
    employee_number,
    monthly_income,
    {{ income_band('monthly_income') }} as income_bands
from base
