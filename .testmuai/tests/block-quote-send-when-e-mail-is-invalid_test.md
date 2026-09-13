---
assurance:
  id: t-18
  base: sha256:f0ceb933e7a81666a628826a774e157147be6466b90a70dd904680942eb317f4
---
# Block quote send when E-Mail is invalid

> Prove Send Quote rejects an invalid e-mail address and does not reach a successful-send outcome.

## Step 1

Open https://sampleapp.tricentis.com/101/app.php, start an Automobile quote, complete Enter Vehicle Data with Make Audi, Engine Performance 120, Date of Manufacture 01/15/2020, Number of Seats 5, Fuel Type Petrol, List Price 25000, and Annual Mileage 15000, complete Enter Insurant Data with First Name Alex, Last Name Morgan, Date of Birth 03/12/1990, Country United States, Zip Code 94107, Occupation Employee, and Hobby Skydiving, then complete Enter Product Data with a start date more than one month from today, Insurance Sum 5.000.000,00, Merit Rating Bonus 1, Damage Insurance Full Coverage, Optional Product Euro Protection, and Courtesy Car Yes until Select Price Option is shown.

## Step 2

On Select Price Option, select Gold and click Next » until Send Quote is shown.

## Step 3 @verifies ac-70

On Send Quote, enter E-Mail alex.morgan.example.com, Username alexmorgan, Password Quote1!, and Confirm Password Quote1!, leave Phone and Comments blank, click « Send » (Send E-Mail), then assert no successful-send confirmation is shown.
