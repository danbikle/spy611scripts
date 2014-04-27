--
-- ~/spy611/script/qry_saved_predictions.sql
--

-- Look for evidence that predictions are changing.
-- Once a prediction is issued, it should not change value
-- unless the underlying price changes.

SELECT
a.prediction_time  pt1
,b.prediction_time pt2
,a.ydate
,a.probup probup1
,b.probup probup2
,a.pctgain
,a.algo
,a.model
FROM saved_predictions a,saved_predictions b
WHERE a.ydate   = b.ydate
AND   a.pctgain = b.pctgain
AND   a.algo    = b.algo
AND   a.model   = b.model
AND   a.probup  != b.probup
AND   a.prediction_time < b.prediction_time
AND a.algo = 'gbm2lr'
ORDER BY a.prediction_time
,a.ydate
,a.probup
,a.pctgain
,a.algo
,a.model
;

