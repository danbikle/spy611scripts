#!/bin/bash

# ~/spy611/script/btc/sed_postgres_artifacts.bash

# I use this script to share some sed syntax to delete some 
# artifacts left behind by Postgres.

if [ $# -lt 1 ]
then
  echo You need to give an erbfile
  echo Demo:
  echo $0 ~/spy611/app/views/btc_algo/_gbm.erb
  exit 1
fi

cd ~/spy611/script/btc/

ERBFILE=$1
# Delete Postgres artifacts:
sed -i '/DROP TABLE/d'                  $ERBFILE
sed -i '/<p>SELECT.*p>$/d'              $ERBFILE
sed -i '/Table attribute is/d'          $ERBFILE
sed -i '/<p>.1 row.<br .>/s/.1 row.*//' $ERBFILE
sed -i '/<p>.*rows.<br .>/s/.*rows.*//' $ERBFILE
sed -i '1,$s/table border=.1./table/'   $ERBFILE
exit
