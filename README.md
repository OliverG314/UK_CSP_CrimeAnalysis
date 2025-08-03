# UK_CSP_CrimeAnalysis
R code to explore trends in community safety partnerships (CSP) in the UK

# Overview
The R code in this repository allows for the exploration of CSP crime data in the UK from the 2002/03 FY to the 2024/25 FY.

# Data sources
https://www.gov.uk/government/statistical-data-sets/police-recorded-crime-and-outcomes-open-data-tables, under the "Police record crime open data, Police force area tables" section.

# Combining and cleaning the data
The dataset used in R is a combination of 4 datasets downloaded from the link above. The python file ```datawriter.py``` combines these 4 datasets into 1.

Cleaning the data is done in R, and involves the renaming of columns that weren't consistent over time. Aside from this, the data was generally consistent

# Visualisations

There are 2 plots that can be generated to explore the data:
- 1 location, multiple crimes
- 1 crime, multiple locations

## 1 location, multiple crimes
<img width="1767" height="861" alt="image" src="https://github.com/user-attachments/assets/81d11c4b-15cc-43fd-9004-e0b83346e6e5" />
