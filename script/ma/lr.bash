#!/bin/bash

# ~/spy611/script/ma/lr.bash
# Demo:
# ~/spy611/script/ma/lr.bash 2000
if [ $# -lt 1 ]
then
  echo You need to give a year
  echo Demo:
  echo $0 2014
  exit 1
fi

# Run Logistic Regression
./psqlmad.bash -f ~/spy611/script/ma/oos_is.sql -v yr="'$1'"
./psqlmad.bash -f ~/spy611/script/ma/lr.sql
./psqlmad.bash -f ~/spy611/script/backtests/accumulate_np.sql -v algo="'gbm'"

exit

