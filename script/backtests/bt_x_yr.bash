#!/bin/bash

# ~/spy611/script/backtests/bt_x_yr.bash

# Demo:
# ~/spy611/script/backtests/bt_x_yr.bash 2014 ab

# This script is called by:
# ~/spy611/script/backtests/backtests_ab.bash

# I use this script to do 3 things:

# 1. Collect in-sample,out-of-sample data from my_vectors
# 2. Learn from in-sample-data. Predict out-of-sample-data, collect results.
# 3. Redirect report results into erb files

# Example erb file:
# ~/spy611/app/views/bt_ab_yr/_bt2014.erb

# Example route which corresponds to these erb files:
# get "bt_ab_yr/:yr" => "bt_ab_yr#index"

# The intent behind the erb files is to show the end-user
# how well my algorithm and model selection predicted ups and downs
# for a specific year after I trained the model
# with observations from previous 25 years.

if [ $# -lt 2 ]
then
  echo You need to give a Year and Algo
  echo Demo:
  echo $0 2014 gbm
  exit 1
fi


# cd to the right place
cd ~/spy611/script/backtests/

export YR=$1
export ALGO=$2
export ERBFILE=~/spy611/app/views/bt_${ALGO}_yr/_bt${YR}.erb

# Collect in-sample,out-of-sample data from my_vectors
./psqlmad.bash -f cr_${ALGO}_oos_is.sql -v yr="'$YR'"

# Train and predict:
~/spy611/script/${ALGO}.bash

# Redirect report results into erb files
./rpt2erb4algo.bash $ERBFILE rpt_${ALGO}.sql

# Also,
# Accumulate results in initial predictions tables
# which are part of an algorithm chain.
# These predictions will become model features of later algorithms.
# Scripts which depend on these predictions are listed below:
# ~/spy611/script/pred_x2lr.bash
# ~/spy611/script/backtests/bt_x2lr_yr.bash
# ~/spy611/script/backtests/bt_x2lr_dp.bash
# ~/spy611/script/backtests/bt_x2lr_all.bash
./psqlmad.bash -f accumulate_ip_${ALGO}.sql

exit
