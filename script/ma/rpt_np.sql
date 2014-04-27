--
-- ~/spy611/script/ma/rpt_np.sql
--

-- For now this is a simple rpt.

-- Summarize first:
SELECT CORR(prob_willbetrue,pctgain) FROM np_n1dg WHERE algo='gbm';
SELECT CORR(prob_willbetrue,pctgain) FROM np_n2dg WHERE algo='gbm';
SELECT CORR(prob_willbetrue,pctgain) FROM np_n1wg WHERE algo='gbm';

-- Yr drilldown:
SELECT TO_CHAR(ydate,'YYYY') yyyy,COUNT(ydate) pcount,CORR(prob_willbetrue,pctgain) FROM np_n1dg WHERE algo='gbm' GROUP BY TO_CHAR(ydate,'YYYY') ORDER BY TO_CHAR(ydate,'YYYY');
SELECT TO_CHAR(ydate,'YYYY') yyyy,COUNT(ydate) pcount,CORR(prob_willbetrue,pctgain) FROM np_n2dg WHERE algo='gbm' GROUP BY TO_CHAR(ydate,'YYYY') ORDER BY TO_CHAR(ydate,'YYYY');
SELECT TO_CHAR(ydate,'YYYY') yyyy,COUNT(ydate) pcount,CORR(prob_willbetrue,pctgain) FROM np_n1wg WHERE algo='gbm' GROUP BY TO_CHAR(ydate,'YYYY') ORDER BY TO_CHAR(ydate,'YYYY');

SELECT TO_CHAR(ydate,'YYYY') yyyy,AVG(pctgain) avg_pctgain,COUNT(ydate) pcount
FROM np_n1dg
WHERE algo='gbm' 
AND prob_willbetrue >= 0.5
GROUP BY TO_CHAR(ydate,'YYYY') ORDER BY TO_CHAR(ydate,'YYYY')
;

SELECT TO_CHAR(ydate,'YYYY') yyyy,AVG(pctgain) avg_pctgain,COUNT(ydate) pcount
FROM np_n2dg
WHERE algo='gbm' 
AND prob_willbetrue >= 0.5
GROUP BY TO_CHAR(ydate,'YYYY') ORDER BY TO_CHAR(ydate,'YYYY')
;

SELECT TO_CHAR(ydate,'YYYY') yyyy,AVG(pctgain) avg_pctgain,COUNT(ydate) pcount
FROM np_n1wg
WHERE algo='gbm' 
AND prob_willbetrue >= 0.5
GROUP BY TO_CHAR(ydate,'YYYY') ORDER BY TO_CHAR(ydate,'YYYY')
;

SELECT TO_CHAR(ydate,'YYYY') yyyy,AVG(pctgain) avg_pctgain,COUNT(ydate) pcount
FROM np_n1dg
WHERE algo='gbm' 
AND prob_willbetrue < 0.5
GROUP BY TO_CHAR(ydate,'YYYY') ORDER BY TO_CHAR(ydate,'YYYY')
;

SELECT TO_CHAR(ydate,'YYYY') yyyy,AVG(pctgain) avg_pctgain,COUNT(ydate) pcount
FROM np_n2dg
WHERE algo='gbm' 
AND prob_willbetrue < 0.5
GROUP BY TO_CHAR(ydate,'YYYY') ORDER BY TO_CHAR(ydate,'YYYY')
;

SELECT TO_CHAR(ydate,'YYYY') yyyy,AVG(pctgain) avg_pctgain,COUNT(ydate) pcount
FROM np_n1wg
WHERE algo='gbm' 
AND prob_willbetrue < 0.5
GROUP BY TO_CHAR(ydate,'YYYY') ORDER BY TO_CHAR(ydate,'YYYY')
;

--


SELECT TO_CHAR(ydate,'YYYY') yyyy,AVG(pctgain) avg_pctgain,COUNT(ydate) pcount
FROM np_n1dg
WHERE algo='gbm' 
AND prob_willbetrue >= 0.52
GROUP BY TO_CHAR(ydate,'YYYY') ORDER BY TO_CHAR(ydate,'YYYY')
;

