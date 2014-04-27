#!/bin/bash

# ~/spy611/script/backtests/bt_x_all.bash

# Demo:
# ~/spy611/script/backtests/bt_x_all.bash gbm

# This script is called by
# ~/spy611/script/backtests/backtests_x.bash

# I use this script to report a summary of allyears predictions
# to URL-paths like these:
# /bt_ab/allyears
# /bt_gbm/allyears
# ....

if [ $# -lt 1 ]
then
  echo You need to give an Algo
  echo Demo:
  echo $0 gbm
  exit 1
fi

export ALGO=$1
export ERBFILE=~/spy611/app/views/bt_${ALGO}/_allyears.erb

# Redirect report results into erb files
./rpt2erb4algo.bash $ERBFILE rpt_ip_${ALGO}.sql

echo "$0 just ran ./rpt2erb4algo.bash $ERBFILE rpt_ip_${ALGO}.sql"
echo "$0 just ran"

exit
