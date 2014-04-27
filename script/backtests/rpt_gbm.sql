--
-- ~/spy611/script/backtests/rpt_gbm.sql
--

-- Demo:
-- psqlhtml.bash -f rpt_gbm.sql -v ng=n1dg

-- I use this script to generate an html report

\T class=table_total
SELECT 'Total number of observations for this period:' mycomment
,COUNT(pctgain) observation_count
FROM gbm_rpt_:ng
;

\T class=table_lt49
SELECT
'On average, did model predict gain of each observation? (where UP-class probability less than 50%)'  test_description
,a.not_up_prediction_count
,ROUND(a.avg_pct_gain_where_prob_lt_pt49,4) avg_pct_gain_where_prob_lt_pt49
,ROUND(b.avg_pct_gain_forall_obsrvtns,4)    avg_pct_gain_forall_obsrvtns
,CASE WHEN avg_pct_gain_where_prob_lt_pt49 < avg_pct_gain_forall_obsrvtns 
  THEN 'Model Succeeded' ELSE 'Model Failed' END model_result
,'Model should predict observations which have small or negative gains. These gains should average less than average for all observations.' more_information
FROM
(
SELECT
COUNT(pctgain) not_up_prediction_count
,AVG(pctgain) avg_pct_gain_where_prob_lt_pt49
FROM gbm_rpt_:ng
WHERE prob_willbetrue < 0.50
)a,
(SELECT
AVG(pctgain) avg_pct_gain_forall_obsrvtns
FROM gbm_rpt_:ng
)b
;

\T class=table_gt51
SELECT
'On average, did model predict gain of each observation? (where UP-class probability greater than or equal 50%)'  test_description
,a.up_prediction_count
,ROUND(a.avg_pct_gain_where_prob_gt_pt51,4) avg_pct_gain_where_prob_gt_pt51
,ROUND(b.avg_pct_gain_forall_obsrvtns,4)    avg_pct_gain_forall_obsrvtns
,CASE WHEN avg_pct_gain_where_prob_gt_pt51 > avg_pct_gain_forall_obsrvtns 
  THEN 'Model Succeeded' ELSE 'Model Failed' END model_result
,'Model should predict observations which have positive gains. These gains should average more than average for all observations.' more_information
FROM
(
SELECT
COUNT(pctgain) up_prediction_count
,AVG(pctgain) avg_pct_gain_where_prob_gt_pt51
FROM gbm_rpt_:ng
WHERE prob_willbetrue >= 0.50
)a,
(SELECT
AVG(pctgain) avg_pct_gain_forall_obsrvtns
FROM gbm_rpt_:ng
)b
;
