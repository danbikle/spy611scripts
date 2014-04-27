INSERT INTO saved_predictions
SELECT
now()::TIMESTAMP prediction_time
,ydate
,prob_willbetrue::DECIMAL probup
,pctgain::DECIMAL pctgain
,'svm'             algo
,'m1'             model
FROM ab_rpt_n1dg
ORDER BY ydate
;
