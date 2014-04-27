#!/bin/bash

# ~/spy611/script/backtests/backtests_x2lr.bash

# Demo:
# ~/spy611/script/backtests/backtests_x2lr.bash lr

# This script is called by ~/spy611/script/backtests/night.bash

if [ $# -lt 1 ]
then
  echo You need to give an algo
  echo Demo:
  echo $0 gbm
  exit 1
fi

ALGO=$1

# cd to the right place
cd ~/spy611/script/backtests/

# I need vectors with initial predictions:
# ./psqlmad.bash -f ~/spy611/script/cr_my_vectors_ip.sql
# Call above script from noon.bash or night.bash
./psqlmad.bash -f ~/spy611/script/cr_my_vectors_wide.sql -v algo="'$ALGO'"

# My data starts in 1950.
# In 1975 I have 25 years of data.
# Then, by 2000, I have 25 years of initial predictions (starting in 1975).
# So I start this backtest in 2000:
THISYR=`date +"%Y"`
for YR in {2000..2030}
do
  if [ $YR -le $THISYR ]
  then
    ./bt_x2lr_yr.bash $YR $ALGO
  fi
done

# DAYSPAST report too:
for DAYSPAST in 30 60 120 365 730
do
  ./bt_x2lr_dp.bash $DAYSPAST $ALGO
done

# Fill the /bt_${ALGO}2lr/allyears report:
./bt_x2lr_all.bash $ALGO

exit
