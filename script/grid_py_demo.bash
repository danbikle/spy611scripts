#!/bin/bash

# ~/spy611/script/grid_py_demo.bash

# This will create a file. So cd /tmp/
cd /tmp/

~/spy611/script/backtests/cr_svm_oos_is.bash 1970 1980

# python ~/libsvm/tools/grid.py /tmp/svm_is_scaled_n1dg.txt
python ~/libsvm/tools/grid.py /tmp/svm_is_scaled_n2dg.txt
# python ~/libsvm/tools/grid.py /tmp/svm_is_scaled_n1wg.txt

exit
