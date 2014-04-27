#!/bin/bash

# ~/spy611/script/backtests/night.bash

# I use this script to run backtests for all algorithms I am currently using.
# Ensure that this script runs at a different time than
# ~/spy611/script/night.bash

# It is possible I only need to run this script once a year.

cd ~/spy611/script/

# Drop initial prediction tables before I fill them:
./psqlmad.bash -f ~/spy611/script/backtests/drop_ip.sql

          date > /tmp/night.backtests.bash.date.txt
# wget some data
~/spy611/script/wgetit.bash
# Load the data into DB
~/spy611/script/load_mydata.bash

          date >> /tmp/night.backtests.bash.date.txt
./psqlmad.bash -f ~/spy611/script/cr_my_vectors.sql

cd ~/spy611/script/backtests/
          date >> /tmp/night.backtests.bash.date.txt
./backtests_x.bash ab 
          date >> /tmp/night.backtests.bash.date.txt
./backtests_x.bash gbm
          date >> /tmp/night.backtests.bash.date.txt
./backtests_x.bash lr 
          date >> /tmp/night.backtests.bash.date.txt
./backtests_x.bash svm

# Drop next prediction tables before I fill them:
./psqlmad.bash -f ~/spy611/script/backtests/drop_np.sql
# Add initial predictions to my vectors,
# and predict again:
          date >> /tmp/night.backtests.bash.date.txt
./backtests_x2lr.bash ab
          date >> /tmp/night.backtests.bash.date.txt
./backtests_x2lr.bash gbm
          date >> /tmp/night.backtests.bash.date.txt
./backtests_x2lr.bash lr
          date >> /tmp/night.backtests.bash.date.txt
./backtests_x2lr.bash svm

exit

