These are excel sheets containing data from the Election Assistance Committee's 
Election Administration and Voting Survey specifically section F the section focussed on 
election day turnout. They were downloaded on 6-5-2018 from 
https://www.eac.gov/research-and-data/datasets-codebooks-and-surveys/

Columns of interest are:

F1a - Total number of people in a jurisdiction who participated in the November general 
election of that survey year 

F1b - Total number of people in a jurisdiction who participated in the November general 
election of that survey year who voted at a physical polling place


Note: Each sheet will be slightly modified for usability, I removed the -888888, -999999, 
Not applicable and Not Available entries in the various fields, this is to avoid issues 
with calculations once the data is imported to R.

Note: For the 2012 and 2014 surveys Wisconsin's data is mostly at the precinct level and 
for the 2016 survey at a city and town level therefore for year to year analysis WI is not
particularly useful.