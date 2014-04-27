--
-- ~/spy611/script/btc/ins_btc_algo.sql
--

-- I use this script to collect data from tables ip_n* and np_n* into
-- table btc_algo.

-- I intend to run this script once a month so 
-- I care little about its expense.

INSERT INTO btc_algo
(
algo
,ydate
,yr
,prob_willbetrue
,pctgain
,model
)
SELECT
algo
,ydate
,TO_CHAR(ydate,'YYYY')::INTEGER yr
,prob_willbetrue
,pctgain
,:model
FROM ip_:ng
;

INSERT INTO btc_algo
(
algo
,ydate
,yr
,prob_willbetrue
,pctgain
,model
)
SELECT
algo||'2lr' algo
,ydate
,TO_CHAR(ydate,'YYYY')::INTEGER yr
,prob_willbetrue
,pctgain
,:model
FROM np_:ng
;

