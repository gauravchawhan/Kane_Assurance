---
assurance:
  id: t-16
  base: sha256:61df83052181270759955a4d20ce494b4460d72f3e0a1c206b71301fe3026e9b
---
# Send the quote successfully with required fields only and return to the Main page

> Prove the applicant can submit Send Quote with only the required valid fields, receive the UI confirmation, observe the available post-send actions, and return to the Main page.

## Step 1

Open https://sampleapp.tricentis.com/101/app.php, start an Automobile quote, complete Enter Vehicle Data with Make Audi, Engine Performance 120, Date of Manufacture 01/15/2020, Number of Seats 5, Fuel Type Petrol, List Price 25000, and Annual Mileage 15000, complete Enter Insurant Data with First Name Alex, Last Name Morgan, Date of Birth 03/12/1990, Country United States, Zip Code 94107, Occupation Employee, and Hobby Skydiving, then complete Enter Product Data with a start date more than one month from today, Insurance Sum 5.000.000,00, Merit Rating Bonus 1, Damage Insurance Full Coverage, Optional Product Euro Protection, and Courtesy Car Yes until Select Price Option is shown.

## Step 2

On Select Price Option, select Gold and click Next » until Send Quote is shown.

## Step 3 @verifies ac-71, ac-73, ac-75, ac-77, ac-78, ac-79, ac-80

On Send Quote, enter E-Mail alex.morgan@example.com, Username alexmorgan, Password Quote1!, and Confirm Password Quote1!, leave Phone and Comments blank, click « Send » (Send E-Mail), then assert the UI shows a successful-send confirmation and offers actions for Main page, Automobile, Truck, Motorcycle, and Camper.

## Step 4 @verifies ac-76

From the successful-send UI, choose the Main page action, then assert the Vehicle Insurance Application home page is displayed.
