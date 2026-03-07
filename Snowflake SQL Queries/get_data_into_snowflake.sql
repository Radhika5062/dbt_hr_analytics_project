
CREATE OR REPLACE STAGE snowflake_aws_s3_stage
CREDENTIALS=(AWS_KEY_ID='Add your AWS key here' AWS_SECRET_KEY='Add your AWS Secret here')
FILE_FORMAT = csv_format_aws
URL='s3://hr-data-analytics-s3-bucket/source-hr-data/';

CREATE FILE FORMAT IF NOT EXISTS csv_format_aws
  TYPE = 'CSV' 
  FIELD_DELIMITER = ','
  SKIP_HEADER = 1
  ERROR_ON_COLUMN_COUNT_MISMATCH = FALSE;

create or replace table hr_data (
    age                         number(3,0),
    attrition                   varchar,     
    businesstravel              varchar,       
    dailyrate                   number(10,4),
    department                  varchar,
    distancefromhome            number(3,0),
    education                   number(2,0),
    educationfield              varchar,
    employeecount               number(3,0),
    employeenumber              number(10,0),
    environmentsatisfaction     number(2,0),
    gender                      varchar,
    hourlyrate                  number(10,4),
    jobinvolvement              number(2,0),
    joblevel                    number(2,0),
    jobrole                     varchar,
    jobsatisfaction             number(2,0),
    maritalstatus               varchar,
    monthlyrate                 number(10,0),
    monthlyincome               number(10,2),
    numcompaniesworked          number(2,0),
    over18                      varchar(1), 
    overtime                    varchar,
    percentsalaryhike           number(3,0),
    performancerating           number(2,0),
    relationshipsatisfaction    number(2,0),
    standardhours               number(4,0),
    stockoptionlevel            number(2,0),
    totalworkingyears           number(3,0),
    trainingtimeslastyear       number(2,0),
    worklifebalance             number(2,0),
    yearsatcompany              number(3,0),
    yearsincurrentrole          number(3,0),
    yearssincelastpromotion     number(3,0),
    yearswithcurrmanager        number(3,0),
    created_at                  varchar     
);


select * 
from hr_analytics.staging.hr_data;

COPY INTO hr_analytics.staging.hr_data
FROM @snowflake_aws_s3_stage
FILES=('HR-Employee-Attrition Final Dataset.csv')
CREDENTIALS=(aws_key_id = 'your key', aws_secret_key = 'your secret key');