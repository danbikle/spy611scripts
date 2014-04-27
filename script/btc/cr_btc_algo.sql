--
-- ~/spy611/script/btc/cr_btc_algo.sql
--

DROP TABLE IF EXISTS btc_algo;
CREATE TABLE btc_algo
(
algo             VARCHAR(6)
,ydate           DATE
,yr              INTEGER
,prob_willbetrue NUMERIC
,pctgain         NUMERIC
,model           VARCHAR(5)
)
;
