select * 
from {{ ref("silver_hr_data_clean_with_lookup_values") }}
where created_at > current_date
or created_at < '2000-01-01'