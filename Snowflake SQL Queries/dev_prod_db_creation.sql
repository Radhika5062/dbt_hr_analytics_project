create database dev_hr_analytics;
create database prod_hr_analytics;

grant all privileges on database dev_hr_analytics to role dbtrole;
grant all privileges on database prod_hr_analytics to role dbtrole;