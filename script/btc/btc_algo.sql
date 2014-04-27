--
-- ~/spy611/script/btc/btc_algo.sql
--

-- Demo:
-- ./psqlhtml.bash -f btc_algo.sql -v algo="'${ALGO}'" > $ERBFILE

DROP TABLE IF EXISTS   btc_algo_nup;
DROP TABLE IF EXISTS   btc_algo_up;

CREATE TABLE btc_algo_nup AS
SELECT
COUNT(ydate)  count_nup
,MIN(ydate)   min_date_nup
,MAX(ydate)   max_date_nup
,AVG(pctgain) avg_pctgain_nup
FROM btc_algo
WHERE prob_willbetrue < 0.5
AND algo = :algo
;

CREATE TABLE btc_algo_up AS
SELECT
COUNT(ydate)  count_up
,MIN(ydate)   min_date_up
,MAX(ydate)   max_date_up
,AVG(pctgain) avg_pctgain_up
FROM btc_algo
WHERE prob_willbetrue >= 0.5
AND algo = :algo
;

SELECT
count_nup
,count_up
,CASE WHEN min_date_nup < min_date_up THEN min_date_nup ELSE min_date_up END min_date
,CASE WHEN max_date_nup < max_date_up THEN max_date_up ELSE max_date_nup END max_date
,ROUND(avg_pctgain_nup,4) avg_pctgain_nup
,ROUND(avg_pctgain_up,4)  avg_pctgain_up
,ROUND((avg_pctgain_up
- avg_pctgain_nup),4)     diff_of_avgs
FROM btc_algo_nup,btc_algo_up
;

DROP TABLE IF EXISTS   btc_algo_nup;
DROP TABLE IF EXISTS   btc_algo_up;

CREATE TABLE btc_algo_nup AS
SELECT
yr
,COUNT(ydate) count_nup
,MIN(ydate)   min_date_nup
,MAX(ydate)   max_date_nup
,AVG(pctgain) avg_pctgain_nup
FROM btc_algo
WHERE prob_willbetrue < 0.5
AND algo = :algo
GROUP BY yr
;

CREATE TABLE btc_algo_up AS
SELECT
yr
,COUNT(ydate) count_up
,MIN(ydate)   min_date_up
,MAX(ydate)   max_date_up
,AVG(pctgain) avg_pctgain_up
FROM btc_algo
WHERE prob_willbetrue >= 0.5
AND algo = :algo
GROUP BY yr
;

\T class=sortable1
SELECT
u.yr
,count_nup
,count_up
,CASE WHEN min_date_nup < min_date_up THEN min_date_nup ELSE min_date_up END min_date
,CASE WHEN max_date_nup < max_date_up THEN max_date_up ELSE max_date_nup END max_date
,ROUND(avg_pctgain_nup,4) avg_pctgain_nup
,ROUND(avg_pctgain_up,4)  avg_pctgain_up
,ROUND((avg_pctgain_up
- avg_pctgain_nup),4)     diff_of_avgs
FROM btc_algo_nup n,btc_algo_up u
WHERE u.yr = n.yr
ORDER BY yr
;
