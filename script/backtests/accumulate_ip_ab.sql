--
-- accumulate_ip_ab.sql
--

-- This script is called by:
-- ~/spy611/script/backtests/bt_ab_yr.bash

-- I use this script to accumulate initial predictions.
-- These predictions then become feature values
-- during later learning efforts.

-- Demo
-- ./psqlmad.bash -f accumulate_ip_ab.sql

-- drop table ip_n1dg;
-- drop table ip_n2dg;
-- drop table ip_n1wg;

CREATE TABLE IF NOT EXISTS ip_n1dg (algo VARCHAR(4), ydate DATE, prob_willbetrue DECIMAL, pctgain DECIMAL);
CREATE TABLE IF NOT EXISTS ip_n2dg (algo VARCHAR(4), ydate DATE, prob_willbetrue DECIMAL, pctgain DECIMAL);
CREATE TABLE IF NOT EXISTS ip_n1wg (algo VARCHAR(4), ydate DATE, prob_willbetrue DECIMAL, pctgain DECIMAL);

INSERT INTO ip_n1dg(algo, ydate,prob_willbetrue,pctgain ) SELECT 'ab', ydate,prob_willbetrue,pctgain FROM ab_rpt_n1dg;
INSERT INTO ip_n2dg(algo, ydate,prob_willbetrue,pctgain ) SELECT 'ab', ydate,prob_willbetrue,pctgain FROM ab_rpt_n2dg;
INSERT INTO ip_n1wg(algo, ydate,prob_willbetrue,pctgain ) SELECT 'ab', ydate,prob_willbetrue,pctgain FROM ab_rpt_n1wg;

