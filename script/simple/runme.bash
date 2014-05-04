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

# Now the machine can predict:
./psqlmad.bash -f predict_oos_data.sql

echo Compare the above predictions to the prices here:
echo http://finance.yahoo.com/q/hp?s=^GSPC+Historical+Prices
echo Are the predictions mostly true?
