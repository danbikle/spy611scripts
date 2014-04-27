--
-- ~/spy611/script/cr_svm_oos_is_dp.sql
--

-- Demo:
-- ./psqlmad.bash -f cr_svm_oos_is_dp.sql dayspast=$DAYSPAST
-- or
-- ./psqlmad.bash -f cr_svm_oos_is_dp.sql dayspast=30

DROP   TABLE IF EXISTS svm_is_n1dg;
CREATE TABLE svm_is_n1dg AS
SELECT
CASE WHEN yvalue1d=false THEN -1 ELSE 1 END yvalue1d
,cpma
,n1dg1
,n1dg2
,n1dg3
,n2dlagd
,n1wlagd
,n2wlagd
,n1mlagd
,n2mlagd
FROM my_vectors
WHERE ydate + 20 + :dayspast < (SELECT MAX(ydate) FROM my_vectors)
AND   ydate > now()::DATE - (365 * 25) - 20
ORDER BY ydate
;

DROP   TABLE IF EXISTS svm_is_n2dg;
CREATE TABLE svm_is_n2dg AS
SELECT
CASE WHEN yvalue2d=false THEN -1 ELSE 1 END yvalue2d
,cpma
,n1dg1
,n1dg2
,n1dg3
,n2dlagd
,n1wlagd
,n2wlagd
,n1mlagd
,n2mlagd
FROM my_vectors
WHERE ydate + 20 + :dayspast < (SELECT MAX(ydate) FROM my_vectors)
AND   ydate > now()::DATE - (365 * 25) - 20
ORDER BY ydate
;

DROP   TABLE IF EXISTS svm_is_n1wg;
CREATE TABLE svm_is_n1wg AS
SELECT
CASE WHEN yvalue1w=false THEN -1 ELSE 1 END yvalue1w
,cpma
,n1dg1
,n1dg2
,n1dg3
,n2dlagd
,n1wlagd
,n2wlagd
,n1mlagd
,n2mlagd
FROM my_vectors
WHERE ydate + 20 + :dayspast < (SELECT MAX(ydate) FROM my_vectors)
AND   ydate > now()::DATE - (365 * 25) - 20
ORDER BY ydate
;

-- oos tables:

DROP   TABLE IF EXISTS svm_oos_n1dg;
CREATE TABLE svm_oos_n1dg AS
SELECT
CASE WHEN yvalue1d=false THEN -1 ELSE 1 END yvalue1d
,cpma
,n1dg1
,n1dg2
,n1dg3
,n2dlagd
,n1wlagd
,n2wlagd
,n1mlagd
,n2mlagd
FROM my_vectors
WHERE ydate + :dayspast > (SELECT MAX(ydate) FROM my_vectors)
ORDER BY ydate
;

DROP   TABLE IF EXISTS svm_oos_n2dg;
CREATE TABLE svm_oos_n2dg AS
SELECT
CASE WHEN yvalue2d=false THEN -1 ELSE 1 END yvalue2d
,cpma
,n1dg1
,n1dg2
,n1dg3
,n2dlagd
,n1wlagd
,n2wlagd
,n1mlagd
,n2mlagd
FROM my_vectors
WHERE ydate + :dayspast > (SELECT MAX(ydate) FROM my_vectors)
ORDER BY ydate
;

DROP   TABLE IF EXISTS svm_oos_n1wg;
CREATE TABLE svm_oos_n1wg AS
SELECT
CASE WHEN yvalue1w=false THEN -1 ELSE 1 END yvalue1w
,cpma
,n1dg1
,n1dg2
,n1dg3
,n2dlagd
,n1wlagd
,n2wlagd
,n1mlagd
,n2mlagd
FROM my_vectors
WHERE ydate + :dayspast > (SELECT MAX(ydate) FROM my_vectors)
ORDER BY ydate
;

SELECT COUNT(*) FROM svm_oos_n1wg;
SELECT COUNT(*) FROM svm_oos_n1dg;
SELECT COUNT(*) FROM svm_oos_n2dg;

-- Create CSV files from the tables:

COPY svm_is_n1dg TO '/tmp/svm_is_n1dg.csv' csv;
COPY svm_is_n2dg TO '/tmp/svm_is_n2dg.csv' csv;
COPY svm_is_n1wg TO '/tmp/svm_is_n1wg.csv' csv;

COPY svm_oos_n1dg TO '/tmp/svm_oos_n1dg.csv' csv;
COPY svm_oos_n2dg TO '/tmp/svm_oos_n2dg.csv' csv;
COPY svm_oos_n1wg TO '/tmp/svm_oos_n1wg.csv' csv;

-- I need to track the oos data for later reporting

DROP   TABLE IF EXISTS svm_track;
CREATE TABLE svm_track AS
SELECT
row_number() OVER (ORDER BY ydate) tnum
,CASE WHEN yvalue1d=false THEN -1 ELSE 1 END yvalue1d
,CASE WHEN yvalue2d=false THEN -1 ELSE 1 END yvalue2d
,CASE WHEN yvalue1w=false THEN -1 ELSE 1 END yvalue1w
,n1dg
,n2dg
,n1wg
,ydate
,cpma
,n1dg1
,n1dg2
,n1dg3
,n2dlagd
,n1wlagd
,n2wlagd
,n1mlagd
,n2mlagd
FROM my_vectors
WHERE ydate + :dayspast > (SELECT MAX(ydate) FROM my_vectors)
ORDER BY ydate
;

SELECT COUNT(*) FROM svm_oos_n1dg;
SELECT MIN(ydate), COUNT(ydate), MAX(ydate) FROM svm_track;
-- Above 2 counts should match.
-- More Info:
SELECT MIN(ydate), COUNT(ydate), MAX(ydate) FROM my_vectors;
SELECT COUNT(*) FROM svm_is_n1dg;
