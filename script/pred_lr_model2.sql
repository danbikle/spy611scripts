--
-- ~/spy611/script/pred_lr_model2.sql
--

-- I use this script to generate an html report to show 
-- predictions from lr_rpt_n2dg

-- This script is called by:
-- ~/spy611/script/pred_lr.bash
-- which is called by 
-- ~/spy611/script/night.bash

-- This script depends on lr.bash and lr.sql to fill lr_rpt_n2dg with predictions.

\T class=table_model2
SELECT
TO_CHAR(ydate,'Dy') day_of_week
,ydate
,ROUND(prob_willbetrue::DECIMAL,3) probability_it_will_be_true
,pctgain
FROM lr_rpt_n2dg
ORDER BY ydate
;

INSERT INTO saved_predictions
SELECT
now()::TIMESTAMP prediction_time
,ydate
,prob_willbetrue::DECIMAL probup
,pctgain::DECIMAL pctgain
,'lr'             algo
,'m2'             model
FROM lr_rpt_n2dg
ORDER BY ydate
;
