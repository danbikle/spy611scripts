--
-- ~/spy611/script/mnth.sql
--

-- I use this script to generate an html report to show 
-- the last 10 days from oosd_predictions_n1mg

SELECT * FROM oosd_predictions_n1mg
WHERE 40+ydate > (SELECT MAX(ydate) FROM oosd_predictions_n1mg)
ORDER BY ydate
;

SELECT COUNT(pctgain),AVG(pctgain) FROM oosd_predictions_n1mg WHERE prob_willbetrue < 0.49;

SELECT COUNT(pctgain),AVG(pctgain) FROM oosd_predictions_n1mg;

SELECT COUNT(pctgain),AVG(pctgain) FROM oosd_predictions_n1mg WHERE prob_willbetrue > 0.51;


