#!/bin/bash

# ~/spy611/script/backtests/bt_x2lr_yr.bash

# Demo:
# ~/spy611/script/backtests/bt_x2lr_yr.bash 2014 gbm

# This script is called by:
# ~/spy611/script/backtests/backtests_x2lr.bash

# I use this script to do 3 things:

# 1. Collect data for MADlib Logistic Regression (from my_vectors_wide)
# 2. Run MADlib Logistic Regression, collect results.
# 3. Redirect report results into erb files

# Example erb file:
# ~/spy611/app/views/bt_lr2lr_yr/_bt2014.erb

# Example route which corresponds to these erb files:
# get "bt_lr2lr_yr/:yr" => "bt_lr2lr_yr#index"

# The intent behind the erb files is to show the end-user
# how well my MADlib model predicted ups and downs
# for a specific year after I trained the model
# with observations from previous years.

# This script depends on vectors in my_vectors_wide which contain 'initial predictions'.
# I use ~/spy611/script/backtests/bt_x_yr.bash
# to collect these predictions.

if [ $# -lt 2 ]
then
  echo You need to give a Year and an Algo
  echo Demo:
  echo $0 2014 gbm
  exit 1
fi

# cd to the right place
cd ~/spy611/script/backtests/

export YR=$1
export ALGO=$2
export ERBFILE=~/spy611/app/views/bt_${ALGO}2lr_yr/_bt${YR}.erb
echo About to create an erb file:
echo $ERBFILE

# Collect data for MADlib (from my_vectors_wide)
./psqlmad.bash -f cr_x2lr_oos_is.sql -v yr="'$YR'"

# Run MADlib
~/spy611/script/lr.bash

# Redirect report results into erb files
./rpt2erb4algo.bash $ERBFILE rpt_lr.sql

# Also,
# Accumulate results in 'next' predictions tables.
# I report on them later.
./psqlmad.bash -f accumulate_np.sql -v algo="'${ALGO}'"

echo "$0 just ran ./rpt2erb4algo.bash $ERBFILE rpt_lr.sql"
echo "$0 just ran"

exit
