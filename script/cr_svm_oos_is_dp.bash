#!/bin/bash

# ~/spy611/script/cr_svm_oos_is_dp.bash

# I use this script to create 3 tables which contain
# in-sample data:
#   svm_is_n1dg, svm_is_n2dg, svm_is_n1wg, 
# Also I create 3 tables which contain
# out-of-sample data: 
#   svm_oos_n1dg, svm_oos_n2dg, svm_oos_n1wg, 

# The source of all the data is a table named: my_vectors.

# Assume that my Logistic Regression scripts filled my_vectors
# a short while ago.

# After the tables are created,
# I create CSV files from the tables:

# dan@cen110 ~/spy611/script $ ll /tmp/svm*csv
# -rw-r--r--. 1 postgres postgres 1805645 Feb 28 23:30 /tmp/svm_is_n1dg.csv
# -rw-r--r--. 1 postgres postgres 1805645 Feb 28 23:30 /tmp/svm_is_n1wg.csv
# -rw-r--r--. 1 postgres postgres 1805645 Feb 28 23:30 /tmp/svm_is_n2dg.csv
# -rw-r--r--. 1 postgres postgres    1047 Feb 28 23:30 /tmp/svm_oos_n1dg.csv
# -rw-r--r--. 1 postgres postgres    1043 Feb 28 23:30 /tmp/svm_oos_n1wg.csv
# -rw-r--r--. 1 postgres postgres    1046 Feb 28 23:30 /tmp/svm_oos_n2dg.csv
# dan@cen110 ~/spy611/script $ 

# Then, I transform the CSV files into a format suitable for LIBSVM.


if [ $# -lt 1 ]
then
  echo You need to give a Year and an integer of days past
  echo Demo:
  echo $0 30
  exit 1
fi

# cd to the right place
cd ~/spy611/script/

export DAYSPAST=$1

# Create tables
./psqlmad.bash -f cr_svm_oos_is_dp.sql -v dayspast=$DAYSPAST

# convert CSV files to LIBSVM format:
# ref: https://github.com/zygmuntz/phraug

python ~/libsvm/phraug/csv2libsvm.py /tmp/svm_is_n1dg.csv /tmp/svm_is_n1dg.txt
python ~/libsvm/phraug/csv2libsvm.py /tmp/svm_is_n2dg.csv /tmp/svm_is_n2dg.txt
python ~/libsvm/phraug/csv2libsvm.py /tmp/svm_is_n1wg.csv /tmp/svm_is_n1wg.txt

python ~/libsvm/phraug/csv2libsvm.py /tmp/svm_oos_n1dg.csv /tmp/svm_oos_n1dg.txt
python ~/libsvm/phraug/csv2libsvm.py /tmp/svm_oos_n2dg.csv /tmp/svm_oos_n2dg.txt
python ~/libsvm/phraug/csv2libsvm.py /tmp/svm_oos_n1wg.csv /tmp/svm_oos_n1wg.txt

# Now I can run svm.bash:
# ~/spy611/script/svm.bash

exit
