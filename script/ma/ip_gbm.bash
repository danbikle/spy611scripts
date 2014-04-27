#!/bin/bash

# ~/spy611/script/ma/ip_gbm.bash

# I use this script to collect initial gbm predictions.
# This script is called by ~/spy611/script/ma/night.bash

if [ $# -lt 1 ]
then
  echo You need to give a year
  echo Demo:
  echo $0 2014
  exit 1
fi

cd ~/spy611/script/ma/
./psqlmad.bash -f ~/spy611/script/ma/cr_gbm_oos_is.sql -v yr="'$1'"
~/spy611/script/gbm.py
./psqlmad.bash -f ~/spy611/script/read_gbm_predictions.sql
./psqlmad.bash -f ~/spy611/script/ma/accumulate_ip_gbm.sql

exit



