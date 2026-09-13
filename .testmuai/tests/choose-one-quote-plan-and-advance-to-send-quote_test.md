---
assurance:
  id: t-13
  base: sha256:bcd44f0033980bb22b1165bfb9d55191c7a50fe1595f309483e96715dabf28a1
---
# Choose one quote plan and advance to Send Quote

> Prove that after the first three wizard steps are complete, the applicant can compare the offered plans, choose any one offered plan, and advance from Select Price Option to Send Quote.

## Step 1

Open https://sampleapp.tricentis.com/101/#, start an Automobile quote, complete Enter Vehicle Data with Make Audi, Engine Performance 120, Date of Manufacture 01/15/2020, Number of Seats 5, Fuel Type Petrol, List Price 25000, and Annual Mileage 15000, complete Enter Insurant Data with First Name Alex, Last Name Morgan, Date of Birth 03/12/1990, Country United States, Zip Code 94107, Occupation Employee, and Hobby Skydiving, then complete Enter Product Data with a start date more than one month from today, Insurance Sum 5.000.000,00, Merit Rating Bonus 1, Damage Insurance Full Coverage, Optional Product Euro Protection, and Courtesy Car Yes until Select Price Option is shown.

## Step 2

On Select Price Option, store the current wizard step title as baseline_step and inspect the displayed price table before changing any selection.

## Step 3 @verifies ac-53, ac-55, ac-56, ac-57

On Select Price Option, confirm the displayed price table lists exactly four plans named Silver, Gold, Platinum, and Ultimate, each with a Price per Year ($), select Gold, then assert Gold is the only selected plan.

## Step 4 @verifies ac-54

On Select Price Option, click Next », then assert the wizard advances to Send Quote.
