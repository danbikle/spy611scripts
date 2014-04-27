#!/bin/bash

# ~/spy611/script/ab.bash

# This script is called by:
# ~/spy611/script/backtests/bt_x_yr.bash

cd ~/spy611/script/
./ab.py
./psqlmad.bash -f read_ab_predictions.sql

exit


