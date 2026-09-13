---
assurance:
  id: t-17
  base: sha256:1f858dbe068f3a18e7d9e64b51cb1be82c8076e775f54f0dadd8bff7e4a90f80
---
# Block quote send when Confirm Password does not match Password

> Prove Send Quote rejects a mismatched password confirmation and does not reach a successful-send outcome.

## Step 1

Open https://sampleapp.tricentis.com/101/app.php, start an Automobile quote, complete Enter Vehicle Data with Make Audi, Engine Performance 120, Date of Manufacture 01/15/2020, Number of Seats 5, Fuel Type Petrol, List Price 25000, and Annual Mileage 15000, complete Enter Insurant Data with First Name Alex, Last Name Morgan, Date of Birth 03/12/1990, Country United States, Zip Code 94107, Occupation Employee, and Hobby Skydiving, then complete Enter Product Data with a start date more than one month from today, Insurance Sum 5.000.000,00, Merit Rating Bonus 1, Damage Insurance Full Coverage, Optional Product Euro Protection, and Courtesy Car Yes until Select Price Option is shown.

## Step 2

On Select Price Option, select Gold and click Next » until Send Quote is shown.

## Step 3 @verifies ac-69

On Send Quote, enter E-Mail alex.morgan@example.com, Username alexmorgan, Password Quote1!, Confirm Password Quote2!, leave Phone and Comments blank, click « Send » (Send E-Mail), then assert no successful-send confirmation is shown.
