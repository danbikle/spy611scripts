#!/bin/bash

# ~/spy611/script/backtests/bt_x2lr_all.bash

# Demo:
# ~/spy611/script/backtests/bt_x2lr_all.bash gbm

# This script is called by:
# ~/spy611/script/backtests/backtests_x2lr.bash

if [ $# -lt 1 ]
then
  echo You need to give an algo
  echo Demo:
  echo $0 gbm
  exit 1
fi

ALGO=$1
export ERBFILE=~/spy611/app/views/bt_${ALGO}2lr/_allyears.erb

# cd to the right place
cd ~/spy611/script/backtests/

echo '<h2>Model 1:</h2>'                                             > $ERBFILE
echo '<h2>Next Day (Close to Next Close) Predictions</h2>'          >> $ERBFILE
~/spy611/script/psqlhtml.bash -f rpt_np.sql -v algo="'${ALGO}'" -v ng=n1dg >> $ERBFILE

echo '<h2>Model 2:</h2>'                                            >> $ERBFILE
echo '<h2>Day After Tomorrow (Close to 2nd Close) Predictions</h2>' >> $ERBFILE
~/spy611/script/psqlhtml.bash -f rpt_np.sql -v algo="'${ALGO}'" -v ng=n2dg >> $ERBFILE

echo '<h2>Model 3:</h2>'                                            >> $ERBFILE
echo '<h2>Week from Today (Close to 5th Close) Predictions</h2>'    >> $ERBFILE
~/spy611/script/psqlhtml.bash -f rpt_np.sql -v algo="'${ALGO}'" -v ng=n1wg >> $ERBFILE

# Delete Postgres artifacts:
sed -i '/DROP TABLE/d'                  $ERBFILE
sed -i '/<p>SELECT.*p>$/d'              $ERBFILE
sed -i '/Table attribute is/d'          $ERBFILE
sed -i '/<p>.1 row.<br .>/s/.1 row.*//' $ERBFILE
sed -i '1,$s/table border=.1./table/'   $ERBFILE
# Enhance HTML:
sed -i '1,$s/more_information/More Information/' $ERBFILE
sed -i '1,$s/avg_pct_gain_where_prob_lt_pt49/Avg Pct Gain Where Prediction Probability in UP class is less than 50%/'             $ERBFILE
sed -i '1,$s/avg_pct_gain_where_prob_gt_pt51/Avg Pct Gain Where Prediction Probability in UP class is greater than or equal 50%/' $ERBFILE

echo "$0 just ran"
echo It just created an erb file:
echo $ERBFILE

exit
