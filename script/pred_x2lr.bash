#!/bin/bash

# ~/spy611/script/pred_x2lr.bash

# Demo:
# ~/spy611/script/pred_x2lr.bash svm

# Derived from 
# ~/spy611/script/pred_lr.bash

# I use this script to feed predictions from 
# one algorithm into MADlib Logistic Regression.

# This script is so similar to pred_lr.bash that
# I can use many of the same calls to other scripts:
# lr.bash
# pred_lr_model1.sql
# pred_lr_model2.sql
# pred_lr_model3.sql

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

# Build some vectors from a join of my_vectors
# and initial_prediction (ip) tables:

# This script should be pushed up to noon.bash:
# ./psqlmad.bash -f ~/spy611/script/cr_my_vectors_ip.sql

./psqlmad.bash -f ~/spy611/script/cr_my_vectors_wide.sql -v algo="'${ALGO}'"

export ERBDIR=~/spy611/app/views/pred_${ALGO}2lr/

./psqlmad.bash -f cr_x2lr_oos_is_dp.sql -v dayspast="15"

./lr.bash

# model1
./psqlhtml.bash -f pred_2lr_model1.sql -v algo2lr="'${ALGO}2lr'" > ${ERBDIR}_model1.erb

# model2
./psqlhtml.bash -f pred_2lr_model2.sql -v algo2lr="'${ALGO}2lr'" > ${ERBDIR}_model2.erb

# model3
./psqlhtml.bash -f pred_2lr_model3.sql -v algo2lr="'${ALGO}2lr'" > ${ERBDIR}_model3.erb

echo "$0 just wrote 3 html tables"
echo "to 3 erb files in ${ERBDIR}"
cd ${ERBDIR}
~/spy611/script/sed_table_in_model_erb.bash

exit
