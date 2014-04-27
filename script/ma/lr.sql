--
-- ~/spy611/script/ma/lr.sql
--

DROP TABLE IF EXISTS my_out_table_model1;
DROP TABLE IF EXISTS my_out_table_model2;
DROP TABLE IF EXISTS my_out_table_model3;
DROP TABLE IF EXISTS my_out_table_model1_summary;
DROP TABLE IF EXISTS my_out_table_model2_summary;
DROP TABLE IF EXISTS my_out_table_model3_summary;
DROP TABLE IF EXISTS lr_rpt_n1dg;
DROP TABLE IF EXISTS lr_rpt_n2dg;
DROP TABLE IF EXISTS lr_rpt_n1wg;

SELECT logregr_train( 'is_vectors','my_out_table_model1','yvalue1d','my_vector',NULL,999);
SELECT logregr_train( 'is_vectors','my_out_table_model2','yvalue2d','my_vector',NULL,999);
SELECT logregr_train( 'is_vectors','my_out_table_model3','yvalue1w','my_vector',NULL,999);

--
-- rpt, Look at the regression created by MADlib:
--
\x on
SELECT * FROM my_out_table_model1;
SELECT * FROM my_out_table_model2;
SELECT * FROM my_out_table_model3;
\x off

--
-- Predict out-of-sample rows:
--
CREATE TABLE lr_rpt_n1dg AS
SELECT
ydate
,madlib.logistic(madlib.array_dot(my_out_table_model1.coef, my_vector::float8[])) AS prob_willbetrue
,100 * ROUND(n1dg,4) pctgain
,ROUND(n1dg,6)       n1dg
,yvalue1d            actual_yvalue
FROM oos_vectors, my_out_table_model1
ORDER BY ydate
;

CREATE TABLE lr_rpt_n2dg AS
SELECT
ydate
,madlib.logistic(madlib.array_dot(my_out_table_model2.coef, my_vector::float8[])) AS prob_willbetrue
,100 * ROUND(n2dg,4) pctgain
,ROUND(n2dg,6)       n2dg
,yvalue2d            actual_yvalue
FROM oos_vectors, my_out_table_model2
ORDER BY ydate
;

CREATE TABLE lr_rpt_n1wg AS
SELECT
ydate
,madlib.logistic(madlib.array_dot(my_out_table_model3.coef, my_vector::float8[])) AS prob_willbetrue
,100 * ROUND(n1wg,4) pctgain
,ROUND(n1wg,6)       n1wg
,yvalue1w            actual_yvalue
FROM oos_vectors, my_out_table_model3
ORDER BY ydate
;

-- rpt
-- select ydate,prob_willbetrue,pctgain from oosd_predictions_model3;
-- rpt

-- Quick rpt:
SELECT CORR(prob_willbetrue,n1dg) FROM lr_rpt_n1dg;
SELECT CORR(prob_willbetrue,n2dg) FROM lr_rpt_n2dg;
SELECT CORR(prob_willbetrue,n1wg) FROM lr_rpt_n1wg;
