These are excel sheets containing data from the Election Assistance Committee's 
Election Administration and Voting Survey specifically section D the section focussed on 
precincts and polling locations. They were downloaded on 6-5-2018 from 
https://www.eac.gov/research-and-data/datasets-codebooks-and-surveys/

Columns of interest are:

D1a - the total number of precincts in a jurisdictions for the November general election
of that survey year.

D2a -  total number of physical polling places in a jurisdiction for the
November general election of that survey year. Include physical polling places in 
operation on Election Day and physical polling places in operation before Election Day.

D2b -  Physical polling places other than election offices

D2c - Physical Polling Places that are election offices

D2e - Physical polling places other than election offices for early voting

D2f - Physical Polling Places that are election offices for early voting


Note: Each sheet will be slightly modified for usability, I removed the -888888, -999999, 
Not applicable and Not Available entries in the various fields, this is to avoid issues 
with calculations once the data is imported to R.

Note: For the 2012 and 2014 surveys Wisconsin's data is mostly at the precinct level and 
for the 2016 survey at a city and town level therefore for year to year analysis WI is not
particularly useful.

Note: 
Tennessee and Illinois didn't report the number of physical polling places in the state
for the 2008 EAVS. 
Georgia didn't report Section D data in 2012. 
New Hampshire only reporter 1's and 
0's in 2012. 
Only one Utah county reported numerical data on physical polling places in 
2012.
Virginia appears to have under reported in 2012 as well.
As for Iowa, they did not report the the number of physical polling places to the 2016 
EAVS.