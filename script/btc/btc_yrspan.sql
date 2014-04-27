--
-- ~/spy611/script/btc/btc_yrspan.sql
--

-- Demo:
-- ./psqlhtml.bash -f btc_yrspan.sql -v algos="${ALGOS}" -v datemin="'$DATEMIN'" -v datemax="'$DATEMAX'" > $ERBFILE

DROP TABLE IF EXISTS   btc_yrspan_nup;
DROP TABLE IF EXISTS   btc_yrspan_up;

CREATE TABLE btc_yrspan_nup AS
SELECT
algo
,COUNT(ydate) count_nup
,MIN(ydate)   min_date_nup
,MAX(ydate)   max_date_nup
,AVG(pctgain) avg_pctgain_nup
FROM btc_algo
WHERE algo IN (:algos)
AND ydate BETWEEN :datemin AND :datemax
AND prob_willbetrue < 0.5
GROUP BY algo
;

CREATE TABLE btc_yrspan_up AS
SELECT
algo
,COUNT(ydate) count_up
,MIN(ydate)   min_date_up
,MAX(ydate)   max_date_up
,AVG(pctgain) avg_pctgain_up
FROM btc_algo
WHERE algo IN (:algos)
AND ydate BETWEEN :datemin AND :datemax
AND prob_willbetrue >= 0.5
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
FROM btc_yrspan_nup n,btc_yrspan_up u
WHERE u.algo = n.algo
ORDER BY algo
;
