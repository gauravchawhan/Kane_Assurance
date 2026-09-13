---
assurance:
  id: t-5
  base: sha256:164723f77ee12aa1e82b9e2d51dc92b87a04dcd6f45e80be776eb815ef594a6a
---
# Advance from Automobile vehicle data with valid required values

> Prove that an Automobile quote advances from Enter Vehicle Data when the shared required fields plus Automobile-specific Number of Seats and Fuel Type are valid.

## Step 1

Open https://sampleapp.tricentis.com/101/# and start an Automobile quote so the public quote wizard shows the Enter Vehicle Data step.

## Step 2

On the Automobile Enter Vehicle Data step, store the current wizard step title as baseline_step.

## Step 3 @verifies ac-13

On the same step, open the Make dropdown and inspect its choices, then assert Audi, BMW, Ford, Honda, Mazda, Mercedes Benz, Nissan, Opel, Porsche, Renault, Skoda, Suzuki, Toyota, Volkswagen, and Volvo are listed.

## Step 4 @verifies ac-20

On the Automobile Enter Vehicle Data step, inspect the Fuel Type field choices, then assert Petrol, Diesel, Electric Power, Gas, and Other are listed.

## Step 5 @verifies ac-7, ac-14

On the Automobile Enter Vehicle Data step, leave License Plate Number empty, enter Make Audi, Engine Performance 120, Date of Manufacture 01/15/2020, Number of Seats 5, Fuel Type Petrol, List Price 25000, and Annual Mileage 15000, then click Next and assert the wizard shows Enter Insurant Data.
