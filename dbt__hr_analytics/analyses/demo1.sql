{% set genders = ['Male', 'Female', 'Other'] %}
with base as
(
    select 
        *
    from {{ ref('bronze_hr_data') }}
)
select
    {# sum(case when gender = 'Male' then 1 else 0 end) as male_count,
    sum(case when gender = 'Female' then 1 else 0 end) as female_count,
    sum(case when gender = 'Other' then 1 else 0 end) as other_count #}

    {% for gender in genders %}
        sum(case when gender = '{{ gender }}' then 1 else 0 end) as {{ gender | lower }}_counter {% if not loop.last %}, {% endif %}
    {% endfor %}
from base
