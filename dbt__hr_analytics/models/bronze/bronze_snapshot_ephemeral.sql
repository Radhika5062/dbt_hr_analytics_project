{{
    config(
        materialized='ephemeral'
    )
}}
with base as
    (  
        select
        employeenumber,
        monthlyincome,
        stockoptionlevel,
        try_to_date(created_at, 'DD/MM/YYYY') as created_at
       from {{ source('staging', 'hr_data')}}
    )
select * 
from base