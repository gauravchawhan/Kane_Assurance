# Tricentis Vehicle Insurance — Portal Guide

Welcome to the Vehicle Insurance Application documentation. This guide describes
the live sample application at
[https://sampleapp.tricentis.com/101/#](https://sampleapp.tricentis.com/101/#)
(Version 1.0.1). No login is required. Every field, label, and validation rule
below was taken from the running application — nothing here is assumed.

---

## Portal Access

- **Website URL:** [Vehicle Insurance Application](https://sampleapp.tricentis.com/101/#)
- **Quote wizard:** [https://sampleapp.tricentis.com/101/app.php](https://sampleapp.tricentis.com/101/app.php)
- **Authentication:** none — the quote flow is public
- **Branding:** the header shows the Tricentis logo, the title
  **Vehicle Insurance Application**, and the subtitle
  `This is a sample application, Version 1.0.1`

---

## Core Features & Workflow

### 1. Choose an insurance product from the home page

The home page is the catalogue of insurance products a visitor can quote.

- **Products offered:** Automobile, Truck, Motorcycle, Camper.
- Each product is presented as a card titled **Get your `<product>` Insurance**
  with a **Get a quote** action.
- The same four products appear in the top navigation once the visitor is
  inside the quote wizard (`Automobile`, `Truck`, `Motorcycle`, `Camper`).
- **Action:** open the home page, pick a product (Automobile is the primary
  path documented below), and land on the **Enter Vehicle Data** step of the
  quote wizard.

### 2. Enter vehicle data

The first wizard step is titled **Enter Vehicle Data**. The fields that are
visible depend on the product, but they all live on the same form.

**Fields shared by every product**

| Field | Control | Rule on the live form |
|---|---|---|
| Make | dropdown | required; options include Audi, BMW, Ford, Honda, Mazda, Mercedes Benz, Nissan, Opel, Porsche, Renault, Skoda, Suzuki, Toyota, Volkswagen, Volvo |
| Engine Performance [kW] | text | required; integer range 1–2000 |
| Date of Manufacture | date (`MM/DD/YYYY`) | required; must be today or in the past |
| List Price [$] | text | required; range 500–100000 |
| License Plate Number | text | optional; at most 10 characters |
| Annual Mileage [mi] | text | required; range 100–100000 |

**Product-specific fields**

| Product | Extra fields | Rule |
|---|---|---|
| Automobile | Number of Seats, Fuel Type | seats 1–9; fuel is Petrol, Diesel, Electric Power, Gas, or Other |
| Motorcycle | Model, Cylinder Capacity [ccm], Right Hand Drive, Number of Seats (motorcycle) | model is Scooter / Three-Wheeler / Moped / Motorcycle; capacity 1–2000; seats 1–3 |
| Truck / Camper | Payload [kg], Total Weight [kg] | payload 1–1000; total weight 100–50000 |

- **Action:** fill the required fields for the chosen product and click
  **Next »** (`Next (Enter Insurant Data)`).
- **Negative path:** leaving a required field empty, or entering a value
  outside the documented range, keeps the visitor on **Enter Vehicle Data**.
  The wizard does not advance.

### 3. Enter insurant data and product data

**Enter Insurant Data** collects the applicant.

| Field | Control | Rule on the live form |
|---|---|---|
| First Name | text | required; a name |
| Last Name | text | required; a name |
| Date of Birth | date (`MM/DD/YYYY`) | required; applicant must be between 18 and 70 years of age |
| Gender | radio | Male or Female |
| Street Address | text | optional; at least 3 characters when provided |
| Country | dropdown | required |
| Zip Code | text | required; digits |
| City | text | optional |
| Occupation | dropdown | required; Employee, Public Official, Farmer, Unemployed, Selfemployed |
| Hobbies | checkboxes | at least one of Speeding, Bungee Jumping, Cliff Diving, Skydiving, Other |
| Website | text | optional; a URL when provided |
| Picture | file | optional; `.jpg` or `.png` |

**Enter Product Data** collects the cover the applicant wants.

| Field | Control | Rule on the live form |
|---|---|---|
| Start Date | date (`MM/DD/YYYY`) | required; must be more than one month in the future |
| Insurance Sum [$] | dropdown | required; 3.000.000,00 through 35.000.000,00 |
| Merit Rating | dropdown | required; Super Bonus, Bonus 1–9, or Malus 10–17 |
| Damage Insurance | dropdown | required; No Coverage, Partial Coverage, or Full Coverage |
| Optional Products | checkboxes | at least one of Euro Protection, Legal Defense Insurance |
| Courtesy Car | dropdown | required; Yes or No |

- **Action:** complete both steps with **Next »**. After product data is
  accepted the wizard shows **Select Price Option**.
- Each step also offers **« Prev** to return to the previous step without
  losing the entered values.

### 4. Select a price option and send the quote

**Select Price Option** shows a price table with four plans: **Silver**,
**Gold**, **Platinum**, **Ultimate**. Each plan shows a **Price per Year ($)**.
The table is only populated after the first three steps are complete — the
page itself says *Please, complete the first three steps to see the price table.*

- The applicant must select exactly one plan (Silver / Gold / Platinum /
  Ultimate) before continuing.
- **View Quote** and **Download Quote** produce a PDF of the current quote.
- **Action:** select a plan and click **Next »** to reach **Send Quote**.

**Send Quote** collects contact details and submits the quote by e-mail.

| Field | Control | Rule on the live form |
|---|---|---|
| E-Mail | email | required; a valid e-mail address |
| Phone | text | optional; digits |
| Username | text | required |
| Password | password | required |
| Confirm Password | password | required; must equal Password |
| Comments | textarea | optional; at most 300 characters |

- **Action:** fill the required fields and click **« Send »**
  (`Send E-Mail`). A successful send is confirmed in the UI. After a send
  the applicant can return to the **Main page** or start a new Automobile,
  Truck, Motorcycle, or Camper quote.

---

## Quick Reference Summary

| Module | Action | Description |
| :--- | :--- | :--- |
| **Catalogue** | Choose product | Open the home page and start a quote for Automobile, Truck, Motorcycle, or Camper. |
| **Vehicle** | Enter vehicle data | Complete the product-specific vehicle form and advance only when required fields are valid. |
| **Applicant** | Enter insurant + product data | Identify the applicant and the cover they want. |
| **Quote** | Select plan + send | Pick Silver / Gold / Platinum / Ultimate and e-mail the quote. |

---

## Known sample values (public, not secrets)

These values satisfy the live validation rules and are safe to use in tests:

- Make: `Audi`
- Engine Performance: `120`
- Date of Manufacture: a past date such as `01/15/2020`
- Number of Seats: `5`
- Fuel Type: `Petrol`
- List Price: `25000`
- Annual Mileage: `15000`
- First / Last Name: `Alex` / `Morgan`
- Date of Birth: an age between 18 and 70, e.g. `03/12/1990`
- Country: `United States`
- Zip Code: `94107`
- Occupation: `Employee`
- Hobby: `Skydiving`
- Start Date: more than one month from today
- Insurance Sum: `5.000.000,00`
- Merit Rating: `Bonus 1`
- Damage Insurance: `Full Coverage`
- Optional Product: `Euro Protection`
- Courtesy Car: `Yes`
- Price option: `Gold`
- E-Mail: `alex.morgan@example.com`
- Username / Password: `alexmorgan` / `Quote1!`
