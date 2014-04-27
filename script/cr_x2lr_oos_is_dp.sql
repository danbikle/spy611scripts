--
-- ~/spy611/script/cr_x2lr_oos_is_dp.sql
--

-- Demo:
-- ~/spy611/script/psqlmad.bash -f ~/spy611/script/cr_x2lr_oos_is_dp.sql -v dayspast="15"

-- I use this script to create both out-of-sample and in-sample data from my_vectors_wide
-- This script is called by ~/spy611/script/cr_x2lr_oos_is_dp.bash

-- After this script is run,
-- I can call ~/spy611/script/lr.bash

-- This script depends on cr_my_vectors_wide.sql to create my_vectors_wide

-- is_vectors is used for training.
-- I see the table as in-sample data.

DROP TABLE IF EXISTS is_vectors;
CREATE TABLE is_vectors AS
SELECT * FROM my_vectors_wide
WHERE ydate + 20 + :dayspast < (SELECT MAX(ydate) FROM my_vectors_wide)
AND   ydate > now()::DATE - (365 * 25) - 20
ORDER BY ydate
;

-- Here is my out-of-sample data:
DROP TABLE IF EXISTS oos_vectors;
CREATE TABLE oos_vectors AS
SELECT * FROM my_vectors_wide
WHERE ydate + :dayspast >= (SELECT MAX(ydate) FROM my_vectors_wide)
ORDER BY ydate
;

-- rpt, I want no overlap:
select min(ydate),count(ydate),max(ydate) from is_vectors;
select min(ydate),count(ydate),max(ydate) from oos_vectors;

