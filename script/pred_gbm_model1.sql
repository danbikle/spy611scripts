--
-- ~/spy611/script/pred_gbm_model1.sql
--

-- This script is called by:
-- ~/spy611/script/pred_gbm.bash

-- I use this script to copy data out of db into an erb file.

-- The erb file should look like this erb file:
-- ~/spy611/app/views/predictions/_predictions_logr_model1_1970.erb
-- but
-- I want it named like this:
-- ~/spy611/app/views/pred_gbm/_model1_1970.erb

-- I will be copying data out of a table named:
-- gbm_rpt_n1dg
-- gbm_rpt_n2dg
-- gbm_rpt_n1wg

\T class=table_model1
SELECT
TO_CHAR(ydate,'Dy') day_of_week
,ydate
,CASE WHEN prob_willbetrue=1 THEN 1 ELSE 0 END probability_it_will_be_true
,ROUND(pctgain::DECIMAL,3)          pctgain
FROM gbm_rpt_n1dg
ORDER BY ydate
;


INSERT INTO saved_predictions
SELECT
now()::TIMESTAMP prediction_time
,ydate
,CASE WHEN prob_willbetrue=1 THEN 1.0 ELSE 0.0 END probup
,pctgain::DECIMAL pctgain
,'gbm'            algo
,'m1'             model
FROM gbm_rpt_n1dg
ORDER BY ydate
;
