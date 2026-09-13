---
assurance:
  id: t-14
  base: sha256:f68bbd9dc64b1a2e38a600f370d6739bf8832894a8e70408158589e876994780
---
# Block continuation when no quote plan is selected

> Prove that when the applicant attempts to continue from Select Price Option with zero plans selected, the wizard does not advance.

## Step 1

Open https://sampleapp.tricentis.com/101/#, start an Automobile quote, complete Enter Vehicle Data with Make Audi, Engine Performance 120, Date of Manufacture 01/15/2020, Number of Seats 5, Fuel Type Petrol, List Price 25000, and Annual Mileage 15000, complete Enter Insurant Data with First Name Alex, Last Name Morgan, Date of Birth 03/12/1990, Country United States, Zip Code 94107, Occupation Employee, and Hobby Skydiving, then complete Enter Product Data with a start date more than one month from today, Insurance Sum 5.000.000,00, Merit Rating Bonus 1, Damage Insurance Full Coverage, Optional Product Euro Protection, and Courtesy Car Yes until Select Price Option is shown.

## Step 2

On Select Price Option, store the current wizard step title as baseline_step before attempting to continue without a plan selection.

## Step 3

On Select Price Option, ensure no offered plan is selected before continuing.

## Step 4 @verifies ac-53, ac-64

On Select Price Option, click Next » with no selected plan, then assert the wizard still shows Select Price Option and zero plans are selected.
