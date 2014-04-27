#!/bin/bash

# ~/spy611/script/noon.bash

# I intend to run this about 12:50 pm

cd ~/spy611/script/

date > /tmp/noon.bash.date.txt
# This loads a price into mydata:
~/spy611/script/wget_noon.bash

# Maybe fill in missing prices:
if [ -f /tmp/fill_in_missing_prices.sql ]
then
  ./psqlmad.bash -f /tmp/fill_in_missing_prices.sql
fi

./psqlmad.bash -f ~/spy611/script/cr_my_vectors.sql

date >> /tmp/noon.bash.date.txt
date
# I should predict now:
~/spy611/script/pred_x.bash ab
~/spy611/script/pred_x.bash gbm
~/spy611/script/pred_x.bash lr
~/spy611/script/pred_x.bash svm

date >> /tmp/noon.bash.date.txt
date
# Delete predictions about to get re-created:
./psqlmad.bash -f delete_pred4noon.sql -v yr="'2014'"

# Collect initial predictions for feedback algos:
~/spy611/script/backtests/bt_x_yr.bash 2014 ab
~/spy611/script/backtests/bt_x_yr.bash 2014 gbm
~/spy611/script/backtests/bt_x_yr.bash 2014 lr
~/spy611/script/backtests/bt_x_yr.bash 2014 svm

date >> /tmp/noon.bash.date.txt
date
# Now that I have initial predictions,
# I collect next predictions from feedback algos:
./psqlmad.bash -f ~/spy611/script/cr_my_vectors_ip.sql
~/spy611/script/pred_x2lr.bash ab
~/spy611/script/pred_x2lr.bash gbm
~/spy611/script/pred_x2lr.bash lr
~/spy611/script/pred_x2lr.bash svm

date >> /tmp/noon.bash.date.txt
date

cd ~/spy611/
git add .
git commit -a -m noon.bash-was-here
git push bit master
git push heroku master

exit
