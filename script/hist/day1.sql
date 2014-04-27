--
-- ~/spy611/script/day1.sql
--

-- I use this script to generate an html report to show 
-- the last 10 days from oosd_predictions_n1dg

SELECT * FROM oosd_predictions_n1dg
WHERE 10+ydate > (SELECT MAX(ydate) FROM oosd_predictions_n1dg)
ORDER BY ydate
;

SELECT COUNT(pctgain),AVG(pctgain) FROM oosd_predictions_n1dg WHERE prob_willbetrue < 0.49;

SELECT COUNT(pctgain),AVG(pctgain) FROM oosd_predictions_n1dg;

SELECT COUNT(pctgain),AVG(pctgain) FROM oosd_predictions_n1dg WHERE prob_willbetrue > 0.51;
