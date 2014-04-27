#!/bin/bash

# ~/spy611/script/fill_in_missing_prices.bash

# Sometimes Yahoo cannot serve timely prices.
# This is a demo script I use to help me fill in missing prices.

# I intend for the actual script to reside here:
# /tmp/fill_in_missing_prices.bash

# I intend for the actual script to be called by:
# ~/spy611/script/night.bash

# Currently my scripts only care about Date and Close
# I need the other values as placeholders but I dont care about their values:
#    Date,      Open,High,Low, Close,  Volume,    Adj Close
echo 2014-03-20,0.00,0.00,0.00,1872.01,9876543210,0.00 >> ~/tmp/mydata.csv

exit
