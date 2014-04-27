--
-- ~/spy611/script/ma/oos_is.sql
--

-- Demo:
-- ./psqlmad.bash -f ~/spy611/script/ma/oos_is.sql -v yr="'2014'"

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
SELECT MIN(ydate), COUNT(ydate), MAX(ydate) FROM is_vectors;
SELECT MIN(ydate), COUNT(ydate), MAX(ydate) FROM oos_vectors;

