--
-- ~/spy611/script/oosd_histo.sql
--

-- Here I look at results constrained by probability:

SELECT COUNT(:ng),ROUND(AVG(:ng),5) avg_:ng, ROUND(SUM(:ng),5) sum_:ng FROM oosd_predictions;

SELECT COUNT(:ng),ROUND(AVG(:ng),5) avg_:ng, ROUND(SUM(:ng),5) sum_:ng FROM oosd_predictions WHERE probability < 0.46;
SELECT COUNT(:ng),ROUND(AVG(:ng),5) avg_:ng, ROUND(SUM(:ng),5) sum_:ng FROM oosd_predictions WHERE probability < 0.47;
SELECT COUNT(:ng),ROUND(AVG(:ng),5) avg_:ng, ROUND(SUM(:ng),5) sum_:ng FROM oosd_predictions WHERE probability < 0.48;
SELECT COUNT(:ng),ROUND(AVG(:ng),5) avg_:ng, ROUND(SUM(:ng),5) sum_:ng FROM oosd_predictions WHERE probability < 0.49;
SELECT COUNT(:ng),ROUND(AVG(:ng),5) avg_:ng, ROUND(SUM(:ng),5) sum_:ng FROM oosd_predictions WHERE probability < 0.50;

SELECT COUNT(:ng),ROUND(AVG(:ng),5) avg_:ng, ROUND(SUM(:ng),5) sum_:ng FROM oosd_predictions WHERE probability > 0.50;
SELECT COUNT(:ng),ROUND(AVG(:ng),5) avg_:ng, ROUND(SUM(:ng),5) sum_:ng FROM oosd_predictions WHERE probability > 0.51;
SELECT COUNT(:ng),ROUND(AVG(:ng),5) avg_:ng, ROUND(SUM(:ng),5) sum_:ng FROM oosd_predictions WHERE probability > 0.52;
SELECT COUNT(:ng),ROUND(AVG(:ng),5) avg_:ng, ROUND(SUM(:ng),5) sum_:ng FROM oosd_predictions WHERE probability > 0.53;
SELECT COUNT(:ng),ROUND(AVG(:ng),5) avg_:ng, ROUND(SUM(:ng),5) sum_:ng FROM oosd_predictions WHERE probability > 0.54;

-- Confusion Matrix Calculations:

-- True Positives:
SELECT COUNT(:ng) FROM oosd_predictions WHERE probability >= 0.5 AND :yvalue = true;

-- True Negatives:
SELECT COUNT(:ng) FROM oosd_predictions WHERE probability < 0.5 AND :yvalue = false;

-- False Positives:
SELECT COUNT(:ng) FROM oosd_predictions WHERE probability >= 0.5 AND :yvalue = false;

-- False Negatives:
SELECT COUNT(:ng) FROM oosd_predictions WHERE probability < 0.5 AND :yvalue  = true;

-- Finally, Accuracy.
-- We calculate accuracy by hand using:
-- (True Positives + True Negatives) / SELECT COUNT(:ng) FROM oosd_predictions;


-- I use this part to aggregate prediction results for a histogram.

SELECT
ROUND(probability::NUMERIC,2) probability
,ROUND(AVG(:ng),5)           myavg
,ROUND(AVG(:ng)/0.00077,5)   myavg_over_agg_avg 
,COUNT(probability)          observation_count
,ROUND(SUM(:ng),5)           mysum
FROM oosd_predictions
GROUP BY ROUND(probability::NUMERIC,2)
ORDER BY ROUND(probability::NUMERIC,2)
;

\q
-- More fine-grained histogram:
SELECT
ROUND(probability::NUMERIC,3) probability
,ROUND(AVG(:ng),5)            myavg
,ROUND(AVG(:ng)/0.00077,5)    myavg_over_agg_avg 
,COUNT(probability)           observation_count
,ROUND(SUM(:ng),5)           mysum
FROM oosd_predictions
GROUP BY ROUND(probability::NUMERIC,3)
ORDER BY ROUND(probability::NUMERIC,3)
;


