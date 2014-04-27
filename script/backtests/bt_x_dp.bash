#!/bin/bash

# ~/spy611/script/backtests/bt_x_dp.bash

# Demo:
# ~/spy611/script/backtests/bt_x_dp.bash 30 gbm

# This script is called by:
# ~/spy611/script/backtests/backtests_x.bash

# This script assumes my logistic regression scripts
# ran a short while ago and the data I need is
# in a table called my_vectors.

# I use this script to do 3 things:

# 1. Collect in-sample,out-of-sample data from my_vectors
# 2. Learn from in-sample-data. Predict out-of-sample-data, collect results.
# 3. Redirect report results into erb files

# Example erb file:
# app/views/bt_ab_dp/_dp30.erb

# Example route which corresponds to these erb files:
# get "bt_ab_dp/:dp" => "bt_ab#index"

# The intent behind the erb files is to show the end-user
# how well my algo-model predicted ups and downs
# over the past 30, 60, 120, 365, 730 days

if [ $# -lt 2 ]
then
  echo You need to give an integer of days past and algo
  echo Demo:
  echo $0 30 gbm
  exit 1
fi

# cd to the right place
cd ~/spy611/script/

export DAYSPAST=$1
export ALGO=$2
export ERBFILE=~/spy611/app/views/bt_${ALGO}_dp/_dp${DAYSPAST}.erb

# Collect in-sample,out-of-sample data from my_vectors
./psqlmad.bash -f cr_${ALGO}_oos_is_dp.sql -v dayspast="${DAYSPAST}"

# Train and predict:
./${ALGO}.bash

# Redirect report results into erb files
~/spy611/script/backtests/rpt2erb4algo.bash $ERBFILE rpt_${ALGO}.sql

echo "$0 just ran ./rpt2erb4algo.bash $ERBFILE rpt_${ALGO}.sql"
echo "$0 just ran"

exit
