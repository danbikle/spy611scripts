--
-- ~/spy611/script/pred_svm_model3.sql
--

-- This script is called by:
-- ~/spy611/script/pred_svm.bash

-- I use this script to copy data out of db into an erb file.

-- The erb file should look like this erb file:
-- ~/spy611/app/views/predictions/_predictions_logr_model3_1970.erb
-- but
-- I want it named like this:
-- ~/spy611/app/views/pred_svm/_model3_1970.erb

-- I will be copying data out of a table named:
-- svm_rpt_n1dg
-- svm_rpt_n2dg
-- svm_rpt_n1wg

\T class=table_model3
SELECT
TO_CHAR(ydate,'Dy') day_of_week
,ydate
,ROUND(prob_willbetrue::DECIMAL,3) probability_it_will_be_true
,ROUND(pctgain::DECIMAL,3)          pctgain
FROM svm_rpt_n1wg
ORDER BY ydate
;

INSERT INTO saved_predictions
SELECT
now()::TIMESTAMP prediction_time
,ydate
,prob_willbetrue::DECIMAL probup
,pctgain::DECIMAL pctgain
,'svm'             algo
,'m3'             model
FROM svm_rpt_n1wg
ORDER BY ydate
;