SELECT TO_CHAR(ydate,'YYYY') yyyy,AVG(pctgain) avg_pctgain,COUNT(ydate) pcount
FROM np_n2dg
WHERE algo='gbm' 
AND prob_willbetrue >= 0.52
GROUP BY TO_CHAR(ydate,'YYYY') ORDER BY TO_CHAR(ydate,'YYYY')
;

SELECT TO_CHAR(ydate,'YYYY') yyyy,AVG(pctgain) avg_pctgain,COUNT(ydate) pcount
FROM np_n1wg
WHERE algo='gbm' 
AND prob_willbetrue >= 0.52
GROUP BY TO_CHAR(ydate,'YYYY') ORDER BY TO_CHAR(ydate,'YYYY')
;

SELECT TO_CHAR(ydate,'YYYY') yyyy,AVG(pctgain) avg_pctgain,COUNT(ydate) pcount
FROM np_n1dg
WHERE algo='gbm' 
AND prob_willbetrue < 0.48
GROUP BY TO_CHAR(ydate,'YYYY') ORDER BY TO_CHAR(ydate,'YYYY')
;

SELECT TO_CHAR(ydate,'YYYY') yyyy,AVG(pctgain) avg_pctgain,COUNT(ydate) pcount
FROM np_n2dg
WHERE algo='gbm' 
AND prob_willbetrue < 0.48
GROUP BY TO_CHAR(ydate,'YYYY') ORDER BY TO_CHAR(ydate,'YYYY')
;

SELECT TO_CHAR(ydate,'YYYY') yyyy,AVG(pctgain) avg_pctgain,COUNT(ydate) pcount
FROM np_n1wg
WHERE algo='gbm' 
AND prob_willbetrue < 0.48
GROUP BY TO_CHAR(ydate,'YYYY') ORDER BY TO_CHAR(ydate,'YYYY')
;


--


SELECT TO_CHAR(ydate,'YYYY') yyyy,AVG(pctgain)/STDDEV(pctgain) sharpe,COUNT(ydate) pcount
FROM np_n1dg
WHERE algo='gbm' 
AND prob_willbetrue >= 0.52
GROUP BY TO_CHAR(ydate,'YYYY') ORDER BY TO_CHAR(ydate,'YYYY')
;

SELECT TO_CHAR(ydate,'YYYY') yyyy,AVG(pctgain)/STDDEV(pctgain) sharpe,COUNT(ydate) pcount
FROM np_n2dg
WHERE algo='gbm' 
AND prob_willbetrue >= 0.52
GROUP BY TO_CHAR(ydate,'YYYY') ORDER BY TO_CHAR(ydate,'YYYY')
;

SELECT TO_CHAR(ydate,'YYYY') yyyy,AVG(pctgain)/STDDEV(pctgain) sharpe,COUNT(ydate) pcount
FROM np_n1wg
WHERE algo='gbm' 
AND prob_willbetrue >= 0.52
GROUP BY TO_CHAR(ydate,'YYYY') ORDER BY TO_CHAR(ydate,'YYYY')
;

SELECT TO_CHAR(ydate,'YYYY') yyyy,AVG(pctgain)/STDDEV(pctgain) sharpe,COUNT(ydate) pcount
FROM np_n1dg
WHERE algo='gbm' 
AND prob_willbetrue < 0.48
GROUP BY TO_CHAR(ydate,'YYYY') ORDER BY TO_CHAR(ydate,'YYYY')
;

SELECT TO_CHAR(ydate,'YYYY') yyyy,AVG(pctgain)/STDDEV(pctgain) sharpe,COUNT(ydate) pcount
FROM np_n2dg
WHERE algo='gbm' 
AND prob_willbetrue < 0.48
GROUP BY TO_CHAR(ydate,'YYYY') ORDER BY TO_CHAR(ydate,'YYYY')
;

