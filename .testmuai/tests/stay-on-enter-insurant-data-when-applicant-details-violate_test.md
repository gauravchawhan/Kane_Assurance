---
assurance:
  id: t-9
  base: sha256:040e9c754900f0f10b2639795308e90ae5a8541aa2aba22965b6dc9bff5c0c7f
---
# Stay on Enter Insurant Data when applicant details violate format, type, or range rules

> Prove the wizard blocks progress when Date of Birth, Zip Code, Street Address, Website, or Picture violate the documented validation rules.

## Step 1

Open https://sampleapp.tricentis.com/101/app.php and complete the Automobile Enter Vehicle Data step with Make Audi, Engine Performance 120, Date of Manufacture 01/15/2020, Number of Seats 5, Fuel Type Petrol, List Price 25000, and Annual Mileage 15000 so the public quote wizard shows Enter Insurant Data.

## Step 2 @verifies ac-40, ac-23

On Enter Insurant Data, prepare a valid applicant set with First Name Alex, Last Name Morgan, Date of Birth {{underage_dob}}, Gender Male, Country United States, Zip Code 94107, Occupation Employee, Hobby Skydiving, and Street Address, City, Website, and Picture empty, then click Next, then assert the wizard still shows Enter Insurant Data.

## Step 3 @verifies ac-23

On Enter Insurant Data, prepare a valid applicant set with First Name Alex, Last Name Morgan, Date of Birth {{overage_dob}}, Gender Male, Country United States, Zip Code 94107, Occupation Employee, Hobby Skydiving, and Street Address, City, Website, and Picture empty, then click Next, then assert the wizard still shows Enter Insurant Data.

## Step 4 @verifies ac-25

On Enter Insurant Data, prepare a valid applicant set with First Name Alex, Last Name Morgan, Date of Birth 1990-03-12, Gender Male, Country United States, Zip Code 94107, Occupation Employee, Hobby Skydiving, and Street Address, City, Website, and Picture empty, then click Next, then assert the wizard still shows Enter Insurant Data.

## Step 5 @verifies ac-30

On Enter Insurant Data, prepare a valid applicant set with First Name Alex, Last Name Morgan, Date of Birth 03/12/1990, Gender Male, Country United States, Zip Code 94A07, Occupation Employee, Hobby Skydiving, and Street Address, City, Website, and Picture empty, then click Next, then assert the wizard still shows Enter Insurant Data.

## Step 6 @verifies ac-35

On Enter Insurant Data, prepare a valid applicant set with First Name Alex, Last Name Morgan, Date of Birth 03/12/1990, Gender Male, Street Address ab, Country United States, Zip Code 94107, Occupation Employee, Hobby Skydiving, and City, Website, and Picture empty, then click Next, then assert the wizard still shows Enter Insurant Data.

## Step 7 @verifies ac-36

On Enter Insurant Data, prepare a valid applicant set with First Name Alex, Last Name Morgan, Date of Birth 03/12/1990, Gender Male, Country United States, Zip Code 94107, Occupation Employee, Hobby Skydiving, Website not-a-url, and Street Address, City, and Picture empty, then click Next, then assert the wizard still shows Enter Insurant Data.

## Step 8 @verifies ac-37

On Enter Insurant Data, prepare a valid applicant set with First Name Alex, Last Name Morgan, Date of Birth 03/12/1990, Gender Male, Country United States, Zip Code 94107, Occupation Employee, Hobby Skydiving, and Street Address, City, and Website empty, then upload {{invalid_picture_file}} and click Next, then assert the wizard still shows Enter Insurant Data.
