---
assurance:
  id: t-15
  base: sha256:7cf0e4d46275471c3f904a74aa25ef833fcefdd4fe75c56540bcee3908a5e113
---
# Show the gating message before the first three steps are complete

> Prove that before vehicle, insurant, and product data are complete, Select Price Option shows its gating message and the table remains unpopulated.

## Step 1

Open https://sampleapp.tricentis.com/101/app.php for an Automobile quote and leave the first three wizard steps incomplete on Enter Vehicle Data.

## Step 2 @verifies ac-58, ac-59

Without completing Enter Vehicle Data, open the Select Price Option step in the quote wizard, then assert the page shows Please, complete the first three steps to see the price table. and the price table shows no populated plan row.
