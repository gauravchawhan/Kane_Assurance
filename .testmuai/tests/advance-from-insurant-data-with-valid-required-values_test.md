---
assurance:
  id: t-7
  base: sha256:7667a6caa34177533bbe57781c1dfc33f4d8f3e5ff8020056d6e2d14d9037c61
---
# Advance from insurant data with valid required values

> Prove the applicant can complete Enter Insurant Data with valid required values and continue to the next applicant-stage step.

## Step 1

Open https://sampleapp.tricentis.com/101/app.php and complete the Automobile Enter Vehicle Data step with Make Audi, Engine Performance 120, Date of Manufacture 01/15/2020, Number of Seats 5, Fuel Type Petrol, List Price 25000, and Annual Mileage 15000 so the public quote wizard shows Enter Insurant Data.

## Step 2

On Enter Insurant Data, store the current wizard step title as baseline_step.

## Step 3 @verifies ac-34

On Enter Insurant Data, inspect the Gender radio group, then assert the only visible choices are Male and Female.

## Step 4 @verifies ac-32

On Enter Insurant Data, open the Occupation dropdown and inspect its choices, then assert Employee, Public Official, Farmer, Unemployed, and Selfemployed are listed.

## Step 5 @verifies ac-38

On Enter Insurant Data, enter First Name Alex, Last Name Morgan, Date of Birth 03/12/1990, select Gender Male, leave Street Address empty, select Country United States, enter Zip Code 94107, leave City empty, select Occupation Employee, select Hobby Skydiving, leave Website empty, leave Picture empty, and click Next, then assert the wizard shows Enter Product Data.
