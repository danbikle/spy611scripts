#!/bin/bash

# ~/spy611/script/btc/btc_model.bash
# Demo:
# ~/spy611/script/btc/btc_model.bash m1

# I use this script to give a concise report on backtests for a named model.

if [ $# -lt 1 ]
then
  echo You need to give a Model
  echo Demo:
  echo $0 m1
  echo $0 m2
  echo $0 m3
  exit 1
fi

# cd to the right place
cd ~/spy611/script/btc/

export MODEL=$1
export HAMLFILE=~/spy611/app/views/btc_model/${MODEL}.haml
export ERBFILE=~/spy611/app/views/btc_model/_${MODEL}.erb

case "$MODEL" in
'm1')
echo "%h1 Model 1 (1 Day Holding Period)" > $HAMLFILE
;;
'm2')
echo "%h1 Model 2 (2 Day Holding Period)" > $HAMLFILE
;;
'm3')
echo "%h1 Model 3 (5 Day Holding Period)" > $HAMLFILE
;;
*)
  echo You need to give a valid Model
  echo Demo:
  echo $0 m1
  echo $0 m2
  echo $0 m3
  exit 1
esac

echo ".btc"                 >> $HAMLFILE
echo "  =render '${MODEL}'" >> $HAMLFILE
echo "  =render 'layouts/bottom_links'" >> $HAMLFILE

# Call SQL script which shows algo-effectiveness summarized for 1 model:
./psqlhtml.bash -f btc_model.sql -v model="'${MODEL}'" > $ERBFILE

# Delete Postgres artifacts:
~/spy611/script/btc/sed_postgres_artifacts.bash $ERBFILE

# Enhance HTML:
~/spy611/script/btc/sed_enhance_html.bash $ERBFILE

exit
