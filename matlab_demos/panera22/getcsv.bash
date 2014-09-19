#!/bin/bash

# /a/ks/b/matlab/panera22/getcsv.bash

# Demo:
# /a/ks/b/matlab/panera22/getcsv.bash

TKR=SPY

date

cd /a/ks/b/matlab/panera22/

# get csv data
mytsu=`date -u +'%Y%m%d %H:%M:%S'`
myts=`date -u +'%Y%m%d_%H_%M_%S'`
echo $mytsu
echo $myts
mkdir -p data/
mkdir -p /tmp/tkrcsv30min/

# Get prices into csv file:
/usr/bin/R -f getcsv.r $TKR USD "${mytsu}" data/${TKR}_${myts}.csv
# Label the columns in the file:
echo 'seconds_since1970, openp, highp, lowp, cp, ignr1, ignr2, ignr3, ignr4' > data/spy_recent.csv
cat data/${TKR}_${myts}.csv >> data/spy_recent.csv

exit

# For matlab, I have what I want.

# For Postgres, copy csv data into format suitable for Postgres:
cat data/${TKR}_${myts}.csv | awk -F, -v tkr=$TKR '{print tkr","$1","$5}' > /tmp/tkrcsv30min/latest.csv

exit

