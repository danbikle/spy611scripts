#!/bin/bash

# /a/ks/b/matlab/panera22/rpt_btr.bash

cd backtest_results/

sort bt*.csv|sort|uniq|grep cpdate >     allbt.csv
sort bt*.csv|sort|uniq|grep -v cpdate >> allbt.csv

# matlab -f rpt_btr.m
