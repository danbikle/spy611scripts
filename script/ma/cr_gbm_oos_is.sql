--
-- ~/spy611/script/ma/cr_gbm_oos_is.sql
--

-- Demo:
-- ./psqlmad.bash -f ~/spy611/script/ma/cr_gbm_oos_is.sql -v yr="'2014'"

DROP   TABLE IF EXISTS x_is;
CREATE TABLE x_is AS
SELECT
r50     
,r40     
,r30     
,r250 
,r200 
,r150 
,r1001
,s5
,s4
,s3
,s5w
,s4w
,s3w
FROM my_vectors
WHERE ydate > (:yr||'-01-01')::DATE - (365 * 25) - 20
AND   ydate < (:yr||'-01-01')::DATE - 20
ORDER BY ydate
;

DROP   TABLE IF EXISTS y_is_n1dg;
CREATE TABLE y_is_n1dg AS
SELECT
CASE WHEN yvalue1d=false THEN -1 ELSE 1 END yvalue1d
FROM my_vectors
WHERE ydate > (:yr||'-01-01')::DATE - (365 * 25) - 20
AND   ydate < (:yr||'-01-01')::DATE - 20
ORDER BY ydate
;

DROP   TABLE IF EXISTS y_is_n2dg;
CREATE TABLE y_is_n2dg AS
SELECT
CASE WHEN yvalue2d=false THEN -1 ELSE 1 END yvalue2d
FROM my_vectors
WHERE ydate > (:yr||'-01-01')::DATE - (365 * 25) - 20
AND   ydate < (:yr||'-01-01')::DATE - 20
ORDER BY ydate
;

DROP   TABLE IF EXISTS y_is_n1wg;
CREATE TABLE y_is_n1wg AS
SELECT
CASE WHEN yvalue1w=false THEN -1 ELSE 1 END yvalue1w
FROM my_vectors
WHERE ydate > (:yr||'-01-01')::DATE - (365 * 25) - 20
AND   ydate < (:yr||'-01-01')::DATE - 20
ORDER BY ydate
;

DROP   TABLE IF EXISTS x_oos;
CREATE TABLE x_oos AS
SELECT
r50     
,r40     
,r30     
,r250 
,r200 
,r150 
,r1001
,s5
,s4
,s3
,s5w
,s4w
,s3w
FROM my_vectors
WHERE TO_CHAR(ydate,'YYYY') = :yr
ORDER BY ydate
;

DROP   TABLE IF EXISTS y_oos_n1dg;
CREATE TABLE y_oos_n1dg AS
SELECT
CASE WHEN yvalue1d=false THEN -1 ELSE 1 END yvalue1d
FROM my_vectors
WHERE TO_CHAR(ydate,'YYYY') = :yr
ORDER BY ydate
;

DROP   TABLE IF EXISTS y_oos_n2dg;
CREATE TABLE y_oos_n2dg AS
SELECT
CASE WHEN yvalue2d=false THEN -1 ELSE 1 END yvalue2d
FROM my_vectors
WHERE TO_CHAR(ydate,'YYYY') = :yr
ORDER BY ydate
;

DROP   TABLE IF EXISTS y_oos_n1wg;
CREATE TABLE y_oos_n1wg AS
SELECT
CASE WHEN yvalue1w=false THEN -1 ELSE 1 END yvalue1w
FROM my_vectors
WHERE TO_CHAR(ydate,'YYYY') = :yr
ORDER BY ydate
;

SELECT COUNT(*) FROM x_is;
SELECT COUNT(*) FROM x_oos;

COPY x_is TO '/tmp/x_is.csv' csv;
COPY x_oos TO '/tmp/x_oos.csv' csv;

COPY y_is_n1dg TO '/tmp/y_is_n1dg.csv' csv;
COPY y_is_n2dg TO '/tmp/y_is_n2dg.csv' csv;
COPY y_is_n1wg TO '/tmp/y_is_n1wg.csv' csv;
               	            
COPY y_oos_n1dg TO '/tmp/y_oos_n1dg.csv' csv;
COPY y_oos_n2dg TO '/tmp/y_oos_n2dg.csv' csv;
COPY y_oos_n1wg TO '/tmp/y_oos_n1wg.csv' csv;

-- I need to track the oos data for later reporting

DROP   TABLE IF EXISTS gbm_track;
CREATE TABLE gbm_track AS
SELECT
row_number() OVER (ORDER BY ydate) tnum
,CASE WHEN yvalue1d=false THEN -1 ELSE 1 END yvalue1d
,CASE WHEN yvalue2d=false THEN -1 ELSE 1 END yvalue2d
,CASE WHEN yvalue1w=false THEN -1 ELSE 1 END yvalue1w
,n1dg
,n2dg
,n1wg
,ydate
FROM my_vectors
WHERE TO_CHAR(ydate,'YYYY') = :yr
ORDER BY ydate
;

