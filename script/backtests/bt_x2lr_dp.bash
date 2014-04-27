#!/bin/bash

# ~/spy611/script/backtests/bt_x2lr_dp.bash

# Demo:
# ~/spy611/script/backtests/bt_x2lr_dp.bash 30 gbm

# This script is called by:
# ~/spy611/script/backtests/backtests_x2lr.bash

# I use this script to do 3 things:

# 1. Collect data for MADlib (from my_vectors_wide)
# 2. Run MADlib, collect results.
# 3. Redirect report results into erb files

# Example erb file:
# app/views/bt_lr2lr_dp/_dp30.erb

# Example route which corresponds to these erb files:
# get "bt_lr2lr_dp/:dp" => "bt_lr2lr#index"

# The intent behind the erb files is to show the end-user
# how well my model predicted ups and downs
# over the past 30, 60, 120, 365, 730 days

if [ $# -lt 2 ]
then
  echo You need to give an integer of days past and an algo
  echo Demo:
  echo $0 30 gbm
  exit 1
fi

# cd to the right place
cd ~/spy611/script/

export DAYSPAST=$1
export ALGO=$2
export ERBFILE=~/spy611/app/views/bt_${ALGO}2lr_dp/_dp${DAYSPAST}.erb
echo About to create an erb file:
echo $ERBFILE

# Collect data for MADlib (from my_vectors_wide)
./psqlmad.bash -f cr_x2lr_oos_is_dp.sql -v dayspast="${DAYSPAST}"

# Run MADlib
~/spy611/script/lr.bash

# Redirect report results into erb files
~/spy611/script/backtests/rpt2erb4algo.bash $ERBFILE rpt_lr.sql

echo "$0 just ran ./rpt2erb4algo.bash $ERBFILE rpt_lr.sql"
echo "$0 just ran"

exit
