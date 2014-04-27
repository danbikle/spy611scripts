--
-- ~/spy611/script/backtests/qry_ip.sql
--

-- Demo:
-- ./psqlmad.bash -f qry_ip.sql

-- I use this script to query the contents of 'initial predictions' tables.

SELECT
algo
,COUNT(algo) count_algo
FROM ip_n1dg
GROUP BY algo
ORDER BY algo
;

SELECT
algo
,COUNT(algo) count_algo
FROM ip_n2dg
GROUP BY algo
ORDER BY algo
;

SELECT
algo
,COUNT(algo) count_algo
FROM ip_n1wg
GROUP BY algo
ORDER BY algo
;

SELECT
algo
,COUNT(algo) count_algo
FROM ip_n1dg
WHERE ydate < '2014-01-01'
GROUP BY algo
ORDER BY algo
;

SELECT
TO_CHAR(ydate,'YYYY') yr
,COUNT(TO_CHAR(ydate,'YYYY')) count_yr
FROM ip_n1dg
GROUP BY TO_CHAR(ydate,'YYYY')
ORDER BY TO_CHAR(ydate,'YYYY')
;

-- Look at effectiveness

SELECT
algo
,AVG(pctgain) avg_pctgain
FROM ip_n1dg
GROUP BY algo
ORDER BY AVG(pctgain)
;

SELECT
algo
,AVG(pctgain) avg_pctgain
FROM ip_n2dg
GROUP BY algo
ORDER BY AVG(pctgain)
;

SELECT
algo
,AVG(pctgain) avg_pctgain
FROM ip_n1wg
GROUP BY algo
ORDER BY AVG(pctgain)
;

SELECT
algo
,AVG(pctgain) avg_pctgain
FROM ip_n1dg
WHERE prob_willbetrue >= 0.50
GROUP BY algo
ORDER BY AVG(pctgain)
;

SELECT
algo
,AVG(pctgain) avg_pctgain
FROM ip_n2dg
WHERE prob_willbetrue >= 0.50
GROUP BY algo
ORDER BY AVG(pctgain)
;

SELECT
algo
,AVG(pctgain) avg_pctgain
FROM ip_n1wg
WHERE prob_willbetrue >= 0.50
GROUP BY algo
ORDER BY AVG(pctgain)
;
