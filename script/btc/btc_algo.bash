#!/bin/bash

# ~/spy611/script/btc/btc_algo.bash
# Demo:
# ~/spy611/script/btc/btc_algo.bash gbm

# I use this script to give a concise report on backtests for a named algo.

if [ $# -lt 1 ]
then
  echo You need to give an Algo
  echo Demo:
  echo $0 gbm
  exit 1
fi

# cd to the right place
cd ~/spy611/script/btc/

export ALGO=$1
export HAMLFILE=~/spy611/app/views/btc_algo/${ALGO}.haml
export ERBFILE=~/spy611/app/views/btc_algo/_${ALGO}.erb

case "$ALGO" in
'ab')
echo "%h1 (scikit-learn) AdaBoost"                         > $HAMLFILE
;;
'gbm')
echo "%h1 (scikit-learn) GBM"                              > $HAMLFILE
;;
'lr')
echo "%h1 MADlib Logistic Regression"                      > $HAMLFILE
;;
'svm')
echo "%h1 LIBSVM"                                          > $HAMLFILE
;;

'ab2lr')
echo "%h1 AdaBoost fed to: Logistic Regression"            > $HAMLFILE
;;
'gbm2lr')
echo "%h1 GBM fed to: Logistic Regression"                 > $HAMLFILE
;;
'lr2lr')
echo "%h1 Logistic Regression fed to: Logistic Regression" > $HAMLFILE
;;
'svm2lr')
echo "%h1 LIBSVM fed to: Logistic Regression"              > $HAMLFILE
;;
*)
  echo You need to give a valid Algo
  echo Demo:
  echo $0 ab
  echo $0 gbm
  echo $0 lr
  echo $0 svm
  echo $0 ab2lr
  echo $0 gbm2lr
  echo $0 lr2lr
  echo $0 svm2lr
  exit 1
esac

echo ".btc"                >> $HAMLFILE
echo "  =render '${ALGO}'" >> $HAMLFILE
echo "  =render 'layouts/bottom_links'" >> $HAMLFILE

# Accumulate some data from tables ip_n* and np_n* into table btc_algo:
./psqlmad.bash -f cr_btc_algo.sql
./psqlmad.bash -f ins_btc_algo.sql -v ng=n1dg -v model="'m1'"
./psqlmad.bash -f ins_btc_algo.sql -v ng=n2dg -v model="'m2'"
./psqlmad.bash -f ins_btc_algo.sql -v ng=n1wg -v model="'m3'"

# Call SQL script which shows algo-effectiveness summarized over all 3 models:
./psqlhtml.bash -f btc_algo.sql -v algo="'${ALGO}'" > $ERBFILE

# Delete Postgres artifacts:
~/spy611/script/btc/sed_postgres_artifacts.bash $ERBFILE

# Enhance HTML:
~/spy611/script/btc/sed_enhance_html.bash $ERBFILE

exit
