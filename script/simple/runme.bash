#!/bin/bash

# runme.bash

# I run this script at night to predict SandP 500 tomorrow.

./wgetit.bash

./load_mydata.bash

./psqlmad.bash -f cr_vectors.sql
