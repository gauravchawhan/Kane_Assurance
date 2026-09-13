---
assurance:
  id: t-11
  base: sha256:1a3c3b4304638ae5e56e22ebc4d44bbe03d86ba3c59ce03a681fdb72804db648
---
# Stay on Enter Product Data when required coverage input is missing or Start Date is not more than one month ahead

> Prove the wizard blocks progress when any required product field is omitted, no optional product is selected, or Start Date is today, in the past, or within one month from today.

## Step 1

Open https://sampleapp.tricentis.com/101/app.php and complete the Automobile Enter Vehicle Data step with Make Audi, Engine Performance 120, Date of Manufacture 01/15/2020, Number of Seats 5, Fuel Type Petrol, List Price 25000, Annual Mileage 15000, then complete Enter Insurant Data with First Name Alex, Last Name Morgan, Date of Birth 03/12/1990, Country United States, Zip Code 94107, Occupation Employee, and Hobby Skydiving so the public quote wizard shows Enter Product Data.

## Step 2 @verifies ac-42

On Enter Product Data, leave Start Date empty, select Insurance Sum 5.000.000,00, Merit Rating Bonus 1, Damage Insurance Full Coverage, select Optional Product Euro Protection, select Courtesy Car Yes, and click Next, then assert the wizard stays on Enter Product Data.

## Step 3 @verifies ac-43

On Enter Product Data, enter today's date as Start Date with Insurance Sum 5.000.000,00, Merit Rating Bonus 1, Damage Insurance Full Coverage, Optional Product Euro Protection, and Courtesy Car Yes, then click Next and assert the wizard stays on Enter Product Data.

## Step 4 @verifies ac-43

On Enter Product Data, replace Start Date with 01/15/2020 while keeping Insurance Sum 5.000.000,00, Merit Rating Bonus 1, Damage Insurance Full Coverage, Optional Product Euro Protection, and Courtesy Car Yes, then click Next and assert the wizard stays on Enter Product Data.

## Step 5 @verifies ac-43

On Enter Product Data, replace Start Date with a date 15 days from today while keeping Insurance Sum 5.000.000,00, Merit Rating Bonus 1, Damage Insurance Full Coverage, Optional Product Euro Protection, and Courtesy Car Yes, then click Next and assert the wizard stays on Enter Product Data.

## Step 6 @verifies ac-42

On Enter Product Data, enter a Start Date 40 days from today, clear Insurance Sum so no amount is selected, keep Merit Rating Bonus 1, Damage Insurance Full Coverage, Optional Product Euro Protection, and Courtesy Car Yes, then click Next and assert the wizard stays on Enter Product Data.

## Step 7 @verifies ac-42

On Enter Product Data, select Insurance Sum 5.000.000,00, clear Merit Rating so no value is selected, keep Damage Insurance Full Coverage, Optional Product Euro Protection, Courtesy Car Yes, and the valid Start Date, then click Next and assert the wizard stays on Enter Product Data.

## Step 8 @verifies ac-42

On Enter Product Data, select Merit Rating Bonus 1, clear Damage Insurance so no value is selected, keep Insurance Sum 5.000.000,00, Optional Product Euro Protection, Courtesy Car Yes, and the valid Start Date, then click Next and assert the wizard stays on Enter Product Data.

## Step 9 @verifies ac-47

On Enter Product Data, select Damage Insurance Full Coverage, clear all Optional Products so neither Euro Protection nor Legal Defense Insurance is selected, keep Insurance Sum 5.000.000,00, Merit Rating Bonus 1, Courtesy Car Yes, and the valid Start Date, then click Next and assert the wizard stays on Enter Product Data.

## Step 10 @verifies ac-42

On Enter Product Data, reselect Optional Product Euro Protection, clear Courtesy Car so no value is selected, keep Insurance Sum 5.000.000,00, Merit Rating Bonus 1, Damage Insurance Full Coverage, and the valid Start Date, then click Next and assert the wizard stays on Enter Product Data.
