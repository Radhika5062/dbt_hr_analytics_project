CREATE TABLE IF NOT EXISTS config_thresholds (
    config_key      varchar,
    config_value    float,
    description     varchar,
    updated_by      varchar,
    updated_at      timestamp
);

INSERT INTO config_thresholds VALUES
('income_band_low_max',          3000, 'Max monthly income for Low band',                      'data_engineering', current_timestamp),
('income_band_mid_max',          4999, 'Max monthly income for Medium band',                   'data_engineering', current_timestamp),
('income_band_high_min',         5000, 'Min monthly income for High band',                     'data_engineering', current_timestamp),
('experience_band_junior_max',   3,    'Max total working years for Junior band',               'data_engineering', current_timestamp),
('experience_band_mid_min',      4,    'Min total working years for Mid Level band',            'data_engineering', current_timestamp),
('experience_band_mid_max',      10,   'Max total working years for Mid Level band',            'data_engineering', current_timestamp),
('senior_employee_min_level',    4,    'Min job level to be classified as Senior Grade',        'data_engineering', current_timestamp),
('high_performer_min_rating',    4,    'Min performance rating to be a High Performer',         'data_engineering', current_timestamp),
('low_satisfaction_max',         2,    'Max job satisfaction score to flag as low',             'data_engineering', current_timestamp),
('poor_work_life_balance_max',   2,    'Max work life balance score to flag as poor',           'data_engineering', current_timestamp),
('stagnation_years_min',         3,    'Min years without promotion to flag career stagnation', 'data_engineering', current_timestamp),
('new_manager_max_years',        1,    'Max years with manager to flag as new manager',         'data_engineering', current_timestamp),
('long_tenure_min_years',        5,    'Min years at company to flag as long tenure',           'data_engineering', current_timestamp),
('low_salary_hike_max',          11,   'Max salary hike percent to flag as low',                'data_engineering', current_timestamp),
('risk_band_critical_min',       8,    'Min risk score for Critical band',                      'data_engineering', current_timestamp),
('risk_band_high_min',           5,    'Min risk score for High band',                          'data_engineering', current_timestamp),
('risk_band_medium_min',         3,    'Min risk score for Medium band',                        'data_engineering', current_timestamp);

SELECT * FROM config_thresholds;