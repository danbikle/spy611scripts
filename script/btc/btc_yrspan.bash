#!/bin/bash

# ~/spy611/script/btc/btc_yrspan.bash

# Demo:
# ~/spy611/script/btc/btc_yrspan.bash g1

HAMLFILE=~/spy611/app/views/btc_yrspan/${1}.haml
ALGOS="'ab','gbm','lr','svm'"
DATEMIN="1975-01-01"
THISYR=`date +"%Y"`
case "$1" in
'g1')
echo "%h1 Algo Group 1 1975 through 1999" > $HAMLFILE
DATEMAX="1999-12-31"
;;
'g2')
echo "%h1 Algo Group 1 1975 through ${THISYR}" > $HAMLFILE
DATEMAX="${THISYR}-12-31"
;;
'g3')
echo "%h1 Algo Groups 1 and 2 2000 through ${THISYR}" > $HAMLFILE
ALGOS="'ab','gbm','lr','svm','ab2lr','gbm2lr','lr2lr','svm2lr'"
DATEMIN="2000-01-01"
DATEMAX="${THISYR}-12-31"
;;
*)
  echo You need to give a valid Algo group
  echo Demo:
  echo $0 g1
  echo $0 g2
  echo $0 g3
  exit 1
esac


export ERBFILE=~/spy611/app/views/btc_yrspan/_${1}.erb

echo ".btc"             >> $HAMLFILE
echo "  =render '${1}'" >> $HAMLFILE

# Call SQL script which shows algo-effectiveness summarized for 1 yrspan:
./psqlhtml.bash -f btc_yrspan.sql -v algos="${ALGOS}" -v datemin="'$DATEMIN'" -v datemax="'$DATEMAX'" > $ERBFILE

# Delete Postgres artifacts:
~/spy611/script/btc/sed_postgres_artifacts.bash $ERBFILE

# Enhance HTML:
~/spy611/script/btc/sed_enhance_html.bash $ERBFILE

exit
