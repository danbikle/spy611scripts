--
-- ~/spy611/script/read_svm_predictions.sql
--

-- This script depends on ~/spy611/script/svm.bash
-- This script creates tables which are read by these scripts:
-- ~/spy611/script/pred_svm.bash
-- ~/spy611/script/backtests/bt_svm_yr.bash

-- The main idea behind this script is to 
-- read recent predictions out of CSV files into tables.
-- Then, I can use SQL to study the effectiveness of the predictions.

-- Demo:
-- ~/spy611/script/psqlmad.bash -f ~/spy611/script/read_svm_predictions.sql

DROP TABLE IF EXISTS svm_predictions_n1dg;
DROP TABLE IF EXISTS svm_predictions_n2dg;
DROP TABLE IF EXISTS svm_predictions_n1wg;

CREATE TABLE svm_predictions_n1dg (pnum INTEGER,prob_willbetrue DECIMAL);
CREATE TABLE svm_predictions_n2dg (pnum INTEGER,prob_willbetrue DECIMAL);
CREATE TABLE svm_predictions_n1wg (pnum INTEGER,prob_willbetrue DECIMAL);

COPY svm_predictions_n1dg (pnum,prob_willbetrue) FROM '/tmp/svm_predictions_n1dg.csv' WITH csv;
COPY svm_predictions_n2dg (pnum,prob_willbetrue) FROM '/tmp/svm_predictions_n2dg.csv' WITH csv;
COPY svm_predictions_n1wg (pnum,prob_willbetrue) FROM '/tmp/svm_predictions_n1wg.csv' WITH csv;

-- Now, I build joins for reporting.
-- I created svm_track when I prepared the data for SVM in this script:
-- ~/spy611/script/cr_svm_oos_is_ln.sql
-- svm_track gives me date and gains.

DROP   TABLE IF EXISTS svm_rpt_n1dg;
CREATE TABLE svm_rpt_n1dg AS
SELECT p.pnum, p.prob_willbetrue, t.ydate, t.n1dg, 100*t.n1dg pctgain
FROM svm_predictions_n1dg p, svm_track t
WHERE p.pnum = t.tnum
ORDER BY p.pnum
;

DROP   TABLE IF EXISTS svm_rpt_n2dg;
CREATE TABLE svm_rpt_n2dg AS
SELECT p.pnum, p.prob_willbetrue, t.ydate, t.n2dg, 100*t.n2dg pctgain
FROM svm_predictions_n2dg p, svm_track t
WHERE p.pnum = t.tnum
ORDER BY p.pnum
;

DROP   TABLE IF EXISTS svm_rpt_n1wg;
CREATE TABLE svm_rpt_n1wg AS
SELECT p.pnum, p.prob_willbetrue, t.ydate, t.n1wg, 100*t.n1wg pctgain
FROM svm_predictions_n1wg p, svm_track t
WHERE p.pnum = t.tnum
ORDER BY p.pnum
;

-- Quick rpt:
SELECT CORR(prob_willbetrue,n1dg) FROM svm_rpt_n1dg;
SELECT CORR(prob_willbetrue,n2dg) FROM svm_rpt_n2dg;
SELECT CORR(prob_willbetrue,n1wg) FROM svm_rpt_n1wg;
