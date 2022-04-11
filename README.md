# Complete folder

This repo contains all relevant code that is needed to replicate the work done by Mohammad Sardar Sheikh, Danur Mahendra, and Justin Teng to predict the outcome of the 2020 US elections using a statistical model. Specifically, to predict who would win the election from among Joe Biden and Donald trump. We use 2 datasets to do so. The datasets are too large and we do not have permission to share them so we will include how to access them at the end. 

The repository has folders titled inputs, outputs and scripts. The Scripts are used to read in the data and clean the dataset so that it is in a form that we can analyze and build models on. There are 4 useful scripts. One used to read and clean the survey data (UCLA data), another used to read in and clean the Post-stratification data (ACS dataset), another is used to simulate what the UCLA datset should resemble once we have cleaned it and made it useful for interpretation and analysing, and the final script is used to do the same for the ACS dataset. 

The outputs folder contains both the PDF and the RMD of our analysis. There is a sub folder within the outputs folder which contains the cleaned datasets that we acquire from our scripts.

There is a gitignore file that we use since we cannot upload the original raw datasets (pre-cleaned).
There is a bibliography that contains all relevant references called references.bib

The input folder contains the Raw datasets that we have obtained. you can do the same if you follow the steps:
ACS data from IPUMS:
1. visit https://usa.ipums.org/usa/index.shtml and create an account. 2. Then click on get data and choose the sample year that you want to conduct your analysis (we chose 2020) on. 3. Choose the variables that you want to include in your dataset and then click on 'view cart'and 'Create data extract'. 4. when prompted to choose data format, pick what you prefer (we chose STATA .dta file) and submit the request. 5. you will be emailed a link to the dataset that you can download.

UCLA data from nationscape:
1. visit https://www.voterstudygroup.org/data/nationscape and sign up/in to get access to the data. 2. you will recieve a link to the dataset on your email that you put in. Click on this link and download the zip file that contains all the data (.dta STATA file). 3. Choose a specific week that you prefer and you will have access to that data. 


