--
-- ~/spy611/script/hist/dgap.sql
--

-- Demo:
-- ~/spy611/script/hist/psqlhtml.bash -f dgap.sql
-- I use this script to generate an html report to show oosd_predictions_ndgap

SELECT * FROM oosd_predictions_ndgap
WHERE 10+ydate > (SELECT MAX(ydate) FROM oosd_predictions_ndgap)
ORDER BY ydate
;


SELECT COUNT(pctgain),AVG(pctgain) FROM oosd_predictions_ndgap WHERE prob_willbetrue < 0.49;

SELECT COUNT(pctgain),AVG(pctgain) FROM oosd_predictions_ndgap;

SELECT COUNT(pctgain),AVG(pctgain) FROM oosd_predictions_ndgap WHERE prob_willbetrue > 0.51;
