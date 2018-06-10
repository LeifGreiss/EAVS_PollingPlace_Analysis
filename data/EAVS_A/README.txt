These are excel sheets containing data from the Election Assistance Commission’s 
Election Administration and Voting Survey specifically section A which is focussed on 
Voter Registration. They were downloaded on 4-5-2018 and 4-6-2018 from 
https://www.eac.gov/research-and-data/datasets-codebooks-and-surveys/

Columns of interest are:

A1a - Total number of persons in a jurisdiction who were registered and eligible to vote
in the November general election of that survey year. 

A3a - Total number of persons who were registered, active and eligible to vote in the 
November general election of that survey year.

A4a - Total new Same Day registrations.


Note: They have all been slightly modified for usability, I removed the -888888, -999999, 
Not applicable and Not Available entries in the various fields, this is to avoid issues 
with calculations once the data is imported to R.

Note: For the 2012 and 2014 surveys Wisconsin's data is mostly at the precinct level and 
for the 2016 survey at a city and town level therefore for year to year analysis WI is not
particularly useful.

Note: North Dakota did not report the numbers for A1a in any of the EAVS surveys