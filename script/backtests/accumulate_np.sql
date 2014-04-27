--
-- ~/spy611/script/backtests/accumulate_np.sql
--

-- I use this script to accumulate 'next' predictions.
-- These predictions then become interesting
-- data for reports.

-- Demo
-- ./psqlmad.bash -f accumulate_np.sql -v algo="'$ALGO'"

-- drop table np_n1dg;
-- drop table np_n2dg;
-- drop table np_n1wg;

CREATE TABLE IF NOT EXISTS np_n1dg (algo VARCHAR(4), ydate DATE, prob_willbetrue DECIMAL, pctgain DECIMAL);
CREATE TABLE IF NOT EXISTS np_n2dg (algo VARCHAR(4), ydate DATE, prob_willbetrue DECIMAL, pctgain DECIMAL);
CREATE TABLE IF NOT EXISTS np_n1wg (algo VARCHAR(4), ydate DATE, prob_willbetrue DECIMAL, pctgain DECIMAL);

INSERT INTO np_n1dg(algo, ydate,prob_willbetrue,pctgain ) SELECT :algo, ydate,prob_willbetrue,pctgain FROM lr_rpt_n1dg;
INSERT INTO np_n2dg(algo, ydate,prob_willbetrue,pctgain ) SELECT :algo, ydate,prob_willbetrue,pctgain FROM lr_rpt_n2dg;
INSERT INTO np_n1wg(algo, ydate,prob_willbetrue,pctgain ) SELECT :algo, ydate,prob_willbetrue,pctgain FROM lr_rpt_n1wg;

