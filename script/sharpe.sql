--
-- ~/spy611/script/sharpe.sql
--

-- I use this script to look at Sharpe Ratio

SELECT
MIN(ydate)       min_date
,MAX(ydate)      max_date
,COUNT(pctgain)  prediction_count
,AVG(pctgain)    avg_pctgain 
,STDDEV(pctgain) stddev_pg
,AVG(pctgain)/STDDEV(pctgain) sharpe_r
FROM np_n1dg
;

SELECT
MIN(ydate)       min_date
,MAX(ydate)      max_date
,COUNT(pctgain)  prediction_count
,AVG(pctgain)    avg_pctgain 
,STDDEV(pctgain) stddev_pg
,AVG(pctgain)/STDDEV(pctgain) sharpe_r
FROM np_n2dg
;

SELECT
MIN(ydate)       min_date
,MAX(ydate)      max_date
,COUNT(pctgain)  prediction_count
,AVG(pctgain)    avg_pctgain 
,STDDEV(pctgain) stddev_pg
,AVG(pctgain)/STDDEV(pctgain) sharpe_r
FROM np_n1wg
;

SELECT
algo
,COUNT(pctgain) prediction_count
,AVG(pctgain)   avg_pctgain 
,STDDEV(pctgain) stddev_pg
,AVG(pctgain)/STDDEV(pctgain) sharpe_r
FROM np_n1dg
WHERE prob_willbetrue > 0.51
GROUP BY algo
ORDER BY algo
;

SELECT
algo
,COUNT(pctgain) prediction_count
,AVG(pctgain)   avg_pctgain 
,STDDEV(pctgain) stddev_pg
,AVG(pctgain)/STDDEV(pctgain) sharpe_r
FROM np_n2dg
WHERE prob_willbetrue > 0.51
GROUP BY algo
ORDER BY algo
;

SELECT
algo
,COUNT(pctgain) prediction_count
,AVG(pctgain)   avg_pctgain 
,STDDEV(pctgain) stddev_pg
,AVG(pctgain)/STDDEV(pctgain) sharpe_r
FROM np_n1wg
WHERE prob_willbetrue > 0.51
GROUP BY algo
ORDER BY algo
;

-- neg


SELECT
algo
,COUNT(pctgain) prediction_count
,AVG(pctgain)   avg_pctgain 
,STDDEV(pctgain) stddev_pg
,AVG(pctgain)/STDDEV(pctgain) sharpe_r
FROM np_n1dg
WHERE prob_willbetrue < 0.49
GROUP BY algo
ORDER BY algo
;

SELECT
algo
,COUNT(pctgain) prediction_count
,AVG(pctgain)   avg_pctgain 
,STDDEV(pctgain) stddev_pg
,AVG(pctgain)/STDDEV(pctgain) sharpe_r
FROM np_n2dg
WHERE prob_willbetrue < 0.49
GROUP BY algo
ORDER BY algo
;

SELECT
algo
,COUNT(pctgain) prediction_count
,AVG(pctgain)   avg_pctgain 
,STDDEV(pctgain) stddev_pg
,AVG(pctgain)/STDDEV(pctgain) sharpe_r
FROM np_n1wg
WHERE prob_willbetrue < 0.49
GROUP BY algo
ORDER BY algo
;
