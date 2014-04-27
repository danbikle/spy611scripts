--
-- ~/spy611/script/backtests/accumulate_gbm.sql
--

-- I use this script to accumulate prediction results
-- when I am running 
-- ~/spy611/script/backtests/bt2p_gbm.bash

-- Later I will report on the accumulated prediction results
-- via path: btall_gbm/YYYY 
-- Using: ~/spy611/script/backtests/rpt_bt.sql

-- If this table exists already, that is okay:
CREATE TABLE bt_n1dg AS SELECT prob_willbetrue,pctgain FROM gbm_rpt_n1dg WHERE 1=2;
CREATE TABLE bt_n2dg AS SELECT prob_willbetrue,pctgain FROM gbm_rpt_n2dg WHERE 1=2;
CREATE TABLE bt_n1wg AS SELECT prob_willbetrue,pctgain FROM gbm_rpt_n1wg WHERE 1=2;
INSERT INTO bt_n1dg(prob_willbetrue,pctgain) SELECT prob_willbetrue,pctgain FROM gbm_rpt_n1dg;
INSERT INTO bt_n2dg(prob_willbetrue,pctgain) SELECT prob_willbetrue,pctgain FROM gbm_rpt_n2dg;
INSERT INTO bt_n1wg(prob_willbetrue,pctgain) SELECT prob_willbetrue,pctgain FROM gbm_rpt_n1wg;
-- I delete the above tables from ~/spy611/script/backtests/backtests_gbm.bash
-- I delete them when I transition from 1 decade to another.
