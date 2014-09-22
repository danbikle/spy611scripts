#!/bin/bash

# /a/ks/b/matlab/panera23/wgetspy.bash

cd data/

export TKR='SPY'

rm -f ${TKR}.csv
wget --output-document=${TKR}.csv  http://ichart.finance.yahoo.com/table.csv?s=${TKR}

exit
