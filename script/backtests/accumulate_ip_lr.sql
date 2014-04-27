--
-- accumulate_ip_lr.sql
--

-- I used this script to accumulate initial predictions.
-- These predictions then become feature values
-- during later learning efforts.

-- Demo
-- ./psqlmad.bash -f accumulate_ip_lr.sql

-- drop table ip_n1dg;
-- drop table ip_n2dg;
-- drop table ip_n1wg;

CREATE TABLE IF NOT EXISTS ip_n1dg (algo VARCHAR(4), ydate DATE, prob_willbetrue DECIMAL, pctgain DECIMAL);
CREATE TABLE IF NOT EXISTS ip_n2dg (algo VARCHAR(4), ydate DATE, prob_willbetrue DECIMAL, pctgain DECIMAL);
CREATE TABLE IF NOT EXISTS ip_n1wg (algo VARCHAR(4), ydate DATE, prob_willbetrue DECIMAL, pctgain DECIMAL);

INSERT INTO ip_n1dg(algo, ydate,prob_willbetrue,pctgain ) SELECT 'lr', ydate,prob_willbetrue,pctgain FROM lr_rpt_n1dg;
INSERT INTO ip_n2dg(algo, ydate,prob_willbetrue,pctgain ) SELECT 'lr', ydate,prob_willbetrue,pctgain FROM lr_rpt_n2dg;
INSERT INTO ip_n1wg(algo, ydate,prob_willbetrue,pctgain ) SELECT 'lr', ydate,prob_willbetrue,pctgain FROM lr_rpt_n1wg;

