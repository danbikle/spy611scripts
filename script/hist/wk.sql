--
-- ~/spy611/script/wk.sql
--

-- I use this script to generate an html report to show 
-- the last 10 days from oosd_predictions_n1wg

SELECT * FROM oosd_predictions_n1wg
WHERE 10+ydate > (SELECT MAX(ydate) FROM oosd_predictions_n1wg)
ORDER BY ydate
;

SELECT COUNT(pctgain),AVG(pctgain) FROM oosd_predictions_n1wg WHERE prob_willbetrue < 0.49;

SELECT COUNT(pctgain),AVG(pctgain) FROM oosd_predictions_n1wg;

SELECT COUNT(pctgain),AVG(pctgain) FROM oosd_predictions_n1wg WHERE prob_willbetrue > 0.51;

