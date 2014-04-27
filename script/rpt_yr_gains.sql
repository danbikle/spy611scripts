--
-- ~/spy611/script/rpt_yr_gains.sql
--

-- I use this script to report on gains grouped by YYYY.

-- English:
-- From all my data,
-- Tell me avg_1day_pct_gain
SELECT 
MIN(ydate)       min_ydate
,100 * AVG(n1dg) avg_1day_pct_gain
,MAX(ydate)      max_ydate
,COUNT(ydate)    count_ydate
FROM my_vectors
;


-- English:
-- From all my data,
-- Tell me avg_1day_pct_gain
-- Where today was down by more than 1-std-deviation,
-- And yesterday was down by more than 1-std-deviation
SELECT 
MIN(ydate)       min_ydate
,100 * AVG(n1dg) avg_1day_pct_gain
,MAX(ydate)      max_ydate
,COUNT(ydate)    count_ydate
FROM my_vectors
WHERE n1dg1 < -0.012
AND   n1dg2 < -0.012
;
-- In the above data,
-- avg_1day_pct_gain was 16x larger
-- WHERE n1dg1 < -0.012
-- AND   n1dg2 < -0.012

-- Now look at averages for each year:

SELECT 
TO_CHAR(ydate, 'YYYY') YYYY
,MIN(ydate)       min_ydate
,100 * AVG(n1dg) avg_1day_pct_gain
,MAX(ydate)      max_ydate
,COUNT(ydate)    count_ydate
FROM my_vectors
GROUP BY TO_CHAR(ydate, 'YYYY')
ORDER BY AVG(n1dg)
;

SELECT 
TO_CHAR(ydate, 'YYYY') YYYY
,MIN(ydate)       min_ydate
,100 * AVG(n1dg) avg_1day_pct_gain
,MAX(ydate)      max_ydate
,COUNT(ydate)    count_ydate
FROM my_vectors
WHERE n1dg1 < -0.012
AND   n1dg2 < -0.012
GROUP BY TO_CHAR(ydate, 'YYYY')
ORDER BY AVG(n1dg)
;
