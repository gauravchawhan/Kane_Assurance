---
assurance:
  id: t-4
  base: sha256:12e43bd15fac8fecc4d6d158318748c0f8cc3fe4ea6c071c938c46b8546d67dd
---
# Advance from Motorcycle vehicle data with valid required values

> Prove that a Motorcycle quote advances from Enter Vehicle Data when the shared required fields plus Motorcycle-specific Model, Cylinder Capacity, and Number of Seats are valid.

## Step 1

Open https://sampleapp.tricentis.com/101/# and start a Motorcycle quote so the public quote wizard shows the Enter Vehicle Data step.

## Step 2

On the Motorcycle Enter Vehicle Data step, store the current wizard step title as baseline_step.

## Step 3 @verifies ac-13

On the same step, open the Make dropdown and inspect its choices, then assert Audi, BMW, Ford, Honda, Mazda, Mercedes Benz, Nissan, Opel, Porsche, Renault, Skoda, Suzuki, Toyota, Volkswagen, and Volvo are listed.

## Step 4 @verifies ac-18

On the Motorcycle Enter Vehicle Data step, inspect the Model field choices, then assert Scooter, Three-Wheeler, Moped, and Motorcycle are listed.

## Step 5 @verifies ac-7, ac-14

On the Motorcycle Enter Vehicle Data step, leave License Plate Number empty, enter Make Audi, Engine Performance 120, Date of Manufacture 01/15/2020, Model Scooter, Cylinder Capacity 500, Number of Seats 2, List Price 25000, and Annual Mileage 15000, then click Next and assert the wizard shows Enter Insurant Data.
