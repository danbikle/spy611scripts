--
-- cr_insample_data.sql
--

-- I use this script to create insample data.

-- Demo:
-- ./psqlmad.bash -f cr_insample_data.sql

DROP TABLE insample_data;

CREATE TABLE insample_data AS
SELECT * FROM my_small_vectors
WHERE ydate < '2014-01-01'
;
