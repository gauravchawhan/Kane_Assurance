---
assurance:
  id: t-12
  base: sha256:263d6cf286607688fc07592395df82bfa25c8e9b76864f0cb9258fe13a6d9e68
---
# Return to Enter Insurant Data with values preserved from Enter Product Data

> Prove that using « Prev from Enter Product Data returns to Enter Insurant Data and preserves the applicant values already entered on the previous step.

## Step 1

Open https://sampleapp.tricentis.com/101/app.php and complete the Automobile Enter Vehicle Data step with Make Audi, Engine Performance 120, Date of Manufacture 01/15/2020, Number of Seats 5, Fuel Type Petrol, List Price 25000, Annual Mileage 15000, then complete Enter Insurant Data with First Name Alex, Last Name Morgan, Date of Birth 03/12/1990, Country United States, Zip Code 94107, Occupation Employee, and Hobby Skydiving so the public quote wizard shows Enter Product Data.

## Step 2

On Enter Product Data, enter a Start Date 40 days from today, select Insurance Sum 5.000.000,00, Merit Rating Bonus 1, Damage Insurance Full Coverage, select Optional Product Euro Protection, select Courtesy Car Yes, and store the current wizard step title as baseline_step.

## Step 3 @verifies ac-49, ac-50

On Enter Product Data, click « Prev to return to the previous step, then assert the wizard shows Enter Insurant Data and the First Name, Last Name, Date of Birth, Country, Zip Code, Occupation, and Hobby values still show Alex, Morgan, 03/12/1990, United States, 94107, Employee, and Skydiving.

## Step 4 @verifies ac-52

On Enter Insurant Data, click Next to return to Enter Product Data, then assert Start Date, Insurance Sum, Merit Rating, Damage Insurance, Optional Product Euro Protection, and Courtesy Car still show the previously entered values.
