#!/bin/bash

# ~/spy611/script/night.bash

# I intend to run this script nightly.

# cd to the right place
cd ~/spy611/script/

date > /tmp/night.bash.date.txt
# wget some data
~/spy611/script/wgetit.bash

# Maybe fill in missing prices:
if [ -f /tmp/fill_in_missing_prices.bash ]
then
  /bin/bash /tmp/fill_in_missing_prices.bash
fi

# Load the data into DB
~/spy611/script/load_mydata.bash
./psqlmad.bash -f ~/spy611/script/cr_my_vectors.sql

date >> /tmp/night.bash.date.txt
date
# I should predict now:
~/spy611/script/pred_x.bash ab
~/spy611/script/pred_x.bash gbm
~/spy611/script/pred_x.bash lr
~/spy611/script/pred_x.bash svm

date >> /tmp/night.bash.date.txt
date
# Delete predictions about to get re-created:
THISYR=`date +"%Y"`
./psqlmad.bash -f delete_pred4night.sql -v yr="'${THISYR}'"
exit

# Collect initial predictions for feedback algos:
~/spy611/script/bt/bt_x_yr.bash 2014 ab
~/spy611/script/bt/bt_x_yr.bash 2014 gbm
~/spy611/script/bt/bt_x_yr.bash 2014 lr
~/spy611/script/bt/bt_x_yr.bash 2014 svm

date >> /tmp/night.bash.date.txt
date

# Now that I have initial predictions,
# I collect next predictions from feedback algos:
./psqlmad.bash -f ~/spy611/script/cr_my_vectors_ip.sql
# Collect next predictions for feedback algos:
for ALGO in ab gbm lr svm
do
  ~/spy611/script/pred_x2lr.bash  $ALGO
  ~/spy611/script/bt/bt_x2lr_yr.bash $THISYR $ALGO
done

date >> /tmp/night.bash.date.txt
date

# Run btc scripts which should be lightweight.
cd ~/spy611/script/btc/
~/spy611/script/btc/all_btc_algo.bash
~/spy611/script/btc/all_btc_model.bash
~/spy611/script/btc/all_btc_yr.bash
~/spy611/script/btc/all_btc_yrspan.bash

exit
