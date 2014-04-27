#!/bin/bash

echo use bt.bash instead of $0
exit

# ~/spy611/script/ma/night.bash

# I use this script to generate predictions.

cd ~/spy611/script/ma/

./psqlmad.bash -f ~/spy611/script/ma/cr_my_vectors.sql

# Collect initial predictions so I can widen my vectors:
./ip_gbm.bash 2014

# Widen my vectors.
# Leverage an earlier script to create some convenient join tables:
# ./psqlmad.bash -f ~/spy611/script/cr_my_vectors_ip.sql
./psqlmad.bash -f ~/spy611/script/ma/cr_my_vectors_wide.sql

# Run Logistic Regression
# ./psqlmad.bash -f ~/spy611/script/ma/oos_is.sql -v yr="'2014'"
# ./psqlmad.bash -f ~/spy611/script/ma/lr.sql
~/spy611/script/ma/lr.bash 2014

exit
