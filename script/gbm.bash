#!/bin/bash

# ~/spy611/script/gbm.bash

# This script is called by:
# ~/spy611/script/backtests/bt_x_yr.bash

cd ~/spy611/script/
./gbm.py
./psqlmad.bash -f read_gbm_predictions.sql

exit


