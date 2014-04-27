--
-- ~/spy611/script/btc/btc_model.sql
--

-- Demo:
-- ./psqlhtml.bash -f btc_model.sql -v model="'${MODEL}'" > $ERBFILE

DROP TABLE IF EXISTS   btc_model_nup;
DROP TABLE IF EXISTS   btc_model_up;

CREATE TABLE btc_model_nup AS
SELECT
algo
,COUNT(ydate) count_nup
,MIN(ydate)   min_date_nup
,MAX(ydate)   max_date_nup
,AVG(pctgain) avg_pctgain_nup
FROM btc_algo
WHERE prob_willbetrue < 0.5
AND model = :model
GROUP BY algo
;

CREATE TABLE btc_model_up AS
SELECT
algo
,COUNT(ydate) count_up
,MIN(ydate)   min_date_up
,MAX(ydate)   max_date_up
,AVG(pctgain) avg_pctgain_up
FROM btc_algo
WHERE prob_willbetrue >= 0.5
AND model = :model
GROUP BY algo
;

\T class=sortable1
SELECT
u.algo
,count_nup
,count_up
,CASE WHEN min_date_nup < min_date_up THEN min_date_nup ELSE min_date_up END min_date
,CASE WHEN max_date_nup < max_date_up THEN max_date_up ELSE max_date_nup END max_date
,ROUND(avg_pctgain_nup,4) avg_pctgain_nup
,ROUND(avg_pctgain_up,4)  avg_pctgain_up
,ROUND((avg_pctgain_up
- avg_pctgain_nup),4)     diff_of_avgs
FROM btc_model_nup n,btc_model_up u
WHERE u.algo = n.algo
ORDER BY algo
;

DROP TABLE IF EXISTS   btc_model_nup;
DROP TABLE IF EXISTS   btc_model_up;

CREATE TABLE btc_model_nup AS
SELECT
yr
,algo
,COUNT(ydate) count_nup
,MIN(ydate)   min_date_nup
,MAX(ydate)   max_date_nup
,AVG(pctgain) avg_pctgain_nup
FROM btc_algo
WHERE prob_willbetrue < 0.5
AND model = :model
GROUP BY algo,yr
;

CREATE TABLE btc_model_up AS
SELECT
yr
,algo
,COUNT(ydate) count_up
,MIN(ydate)   min_date_up
,MAX(ydate)   max_date_up
,AVG(pctgain) avg_pctgain_up
FROM btc_algo
WHERE prob_willbetrue >= 0.5
AND model = :model
GROUP BY algo,yr
;

\T class=sortable2
SELECT
u.yr
,u.algo
,count_nup
,count_up
,CASE WHEN min_date_nup < min_date_up THEN min_date_nup ELSE min_date_up END min_date
,CASE WHEN max_date_nup < max_date_up THEN max_date_up ELSE max_date_nup END max_date
,ROUND(avg_pctgain_nup,4) avg_pctgain_nup
,ROUND(avg_pctgain_up,4)  avg_pctgain_up
,ROUND((avg_pctgain_up
- avg_pctgain_nup),4)     diff_of_avgs
FROM btc_model_nup n,btc_model_up u
WHERE u.algo = n.algo
AND   u.yr   = n.yr
ORDER BY yr,algo
;
