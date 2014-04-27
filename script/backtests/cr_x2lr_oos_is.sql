--
-- ~/spy611/script/backtests/cr_x2lr_oos_is.sql
--

-- I use this script to create both out-of-sample and in-sample data from my_vectors_wide.

-- Demo:
-- ./psqlmad.bash -f cr_x2lr_oos_is.sql -v yr="'$YR'"
-- or
-- ./psqlmad.bash -f cr_x2lr_oos_is.sql -v yr='2010'

-- This script is called by cr_x2lr_oos_is.bash
-- Which is called by
-- ~/spy611/script/backtests/bt_x2lr_yr.bash

-- is_vectors is used for training.
-- I see the table as in-sample data.
-- I intend for it to contain 25 years of data.


DROP   TABLE is_vectors;
CREATE TABLE is_vectors AS
SELECT * FROM my_vectors_wide
WHERE ydate > (:yr||'-01-01')::DATE - (365 * 25) - 20
AND   ydate < (:yr||'-01-01')::DATE - 20
ORDER BY ydate
;

-- Create 'Out of Sample' vectors to-be-predicted and then studied:
DROP   TABLE oos_vectors;
CREATE TABLE oos_vectors AS
SELECT * FROM my_vectors_wide
WHERE TO_CHAR(ydate,'YYYY') = :yr
ORDER BY ydate
;

-- rpt, I want no overlap:
select min(ydate),count(ydate),max(ydate) from is_vectors;
select min(ydate),count(ydate),max(ydate) from oos_vectors;
