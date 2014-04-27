#!/bin/bash

# ~/spy611/script/btc/all_btc_yr.bash
cd ~/spy611/script/btc/

THISYR=`date +"%Y"`
for YR in {1975..2030}
do
  if [ $YR -le $THISYR ]
  then
    ./btc_yr.bash $YR
  fi
done

exit
