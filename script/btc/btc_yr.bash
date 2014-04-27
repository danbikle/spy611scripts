#!/bin/bash

# ~/spy611/script/btc/btc_yr.bash

# Demo:
# ~/spy611/script/btc/btc_yr.bash 2000

if [ $# -lt 1 ]
then
  echo You need to give a year
  echo Demo:
  echo $0 2000
  exit 1
fi

YR=$1
HAMLFILE=~/spy611/app/views/btc_yr/index.haml
THISYR=`date +"%Y"`

export ERBFILE=~/spy611/app/views/btc_yr/_yr${YR}.erb

# Call SQL script which shows algo-effectiveness summarized for 1 yrspan:
./psqlhtml.bash -f btc_yr.sql -v yr="'${YR}'" > $ERBFILE

# Delete Postgres artifacts:
~/spy611/script/btc/sed_postgres_artifacts.bash $ERBFILE

# Enhance HTML:
~/spy611/script/btc/sed_enhance_html.bash $ERBFILE

exit
