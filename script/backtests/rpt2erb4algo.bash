#!/bin/bash

# ~/spy611/script/backtests/rpt2erb4algo.bash

# I use this script to report backtest predictions to an erbfile for a specific algorithm.

# Demo:
# ~/spy611/script/backtests/rpt2erb4algo.bash $ERBFILE rpt_${ALGO}.sql

# cd to the right place
cd ~/spy611/script/backtests/

if [ $# -lt 2 ]
then
  echo You need to give an erbfile and a sql-script
  echo Demo:
  echo $0 ~/spy611/app/views/bt_ab2lr_yr/_bt2014.erb rpt_ab.sql
  exit 1
fi

export ERBFILE=$1
export RPTSQL=$2

# cd to the right place
cd ~/spy611/script/backtests/
# day1
echo '<h2>Model 1:</h2>'                                    > $ERBFILE
echo '<h2>Next Day (Close to Next Close) Predictions</h2>' >> $ERBFILE
# Report n1dg results
./psqlhtml.bash -f $RPTSQL -v ng=n1dg              >> $ERBFILE

# day2
echo '<hr /><h2>Model 2:</h2>'                                      >> $ERBFILE
echo '<h2>Day After Tomorrow (Close to 2nd Close) Predictions</h2>' >> $ERBFILE
# Report n2dg results
./psqlhtml.bash -f $RPTSQL -v ng=n2dg             >> $ERBFILE

# wk
echo '<hr /><h2>Model 3:</h2>'                                      >> $ERBFILE
echo '<h2>Week from Today (Close to 5th Close) Predictions</h2>'    >> $ERBFILE
# Report n1wg results
./psqlhtml.bash -f $RPTSQL -v ng=n1wg             >> $ERBFILE

# Delete Postgres artifacts:
sed -i '/DROP TABLE/d'                  $ERBFILE
sed -i '/<p>SELECT.*p>$/d'              $ERBFILE
sed -i '/Table attribute is/d'          $ERBFILE
sed -i '/<p>.1 row.<br .>/s/.1 row.*//' $ERBFILE
sed -i '/<p>.*rows.<br .>/s/.*rows.*//' $ERBFILE
sed -i '1,$s/table border=.1./table/'   $ERBFILE
# Enhance HTML:
sed -i '1,$s/more_information/More Information/' $ERBFILE
sed -i '1,$s/avg_pct_gain_where_prob_lt_pt49/Avg Pct Gain Where Prediction Probability in UP class is less than 50%/'             $ERBFILE
sed -i '1,$s/avg_pct_gain_where_prob_gt_pt51/Avg Pct Gain Where Prediction Probability in UP class is greater than or equal 50%/' $ERBFILE

# Say something:
echo $0 just wrote some predictions to this file:
echo $ERBFILE

exit

