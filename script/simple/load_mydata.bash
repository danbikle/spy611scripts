#!/bin/bash

# load_mydata.bash

# I use this script to load data into a table.

./psqlmad.bash -f cr_mydata.sql
./psqlmad.bash -f load_mydata.sql

exit
