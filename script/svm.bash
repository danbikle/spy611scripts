#!/bin/bash

# ~/spy611/script/svm.bash

# This script depends on 
# ~/spy611/script/cr_svm_oos_is_dp.sql
# to create files for:
# ~/libsvm/svm-scale 
# ~/libsvm/svm-train
# ~/libsvm/svm-predict

# I see information about libsvm operation here:
# ~/libsvm/README 
# ~/libsvm/FAQ.html

# This will create files.
# So I cd /tmp/
cd /tmp/

rm -f /tmp/svm_is_*.model
rm -f /tmp/svm_*predictions.txt

# svm-scale in-sample data:
~/libsvm/svm-scale -s svm_range_n1dg.txt svm_is_n1dg.csv >svm_is_scaled_n1dg.txt
~/libsvm/svm-scale -s svm_range_n2dg.txt svm_is_n2dg.csv >svm_is_scaled_n2dg.txt
~/libsvm/svm-scale -s svm_range_n1wg.txt svm_is_n1wg.csv >svm_is_scaled_n1wg.txt

# svm-scale out-of-sample data:
~/libsvm/svm-scale -r svm_range_n1dg.txt svm_oos_n1dg.csv > svm_oos_scaled_n1dg.txt
~/libsvm/svm-scale -r svm_range_n2dg.txt svm_oos_n2dg.csv > svm_oos_scaled_n2dg.txt
~/libsvm/svm-scale -r svm_range_n1wg.txt svm_oos_n1wg.csv > svm_oos_scaled_n1wg.txt

# Demo of b, c and g cmd-lin params:
# ~/libsvm/svm-train -b 1 -c 0.03125 -g 0.0078125 svm_is_scaled_n1dg.txt
# ~/libsvm/svm-train -b 1 -c 0.03125 -g 0.0078125 svm_is_scaled_n2dg.txt
# ~/libsvm/svm-train -b 1 -c 0.03125 -g 0.0078125 svm_is_scaled_n1wg.txt

# Demo of b-less calls:
# ~/libsvm/svm-train -c 0.03125 -g 0.0078125 svm_is_scaled_n1dg.txt
# ~/libsvm/svm-train -c 0.03125 -g 0.0078125 svm_is_scaled_n2dg.txt
# ~/libsvm/svm-train -c 0.03125 -g 0.0078125 svm_is_scaled_n1wg.txt

# Demo of param-less calls, but with b which gives confidence level:
~/libsvm/svm-train -b 1 svm_is_scaled_n1dg.txt
~/libsvm/svm-train -b 1 svm_is_scaled_n2dg.txt
~/libsvm/svm-train -b 1 svm_is_scaled_n1wg.txt

# ~/libsvm/svm-predict svm_oos_scaled_n1dg.txt svm_is_scaled_n1dg.txt.model svm_n1dg_predictions.txt
# ~/libsvm/svm-predict svm_oos_scaled_n2dg.txt svm_is_scaled_n2dg.txt.model svm_n2dg_predictions.txt
# ~/libsvm/svm-predict svm_oos_scaled_n1wg.txt svm_is_scaled_n1wg.txt.model svm_n1wg_predictions.txt

# Demo of b command line param which gives confidence level:
~/libsvm/svm-predict -b 1 svm_oos_scaled_n1dg.txt svm_is_scaled_n1dg.txt.model svm_n1dg_predictions.txt
~/libsvm/svm-predict -b 1 svm_oos_scaled_n2dg.txt svm_is_scaled_n2dg.txt.model svm_n2dg_predictions.txt
~/libsvm/svm-predict -b 1 svm_oos_scaled_n1wg.txt svm_is_scaled_n1wg.txt.model svm_n1wg_predictions.txt

# If I use b, I want the 2nd column which contains confidence level, else I want the 1st column:
# grep -v labels svm_n1dg_predictions.txt|awk '{print NR "," $1}' > svm_predictions_n1dg.csv
# grep -v labels svm_n2dg_predictions.txt|awk '{print NR "," $1}' > svm_predictions_n2dg.csv
# grep -v labels svm_n1wg_predictions.txt|awk '{print NR "," $1}' > svm_predictions_n1wg.csv
grep -v labels svm_n1dg_predictions.txt|awk '{print NR "," $2}' > svm_predictions_n1dg.csv
grep -v labels svm_n2dg_predictions.txt|awk '{print NR "," $2}' > svm_predictions_n2dg.csv
grep -v labels svm_n1wg_predictions.txt|awk '{print NR "," $2}' > svm_predictions_n1wg.csv

# Copy predictions into tables for reporting:
~/spy611/script/psqlmad.bash -f ~/spy611/script/read_svm_predictions.sql

exit
