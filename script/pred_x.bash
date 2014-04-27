#!/bin/bash

# ~/spy611/script/pred_x.bash
# This script is called by:
# ~/spy611/script/night.bash

# Derived from 
# ~/spy611/script/predict_ab.bash

# Example erbfile:
# ~/spy611/app/views/pred_ab/_model1_2010.erb

# Example route:
# get "pred_ab" => "pred_ab#index"

if [ $# -lt 1 ]
then
  echo You need to give an algo name
  echo Demo:
  echo $0 svm
  exit 1
fi

ALGO=$1

# cd to the right place
cd ~/spy611/script/

# Build some vectors for AdaBoost from table: my_vectors,
# which should have been created recently from the logistic regression scripts.

export ERBDIR=~/spy611/app/views/pred_${ALGO}/

./psqlmad.bash -f cr_${ALGO}_oos_is_dp.sql -v dayspast="15"

./${ALGO}.bash

# model1
./psqlhtml.bash -f pred_${ALGO}_model1.sql > ${ERBDIR}_model1.erb

# model2
./psqlhtml.bash -f pred_${ALGO}_model2.sql > ${ERBDIR}_model2.erb

# model3
./psqlhtml.bash -f pred_${ALGO}_model3.sql > ${ERBDIR}_model3.erb

echo "$0 just wrote 3 html tables"
echo "to 3 erb files in ${ERBDIR}"
cd ${ERBDIR}
~/spy611/script/sed_table_in_model_erb.bash

exit
