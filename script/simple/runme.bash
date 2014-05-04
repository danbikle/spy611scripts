#!/bin/bash

# runme.bash

# I run this script at night to predict SandP 500 tomorrow.

./wgetit.bash

./load_mydata.bash

./psqlmad.bash -f cr_vectors.sql

./psqlmad.bash -f cr_insample_data.sql

./psqlmad.bash -f cr_out_of_sample_data.sql

# I have data, now I train the machine:
./psqlmad.bash -f logregr_train.sql