SELECT TO_CHAR(ydate,'YYYY') yyyy,AVG(pctgain)/STDDEV(pctgain) sharpe,COUNT(ydate) pcount
FROM np_n1wg
WHERE algo='gbm' 
AND prob_willbetrue < 0.48
GROUP BY TO_CHAR(ydate,'YYYY') ORDER BY TO_CHAR(ydate,'YYYY')
;


--


SELECT TO_CHAR(ydate,'YYYY') yyyy,AVG(pctgain)/STDDEV(pctgain) sharpe,COUNT(ydate) pcount
FROM np_n1dg
WHERE algo='gbm' 
AND prob_willbetrue >= 0.5
GROUP BY TO_CHAR(ydate,'YYYY') ORDER BY TO_CHAR(ydate,'YYYY')
;

SELECT TO_CHAR(ydate,'YYYY') yyyy,AVG(pctgain)/STDDEV(pctgain) sharpe,COUNT(ydate) pcount
FROM np_n2dg
WHERE algo='gbm' 
AND prob_willbetrue >= 0.5
GROUP BY TO_CHAR(ydate,'YYYY') ORDER BY TO_CHAR(ydate,'YYYY')
;

SELECT TO_CHAR(ydate,'YYYY') yyyy,AVG(pctgain)/STDDEV(pctgain) sharpe,COUNT(ydate) pcount
FROM np_n1wg
WHERE algo='gbm' 
AND prob_willbetrue >= 0.5
GROUP BY TO_CHAR(ydate,'YYYY') ORDER BY TO_CHAR(ydate,'YYYY')
;

SELECT TO_CHAR(ydate,'YYYY') yyyy,AVG(pctgain)/STDDEV(pctgain) sharpe,COUNT(ydate) pcount
FROM np_n1dg
WHERE algo='gbm' 
AND prob_willbetrue < 0.5
GROUP BY TO_CHAR(ydate,'YYYY') ORDER BY TO_CHAR(ydate,'YYYY')
;

SELECT TO_CHAR(ydate,'YYYY') yyyy,AVG(pctgain)/STDDEV(pctgain) sharpe,COUNT(ydate) pcount
FROM np_n2dg
WHERE algo='gbm' 
AND prob_willbetrue < 0.5
GROUP BY TO_CHAR(ydate,'YYYY') ORDER BY TO_CHAR(ydate,'YYYY')
;

SELECT TO_CHAR(ydate,'YYYY') yyyy,AVG(pctgain)/STDDEV(pctgain) sharpe,COUNT(ydate) pcount
FROM np_n1wg
WHERE algo='gbm' 
AND prob_willbetrue < 0.5
GROUP BY TO_CHAR(ydate,'YYYY') ORDER BY TO_CHAR(ydate,'YYYY')
;

--


SELECT AVG(pctgain)/STDDEV(pctgain) sharpe,COUNT(ydate) pcount
FROM np_n1dg
WHERE algo='gbm' 
AND prob_willbetrue >= 0.5
;

SELECT AVG(pctgain)/STDDEV(pctgain) sharpe,COUNT(ydate) pcount
FROM np_n2dg
WHERE algo='gbm' 
AND prob_willbetrue >= 0.5
;

SELECT AVG(pctgain)/STDDEV(pctgain) sharpe,COUNT(ydate) pcount
FROM np_n1wg
WHERE algo='gbm' 
AND prob_willbetrue >= 0.5
;

SELECT AVG(pctgain)/STDDEV(pctgain) sharpe,COUNT(ydate) pcount
FROM np_n1dg
WHERE algo='gbm' 
AND prob_willbetrue < 0.5
;

SELECT AVG(pctgain)/STDDEV(pctgain) sharpe,COUNT(ydate) pcount
FROM np_n2dg
WHERE algo='gbm' 
AND prob_willbetrue < 0.5
;

SELECT AVG(pctgain)/STDDEV(pctgain) sharpe,COUNT(ydate) pcount
FROM np_n1wg
WHERE algo='gbm' 
AND prob_willbetrue < 0.5
;
