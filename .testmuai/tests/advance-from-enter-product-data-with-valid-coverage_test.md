---
assurance:
  id: t-10
  base: sha256:0bb178fc732ce50ac92e4e5fff19258631a567690ff379b715713b80d236d16e
---
# Advance from Enter Product Data with valid coverage selections

> Prove the applicant can complete Enter Product Data with valid coverage selections and continue to Select Price Option.

## Step 1

Open https://sampleapp.tricentis.com/101/app.php and complete the Automobile Enter Vehicle Data step with Make Audi, Engine Performance 120, Date of Manufacture 01/15/2020, Number of Seats 5, Fuel Type Petrol, List Price 25000, Annual Mileage 15000, then complete Enter Insurant Data with First Name Alex, Last Name Morgan, Date of Birth 03/12/1990, Country United States, Zip Code 94107, Occupation Employee, and Hobby Skydiving so the public quote wizard shows Enter Product Data.

## Step 2

On Enter Product Data, store the current wizard step title as baseline_step.

## Step 3 @verifies ac-51

On Enter Product Data, inspect the Start Date field's visible format hint, then assert MM/DD/YYYY is shown for the date entry format.

## Step 4 @verifies ac-44

On Enter Product Data, open the Insurance Sum [$] dropdown and inspect its values, then assert every visible amount stays within the inclusive 3.000.000,00 to 35.000.000,00 range.

## Step 5 @verifies ac-45

On Enter Product Data, open the Merit Rating dropdown and inspect its values, then assert the only visible choices are Super Bonus, Bonus 1 through Bonus 9, and Malus 10 through Malus 17.

## Step 6 @verifies ac-46

On Enter Product Data, open the Damage Insurance dropdown and inspect its values, then assert the only visible choices are No Coverage, Partial Coverage, and Full Coverage.

## Step 7 @verifies ac-48

On Enter Product Data, open the Courtesy Car dropdown and inspect its values, then assert the only visible choices are Yes and No.

## Step 8 @verifies ac-41

On Enter Product Data, enter a Start Date 40 days from today, select Insurance Sum 5.000.000,00, Merit Rating Bonus 1, Damage Insurance Full Coverage, select Optional Product Euro Protection, select Courtesy Car Yes, and click Next, then assert the wizard shows Select Price Option.
