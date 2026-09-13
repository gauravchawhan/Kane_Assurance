---
assurance:
  id: t-8
  base: sha256:d56eb70a436c30f8b8a13d5bf6514d608e98fb28defe96fb66031a20a91164ce
---
# Stay on Enter Insurant Data when required applicant input is missing

> Prove the wizard blocks progress when any required applicant field is omitted or no hobby is selected.

## Step 1

Open https://sampleapp.tricentis.com/101/app.php and complete the Automobile Enter Vehicle Data step with Make Audi, Engine Performance 120, Date of Manufacture 01/15/2020, Number of Seats 5, Fuel Type Petrol, List Price 25000, and Annual Mileage 15000 so the public quote wizard shows Enter Insurant Data.

## Step 2 @verifies ac-39, ac-26

On Enter Insurant Data, prepare a valid applicant set with Last Name Morgan, Date of Birth 03/12/1990, Gender Male, Country United States, Zip Code 94107, Occupation Employee, Hobby Skydiving, and Street Address, City, Website, and Picture empty, then leave First Name empty and click Next, then assert the wizard still shows Enter Insurant Data.

## Step 3 @verifies ac-27

On Enter Insurant Data, prepare a valid applicant set with First Name Alex, Date of Birth 03/12/1990, Gender Male, Country United States, Zip Code 94107, Occupation Employee, Hobby Skydiving, and Street Address, City, Website, and Picture empty, then leave Last Name empty and click Next, then assert the wizard still shows Enter Insurant Data.

## Step 4 @verifies ac-24

On Enter Insurant Data, prepare a valid applicant set with First Name Alex, Last Name Morgan, Gender Male, Country United States, Zip Code 94107, Occupation Employee, Hobby Skydiving, and Street Address, City, Website, and Picture empty, then leave Date of Birth empty and click Next, then assert the wizard still shows Enter Insurant Data.

## Step 5 @verifies ac-28

On Enter Insurant Data, prepare a valid applicant set with First Name Alex, Last Name Morgan, Date of Birth 03/12/1990, Gender Male, Zip Code 94107, Occupation Employee, Hobby Skydiving, and Street Address, City, Website, and Picture empty, then leave Country unselected and click Next, then assert the wizard still shows Enter Insurant Data.

## Step 6 @verifies ac-29

On Enter Insurant Data, prepare a valid applicant set with First Name Alex, Last Name Morgan, Date of Birth 03/12/1990, Gender Male, Country United States, Occupation Employee, Hobby Skydiving, and Street Address, City, Website, and Picture empty, then leave Zip Code empty and click Next, then assert the wizard still shows Enter Insurant Data.

## Step 7 @verifies ac-31

On Enter Insurant Data, prepare a valid applicant set with First Name Alex, Last Name Morgan, Date of Birth 03/12/1990, Gender Male, Country United States, Zip Code 94107, Hobby Skydiving, and Street Address, City, Website, and Picture empty, then leave Occupation unselected and click Next, then assert the wizard still shows Enter Insurant Data.

## Step 8 @verifies ac-33

On Enter Insurant Data, prepare a valid applicant set with First Name Alex, Last Name Morgan, Date of Birth 03/12/1990, Gender Male, Country United States, Zip Code 94107, Occupation Employee, and Street Address, City, Website, and Picture empty, then leave all Hobby checkboxes unselected and click Next, then assert the wizard still shows Enter Insurant Data.
