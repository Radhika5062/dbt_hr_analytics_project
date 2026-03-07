INSERT INTO staging.hr_data (
    age, attrition, businesstravel, dailyrate, department, distancefromhome,
    education, educationfield, employeecount, employeenumber, environmentsatisfaction,
    gender, hourlyrate, jobinvolvement, joblevel, jobrole, jobsatisfaction,
    maritalstatus, monthlyincome, monthlyrate, numcompaniesworked, over18, overtime,
    percentsalaryhike, performancerating, relationshipsatisfaction, standardhours,
    stockoptionlevel, totalworkingyears, trainingtimeslastyear, worklifebalance,
    yearsatcompany, yearsincurrentrole, yearssincelastpromotion, yearswithcurrmanager,
    created_at
)
VALUES
(34, 'Yes', 'Travel_Rarely', 800, 'Sales', 10, 3, 'Marketing', 1, 100112, 3, 'Male', 45, 3, 2, 'Sales Executive', 4, 'Married', 5000, 15000, 2, 'Y', 'Yes', 10, 3, 4, 40, 1, 10, 2, 3, 8, 5, 2, 4, null);

{# # Add an employee whose created_at is null to push data into quarantine #}

INSERT INTO staging.hr_data (
    age, attrition, businesstravel, dailyrate, department, distancefromhome,
    education, educationfield, employeecount, employeenumber, environmentsatisfaction,
    gender, hourlyrate, jobinvolvement, joblevel, jobrole, jobsatisfaction,
    maritalstatus, monthlyincome, monthlyrate, numcompaniesworked, over18, overtime,
    percentsalaryhike, performancerating, relationshipsatisfaction, standardhours,
    stockoptionlevel, totalworkingyears, trainingtimeslastyear, worklifebalance,
    yearsatcompany, yearsincurrentrole, yearssincelastpromotion, yearswithcurrmanager,
    created_at
)
VALUES
(34, 'Yes', 'Travel_Rarely', 800, 'Sales', 10, 3, 'Marketing', 1, 100113, 3, 'Male', 45, 3, 2, 'Sales Executive', 4, 'Married', 5000, 15000, 2, 'Y', 'Yes', 10, 3, 4, 40, 1, 1, 2, 3, 10, 5, 2, 4, null);

{# # Test record which will fail test_invalid_tenure test  #}

INSERT INTO staging.hr_data (
    age, attrition, businesstravel, dailyrate, department, distancefromhome,
    education, educationfield, employeecount, employeenumber, environmentsatisfaction,
    gender, hourlyrate, jobinvolvement, joblevel, jobrole, jobsatisfaction,
    maritalstatus, monthlyincome, monthlyrate, numcompaniesworked, over18, overtime,
    percentsalaryhike, performancerating, relationshipsatisfaction, standardhours,
    stockoptionlevel, totalworkingyears, trainingtimeslastyear, worklifebalance,
    yearsatcompany, yearsincurrentrole, yearssincelastpromotion, yearswithcurrmanager,
    created_at
)
VALUES
(34, 'Yes', 'Travel_Rarely', 800, 'Sales', 10, 3, 'Marketing', 1, 100114, 3, 'Male', 45, 3, 2, 'Sales Executive', 4, 'Married', 5000, 15000, 2, 'Y', 'Yes', 10, 3, 4, 40, 1, 1, 2, 3, 10, 5, 2, 4, '1/11/2025');
