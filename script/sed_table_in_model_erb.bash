#!/bin/bash

# ~/spy611/script/sed_table_in_model_erb.bash

# I use this script to share some sed syntax.

# Delete postgres HTML artifacts which I dont want:
sed -i '/Table attribute is/d' _model?.erb
sed -i '/<.p>/d'               _model?.erb
sed -i '/<p>.* rows..br /d'    _model?.erb
sed -i '1,$s/table border=.1./table/' _model?.erb

# Enhance HTML:
sed -i '1,$s/day_of_week/Day of Week/'        _model?.erb
sed -i '1,$s/ydate/Prediction Date/'          _model?.erb
sed -i '1,$s/probability_it_will_be_true/Up Probability/' _model?.erb
sed -i '1,$s/pctgain/Resulting Percent Gain/' _model?.erb

exit
