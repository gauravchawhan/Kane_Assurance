# Feature Spec: Vehicle Insurance Quote

**Sector:** Insurance
**Target application:** https://sampleapp.tricentis.com/101/#

## Background

The Tricentis Vehicle Insurance Application (Version 1.0.1) is a public
sample used to practise end-to-end insurance quoting. A visitor picks a
vehicle type, describes the vehicle and themselves, chooses a cover, then
selects a priced plan. There is no login. This spec covers title-style
discovery of a product, the vehicle and applicant forms, and viewing the
generated quote PDF — the send-by-e-mail step has been dropped in this
revision.

## Requirements

### R1 — Visitor can start an automobile quote from the home page

From the site's home page, a visitor can see the four insurance products
(Automobile, Truck, Motorcycle, Camper) and start an Automobile quote. The
home page states that four products are offered, so the visitor knows the
size of the catalogue before choosing. The quote wizard opens on the
**Enter Vehicle Data** step.

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

### R5 — Applicant can view the quote as a PDF

From **Select Price Option**, after a plan is selected, an applicant can
use **View Quote**. A PDF of the current quote is produced so the applicant
can read the priced offer without sending it by e-mail.
