---
assurance:
  id: t-3
  base: sha256:360c72a20c898925a620d61a9f610a46da46efb5a46484c51f7dc526081acaec
---
# Block advancement when shared required vehicle values are missing or out of range

> Prove that the wizard does not advance when a shared required vehicle field is omitted or falls outside its documented range.

## Step 1

Open https://sampleapp.tricentis.com/101/# and start an Automobile quote so the public quote wizard shows the Enter Vehicle Data step.

## Step 2 @verifies ac-8

On the Automobile Enter Vehicle Data step, leave Make unselected and fill Engine Performance with 120, Date of Manufacture with 01/15/2020, Number of Seats with 5, Fuel Type with Petrol, List Price with 25000, and Annual Mileage with 15000, then click Next and assert the wizard still shows Enter Vehicle Data instead of Enter Insurant Data.

## Step 3 @verifies ac-9

On the same Automobile Enter Vehicle Data step, set Make to Audi and set Engine Performance to 0 while keeping Number of Seats 5, Fuel Type Petrol, Date of Manufacture 01/15/2020, List Price 25000, and Annual Mileage 15000, then click Next and assert the wizard still shows Enter Vehicle Data instead of Enter Insurant Data.

## Step 4 @verifies ac-9

On the same Automobile Enter Vehicle Data step, keep the other fields valid and change Engine Performance to 2001, then click Next and assert the wizard still shows Enter Vehicle Data instead of Enter Insurant Data.

## Step 5 @verifies ac-10

On the same Automobile Enter Vehicle Data step, restore Engine Performance to 120 and set Date of Manufacture to tomorrow's date in MM/DD/YYYY format while keeping the other fields valid, then click Next and assert the wizard still shows Enter Vehicle Data instead of Enter Insurant Data.

## Step 6 @verifies ac-11

On the same Automobile Enter Vehicle Data step, restore Date of Manufacture to 01/15/2020 and set List Price to 499 while keeping the other fields valid, then click Next and assert the wizard still shows Enter Vehicle Data instead of Enter Insurant Data.

## Step 7 @verifies ac-11

On the same Automobile Enter Vehicle Data step, keep the other fields valid and change List Price to 100001, then click Next and assert the wizard still shows Enter Vehicle Data instead of Enter Insurant Data.

## Step 8 @verifies ac-12

On the same Automobile Enter Vehicle Data step, restore List Price to 25000 and set Annual Mileage to 99 while keeping the other fields valid, then click Next and assert the wizard still shows Enter Vehicle Data instead of Enter Insurant Data.

## Step 9 @verifies ac-12

On the same Automobile Enter Vehicle Data step, keep the other fields valid and change Annual Mileage to 100001, then click Next and assert the wizard still shows Enter Vehicle Data instead of Enter Insurant Data.
