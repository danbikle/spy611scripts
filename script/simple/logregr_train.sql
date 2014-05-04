--
-- logregr_train.sql
--

-- Demo:
-- ./psqlmad.bash -f logregr_train.sql

-- MADlib API Reference:
-- http://doc.madlib.net/latest/group__grp__logreg.html

DROP TABLE IF EXISTS my_out_table_model1;
DROP TABLE IF EXISTS my_out_table_model1_summary;

SELECT logregr_train( 'insample_data','my_out_table_model1','yvalue1d','my_vector',NULL,999);

-- Now I have Logistic Regression Coefficients.
-- I want to see them:

\x on
SELECT * FROM my_out_table_model1;
\x off

