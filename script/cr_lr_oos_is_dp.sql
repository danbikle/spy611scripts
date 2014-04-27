--
-- ~/spy611/script/cr_lr_oos_is_dp.sql
--

-- I use this script to create both out-of-sample and in-sample data from my_vectors.
-- This script is called by ~/spy611/script/cr_lr_oos_is_dp.bash
-- Which is called by ~/spy611/script/pred_lr.bash
-- Which is called by ~/spy611/script/night.bash

-- Also I call this script from:
-- ~/spy611/script/backtests/bt_lr_dp.bash

-- After this script is run,
-- I can call ~/spy611/script/lr.bash

-- Demo:
-- ~/spy611/script/psqlmad.bash -f ~/spy611/script/cr_lr_oos_is_dp.sql -v dayspast="15"

-- is_vectors is used for training.
-- I see the table as in-sample data.

DROP   TABLE is_vectors;
CREATE TABLE is_vectors AS
SELECT * FROM my_vectors
WHERE ydate + 20 + :dayspast < (SELECT MAX(ydate) FROM my_vectors)
AND   ydate > now()::DATE - (365 * 25) - 20
ORDER BY ydate
;

-- Create 'Out of Sample' vectors to-be-predicted and then studied:
DROP   TABLE oos_vectors;
CREATE TABLE oos_vectors AS
SELECT * FROM my_vectors
WHERE ydate + :dayspast >= (SELECT MAX(ydate) FROM my_vectors)
ORDER BY ydate
;

-- rpt
SELECT MIN(ydate), COUNT(ydate), MAX(ydate) FROM is_vectors;
SELECT MIN(ydate), COUNT(ydate), MAX(ydate) FROM oos_vectors;
