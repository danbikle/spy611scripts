--
-- cr_out_of_sample_data.sql
--

-- I use this script to create out of sample data
-- Demo:
-- ./psqlmad.bash -f cr_out_of_sample_data.sql

DROP TABLE out_of_sample_data;

CREATE TABLE out_of_sample_data AS
SELECT * FROM my_small_vectors
WHERE ydate BETWEEN '2014-04-20' AND '2014-04-30'
;
