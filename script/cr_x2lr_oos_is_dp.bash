#!/bin/bash

# ~/spy611/script/cr_x2lr_oos_is_dp.bash

# I use this script to create both out-of-sample and in-sample data from my_vectors_ip

# Demo:
# ~/spy611/script/cr_x2lr_oos_is_dp.bash 15

# This script is called by:
# ~/spy611/script/pred_x2lr.bash
# and:
# ~/spy611/script/backtests/bt_x2lr_dp.bash

if [ $# -lt  ]
then
  echo You need to give an integer of days past
  echo Demo:
  echo $0 30
  exit 1
fi

cd ~/spy611/script/

DAYSPAST=$1

./psqlmad.bash -f cr_x2lr_oos_is_dp.sql -v dayspast="$DAYSPAST"

exit
