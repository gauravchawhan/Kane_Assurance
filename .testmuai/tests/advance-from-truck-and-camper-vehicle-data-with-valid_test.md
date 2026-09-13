---
assurance:
  id: t-6
  base: sha256:3dca6ab7010258b90d212c19605794634187184136ee91311b455e81f4c65ade
---
# Advance from Truck and Camper vehicle data with valid required values

> Prove that a Truck or Camper quote advances from Enter Vehicle Data when the shared required fields plus Payload and Total Weight are valid.

## Step 1

Open https://sampleapp.tricentis.com/101/# and start a Truck quote so the public quote wizard shows the Enter Vehicle Data step.

## Step 2

On the Truck Enter Vehicle Data step, store the current wizard step title as truck_baseline_step.

## Step 3 @verifies ac-13

On the same Truck step, open the Make dropdown and inspect its choices, then assert Audi, BMW, Ford, Honda, Mazda, Mercedes Benz, Nissan, Opel, Porsche, Renault, Skoda, Suzuki, Toyota, Volkswagen, and Volvo are listed.

## Step 4 @verifies ac-7, ac-14

On the Truck Enter Vehicle Data step, leave License Plate Number empty, enter Make Audi, Engine Performance 120, Date of Manufacture 01/15/2020, Payload 500, Total Weight 2000, List Price 25000, and Annual Mileage 15000, then click Next and assert the wizard shows Enter Insurant Data.

## Step 5

Open https://sampleapp.tricentis.com/101/# again and start a Camper quote so the public quote wizard shows the Enter Vehicle Data step.

## Step 6 @verifies ac-7, ac-14

On the Camper Enter Vehicle Data step, leave License Plate Number empty, enter Make Audi, Engine Performance 120, Date of Manufacture 01/15/2020, Payload 500, Total Weight 2000, List Price 25000, and Annual Mileage 15000, then click Next and assert the wizard shows Enter Insurant Data.
