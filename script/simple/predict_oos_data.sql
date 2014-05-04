--
-- predict_oos_data.sql
--

-- I use this script to predict out of sample data.

-- Demo:
-- ./psqlmad.bash -f predict_oos_data.sql

SELECT
ydate
,madlib.logistic(madlib.array_dot(my_out_table_model1.coef, my_vector::float8[])) AS prob_willbetrue
FROM out_of_sample_data, my_out_table_model1
ORDER BY ydate
;

