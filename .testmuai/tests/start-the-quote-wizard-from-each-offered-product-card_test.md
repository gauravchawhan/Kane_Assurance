---
assurance:
  id: t-1
  base: sha256:bc05de0d168c26d1492b0961cd4e5e1c9ab0b2ee1ceacdbcb52258769c692612
---
# Start the quote wizard from each offered product card

> Prove that selecting each offered product from the home-page catalogue opens the quote wizard on the Enter Vehicle Data step for the matching product.

## Step 1

Open https://sampleapp.tricentis.com/101/# in a fresh browser session and store that the Vehicle Insurance Application home page is the public catalogue before a quote is started as baseline_catalogue_state.

## Step 2 @verifies ac-1, ac-5

On the Vehicle Insurance Application home page at https://sampleapp.tricentis.com/101/#, start a quote from the Automobile, Truck, Motorcycle, and Camper product cards one at a time, returning to the home-page catalogue between runs, then assert each run opens the matching product's quote wizard on the Enter Vehicle Data step and the wizard navigation shows Automobile, Truck, Motorcycle, and Camper.
