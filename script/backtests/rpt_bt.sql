--
-- ~/spy611/script/backtests/rpt_bt.sql
--

-- Demo:
-- ~/spy611/script/psqlhtml.bash -f rpt_bt.sql -v ng=n1dg
-- ~/spy611/script/psqlmad.bash  -f rpt_bt.sql -v ng=n1dg

-- I use this script to generate an html report

\T class=table_total
SELECT 'Total number of observations for this period:' mycomment
,COUNT(pctgain) observation_count
FROM bt_:ng
;


\T class=table_lt49
SELECT
'On average, did model predict gain of each observation? (where UP-class probability less than 45%)'  test_description
,a.not_up_prediction_count
,ROUND(a.avg_pct_gain_where_prob_lt_pt45,4) avg_pct_gain_where_prob_lt_pt45
,ROUND(b.avg_pct_gain_forall_obsrvtns,4)    avg_pct_gain_forall_obsrvtns
,CASE WHEN avg_pct_gain_where_prob_lt_pt45 < avg_pct_gain_forall_obsrvtns 
  THEN 'Model Succeeded' ELSE 'Model Failed' END model_result
,'Model should predict observations which have small or negative gains. These gains should average less than average for all observations.' more_information
FROM
(
SELECT
COUNT(pctgain) not_up_prediction_count
,AVG(pctgain) avg_pct_gain_where_prob_lt_pt45
FROM bt_:ng
WHERE prob_willbetrue < 0.45
)a,
(SELECT
AVG(pctgain) avg_pct_gain_forall_obsrvtns
FROM bt_:ng
)b
;

\T class=table_lt49
SELECT
'On average, did model predict gain of each observation? (where UP-class probability less than 48%)'  test_description
,a.not_up_prediction_count
,ROUND(a.avg_pct_gain_where_prob_lt_pt48,4) avg_pct_gain_where_prob_lt_pt48
,ROUND(b.avg_pct_gain_forall_obsrvtns,4)    avg_pct_gain_forall_obsrvtns
,CASE WHEN avg_pct_gain_where_prob_lt_pt48 < avg_pct_gain_forall_obsrvtns 
  THEN 'Model Succeeded' ELSE 'Model Failed' END model_result
,'Model should predict observations which have small or negative gains. These gains should average less than average for all observations.' more_information
FROM
(
SELECT
COUNT(pctgain) not_up_prediction_count
,AVG(pctgain) avg_pct_gain_where_prob_lt_pt48
FROM bt_:ng
WHERE prob_willbetrue < 0.48
)a,
(SELECT
AVG(pctgain) avg_pct_gain_forall_obsrvtns
FROM bt_:ng
)b
;

\T class=table_lt49
SELECT
'On average, did model predict gain of each observation? (where UP-class probability less than 49%)'  test_description
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
FROM bt_:ng
WHERE prob_willbetrue < 0.49
)a,
(SELECT
AVG(pctgain) avg_pct_gain_forall_obsrvtns
FROM bt_:ng
)b
;

\T class=table_gt51
SELECT
'On average, did model predict gain of each observation? (where UP-class probability greater than 51%)'  test_description
,a.not_up_prediction_count
,ROUND(a.avg_pct_gain_where_prob_gt_pt51,4) avg_pct_gain_where_prob_gt_pt51
,ROUND(b.avg_pct_gain_forall_obsrvtns,4)    avg_pct_gain_forall_obsrvtns
,CASE WHEN avg_pct_gain_where_prob_gt_pt51 > avg_pct_gain_forall_obsrvtns 
  THEN 'Model Succeeded' ELSE 'Model Failed' END model_result
,'Model should predict observations which have positive gains. These gains should average more than average for all observations.' more_information
FROM
(
SELECT
COUNT(pctgain) not_up_prediction_count
,AVG(pctgain) avg_pct_gain_where_prob_gt_pt51
FROM bt_:ng
WHERE prob_willbetrue > 0.51
)a,
(SELECT
AVG(pctgain) avg_pct_gain_forall_obsrvtns
FROM bt_:ng
)b
;


\T class=table_gt51
SELECT
'On average, did model predict gain of each observation? (where UP-class probability greater than 52%)'  test_description
,a.not_up_prediction_count
,ROUND(a.avg_pct_gain_where_prob_gt_pt52,4) avg_pct_gain_where_prob_gt_pt52
,ROUND(b.avg_pct_gain_forall_obsrvtns,4)    avg_pct_gain_forall_obsrvtns
,CASE WHEN avg_pct_gain_where_prob_gt_pt52 > avg_pct_gain_forall_obsrvtns 
  THEN 'Model Succeeded' ELSE 'Model Failed' END model_result
,'Model should predict observations which have positive gains. These gains should average more than average for all observations.' more_information
FROM
(
SELECT
COUNT(pctgain) not_up_prediction_count
,AVG(pctgain) avg_pct_gain_where_prob_gt_pt52
FROM bt_:ng
WHERE prob_willbetrue > 0.52
)a,
(SELECT
AVG(pctgain) avg_pct_gain_forall_obsrvtns
FROM bt_:ng
)b
;

\T class=table_gt51
SELECT
'On average, did model predict gain of each observation? (where UP-class probability greater than 55%)'  test_description
,a.not_up_prediction_count
,ROUND(a.avg_pct_gain_where_prob_gt_pt55,4) avg_pct_gain_where_prob_gt_pt55
,ROUND(b.avg_pct_gain_forall_obsrvtns,4)    avg_pct_gain_forall_obsrvtns
,CASE WHEN avg_pct_gain_where_prob_gt_pt55 > avg_pct_gain_forall_obsrvtns 
  THEN 'Model Succeeded' ELSE 'Model Failed' END model_result
,'Model should predict observations which have positive gains. These gains should average more than average for all observations.' more_information
FROM
(
SELECT
COUNT(pctgain) not_up_prediction_count
,AVG(pctgain) avg_pct_gain_where_prob_gt_pt55
FROM bt_:ng
WHERE prob_willbetrue > 0.55
)a,
(SELECT
AVG(pctgain) avg_pct_gain_forall_obsrvtns
FROM bt_:ng
)b
;

-- A simple set of very useful queries:
-- SELECT COUNT(pctgain),AVG(pctgain) FROM bt_:ng WHERE prob_willbetrue < 0.48;
-- SELECT COUNT(pctgain),AVG(pctgain) FROM bt_:ng WHERE prob_willbetrue < 0.49;
-- 
-- SELECT COUNT(pctgain),AVG(pctgain) FROM bt_:ng;
-- 
-- SELECT COUNT(pctgain),AVG(pctgain) FROM bt_:ng WHERE prob_willbetrue > 0.51;
-- SELECT COUNT(pctgain),AVG(pctgain) FROM bt_:ng WHERE prob_willbetrue > 0.52;
