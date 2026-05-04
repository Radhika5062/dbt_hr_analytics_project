select gender, count(gender)
from {{ ref ('gold_employee_features') }}
group by gender