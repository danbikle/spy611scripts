#!/bin/bash

# ~/spy611/script/backtests/backtests_x.bash

# Demo:
# ~/spy611/script/backtests/backtests_x.bash gbm

# I use this script to run 3 other scripts to 
# run backtests and then report results into erbfiles.

# This script is called by 
# ~/spy611/script/backtests/night.bash

if [ $# -lt 1 ]
then
  echo You need to give an Algo
  echo Demo:
  echo $0 gbm
  exit 1
fi

ALGO=$1

# cd to the right place
cd ~/spy611/script/backtests

# This script depends on:
# ./psqlmad.bash -f ~/spy611/script/cr_my_vectors.sql
# I could call cr_my_vectors.sql now or by 
# ~/spy611/script/backtests/night.bash

THISYR=`date +"%Y"`
for YR in {1975..2029}
do
  if [ $YR -le $THISYR ]
  then
    ./bt_x_yr.bash $YR $ALGO
  fi
done

# Fill the /bt_x/allyears report:
./bt_x_all.bash $ALGO

for DAYSPAST in 30 60 120 365 730
do
  ./bt_x_dp.bash $DAYSPAST $ALGO
done

exit
