#!/bin/bash

# ~/spy611/script/load_mydata.bash

# I use this script to load data into a table.

cd ~/spy611/script/

# Postgres needs to know where mydata.csv is.
# It is confused by ~/tmp/
# So I copy it to /tmp/
cp ~/tmp/mydata.csv /tmp/
./psqlmad.bash -f cr_mydata.sql
./psqlmad.bash -f load_mydata.sql

exit
