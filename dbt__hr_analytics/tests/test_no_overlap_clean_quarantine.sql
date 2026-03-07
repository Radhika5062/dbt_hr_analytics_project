select c.employee_number
from {{ ref("silver_hr_data_clean_with_lookup_values") }} as c 
join {{ ref ("silver_hr_data_quarantine_with_lookup_values") }} q
where c.employee_number = q.employee_number