#!/bin/bash

# ~/spy611/script/cr_ab_oos_is_dp.bash

# I use this script to create tables which contain
# in-sample data:

if [ $# -lt 1 ]
then
  echo You need to give an integer of days past
  echo Demo:
  echo $0 30
  exit 1
fi

# cd to the right place
cd ~/spy611/script/

export DAYSPAST=$1

# Create tables
./psqlmad.bash -f cr_ab_oos_is_dp.sql -v dayspast=$DAYSPAST

exit
