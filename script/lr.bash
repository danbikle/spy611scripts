#!/bin/bash

# ~/spy611/script/lr.bash

# I use this script to run MADlib Logistic Regression
# using in-sample data in table, is_vectors
# and out-of-sample data in table, oos_vectors

# This script is called by:
# ~/spy611/script/pred_lr.bash
# which is called by:
# ~/spy611/script/night.bash

# This script depends on:
# ~/spy611/script/cr_lr_oos_is_ln.bash
# Which creates both in-sample and out-of-sample vectors
# in tables:
# is_vectors
# oos_vectors

~/spy611/script/psqlmad.bash -f ~/spy611/script/lr.sql

exit
