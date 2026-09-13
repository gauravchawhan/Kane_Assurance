# Feature Spec: Vehicle Insurance Quote

**Sector:** Insurance
**Target application:** https://sampleapp.tricentis.com/101/#

## Background

The Tricentis Vehicle Insurance Application (Version 1.0.1) is a public
sample used to practise end-to-end insurance quoting. A visitor picks a
vehicle type, describes the vehicle and themselves, chooses a cover, then
selects a priced plan and e-mails the quote. There is no login. This spec
covers the four moments that make the quote real: choosing a product,
describing the vehicle, describing the applicant and the cover, and sending
the priced quote.

## Requirements

### R1 — Visitor can start an automobile quote from the home page

From the site's home page, a visitor can see the four insurance products
(Automobile, Truck, Motorcycle, Camper) and start an Automobile quote. The
quote wizard opens on the **Enter Vehicle Data** step.

### R2 — Applicant can complete vehicle data and proceed

On **Enter Vehicle Data** for an Automobile, an applicant can enter a make,
engine performance, a past date of manufacture, number of seats, fuel type,
list price, and annual mileage that satisfy the form's published ranges.
Clicking **Next »** advances the wizard to **Enter Insurant Data**. Leaving
a required vehicle field empty keeps the wizard on **Enter Vehicle Data**.

### R3 — Applicant can complete insurant and product data and see prices

An applicant who has completed vehicle data can enter insurant details
(name, a date of birth that makes them 18–70, country, zip code, occupation,
at least one hobby) and product details (a start date more than one month
in the future, insurance sum, merit rating, damage insurance, at least one
optional product, courtesy car). After **Next »** the **Select Price Option**
step shows Silver, Gold, Platinum, and Ultimate with a price per year.

### R4 — Applicant can select a plan and send the quote

From **Select Price Option**, an applicant can choose one plan (Silver,
Gold, Platinum, or Ultimate) and continue to **Send Quote**. After entering
a valid e-mail, username, password, and matching confirm password, clicking
**« Send »** submits the quote and the application confirms the send.
