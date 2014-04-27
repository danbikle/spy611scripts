--
-- ~/spy611/script/mgap.sql
--

-- I use this script to generate an html report to show 
-- the last 10 days from oosd_predictions_nmgap

SELECT * FROM oosd_predictions_nmgap
WHERE 10+ydate > (SELECT MAX(ydate) FROM oosd_predictions_nmgap)
ORDER BY ydate
;

SELECT COUNT(pctgain),AVG(pctgain) FROM oosd_predictions_nmgap WHERE prob_willbetrue < 0.49;

SELECT COUNT(pctgain),AVG(pctgain) FROM oosd_predictions_nmgap;

SELECT COUNT(pctgain),AVG(pctgain) FROM oosd_predictions_nmgap WHERE prob_willbetrue > 0.51;
