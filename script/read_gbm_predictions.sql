--
-- ~/spy611/script/read_gbm_predictions.sql
--

-- This script depends on ~/spy611/script/gbm.py
-- This script creates tables which are read by this script:
-- ~/spy611/script/backtests/btln2p_gbm.bash

-- The main idea behind this script is to 
-- read recent predictions out of 2 column tables into wider tables.
-- Then, I can use SQL to study the effectiveness of the predictions.

-- Demo:
-- ~/spy611/script/psqlmad.bash -f ~/spy611/script/read_gbm_predictions.sql

-- Now, I build joins for reporting.
-- I created gbm_track when I prepared the data for GBM in this script:
-- ~/spy611/script/cr_gbm_oos_is_ln.sql
-- gbm_track gives me date and gains.

DROP   TABLE IF EXISTS gbm_rpt_n1dg;
CREATE TABLE gbm_rpt_n1dg AS
SELECT p.pnum, p.prob_willbetrue, t.ydate, t.n1dg, 100*t.n1dg pctgain
FROM gbm_predictions_n1dg p, gbm_track t
WHERE p.pnum = t.tnum
ORDER BY p.pnum
;

DROP   TABLE IF EXISTS gbm_rpt_n2dg;
CREATE TABLE gbm_rpt_n2dg AS
SELECT p.pnum, p.prob_willbetrue, t.ydate, t.n2dg, 100*t.n2dg pctgain
FROM gbm_predictions_n2dg p, gbm_track t
WHERE p.pnum = t.tnum
ORDER BY p.pnum
;

DROP   TABLE IF EXISTS gbm_rpt_n1wg;
CREATE TABLE gbm_rpt_n1wg AS
SELECT p.pnum, p.prob_willbetrue, t.ydate, t.n1wg, 100*t.n1wg pctgain
FROM gbm_predictions_n1wg p, gbm_track t
WHERE p.pnum = t.tnum
ORDER BY p.pnum
;

-- Quick rpt:
SELECT CORR(prob_willbetrue,n1dg) FROM gbm_rpt_n1dg;
SELECT CORR(prob_willbetrue,n2dg) FROM gbm_rpt_n2dg;
SELECT CORR(prob_willbetrue,n1wg) FROM gbm_rpt_n1wg;
