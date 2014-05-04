#!/bin/bash

# wgetit

# Demo:
# ./wgetit.bash

# Quandl:
# http://www.quandl.com/YAHOO/INDEX_GSPC-S-P-500-Index
# http://ichart.finance.yahoo.com/table.csv?s=%5EGSPC&a=1&b=1&c=1902&d=07&e=4&f=2039&g=d&ignore=.csv


export TKRH='%5EGSPC'
export TKR='GSPC'

cd /tmp/

rm -f ${TKR}.csv
wget --output-document=${TKR}.csv  http://ichart.finance.yahoo.com/table.csv?s=${TKRH} 

grep -v Date ${TKR}.csv > mydata.csv

ls -la mydata.csv

exit
