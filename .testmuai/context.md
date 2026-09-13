## Target application

- Public Tricentis Vehicle Insurance sample, Version 1.0.1.
- Home page is {{home_url}}.
- Quote wizard is {{quote_url}}.
- No login is required.

## Test data

- Never write environment URLs literally in a test. Use placeholders.
- "the home page" means {{home_url}}.
- "the quote wizard" / "Enter Vehicle Data" starts at {{quote_url}}.
- A valid automobile make is {{vehicle_make}}.
- Valid vehicle numbers: engine {{engine_performance}} kW, manufacture {{date_of_manufacture}}, seats {{number_of_seats}}, fuel {{fuel_type}}, list price {{list_price}}, mileage {{annual_mileage}}.
- A valid applicant is {{first_name}} {{last_name}}, born {{date_of_birth}}, country {{country}}, zip {{zip_code}}, occupation {{occupation}}, hobby {{hobby}}.
- A valid product start date is {{start_date}} (more than one month in the future).
- Cover: sum {{insurance_sum}}, merit {{merit_rating}}, damage {{damage_insurance}}, optional {{optional_product}}, courtesy car {{courtesy_car}}.
- A valid price plan is {{price_option}}.
- Send-quote contact: {{applicant_email}}, username {{applicant_username}}, password {{applicant_password}}.
- Out-of-range vehicle values for negative paths: engine {{invalid_engine_performance}}, list price {{invalid_list_price}}.
