#!/bin/bash

# ~/spy611/script/ma/bt.bash

# I use this script to backtest my MA vectors fed to gbm fed to lr.

cd ~/spy611/script/ma/

# Drop initial prediction tables before I fill them:
./psqlmad.bash -f ~/spy611/script/bak_ip.sql
./psqlmad.bash -f ~/spy611/script/backtests/drop_ip.sql

# Need vectors:
./psqlmad.bash -f ~/spy611/script/ma/cr_my_vectors.sql

# Collect initial predictions starting in 1975 up to now.

THISYR=`date +"%Y"`
for YR in {1975..2030}
do
  if [ $YR -le $THISYR ]
  then
    ~/spy611/script/ma/ip_gbm.bash $YR
  fi
done

# query my new initial predictions
./psqlmad.bash -f ~/spy611/script/bt/qry_ip.sql

# Backup next-prediction tables
./psqlmad.bash -f ~/spy611/script/ma/bak_np.sql

# Drop next-prediction tables before I fill them:
./psqlmad.bash -f ~/spy611/script/backtests/drop_np.sql

# Widen my vectors:
./psqlmad.bash -f ~/spy611/script/ma/cr_my_vectors_wide.sql
./psqlmad.bash -f ~/spy611/script/ma/qry_wide.sql

# Run Logistic Regression starting in 2000 when I have 25 yr of data

for YR in {2000..2030}
do
  if [ $YR -le $THISYR ]
  then
    ~/spy611/script/ma/lr.bash $YR
  fi
done

# rpt
./psqlmad.bash -f ~/spy611/script/ma/rpt_np.sql

# Recent predictions:
./psqlmad.bash -f ~/spy611/script/ma/qry_recent.sql

# Restore initial-prediction tables
./psqlmad.bash -f ~/spy611/script/ma/restore_ip.sql

# Restore next-prediction tables
./psqlmad.bash -f ~/spy611/script/ma/restore_np.sql

exit
