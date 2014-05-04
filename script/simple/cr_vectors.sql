--
-- cr_vectors.sql
--

-- I use this script to create vectors for MADlib.

DROP   TABLE vec1;
CREATE TABLE vec1 AS
SELECT
-- past
LAG(closing_price,1,closing_price) OVER (ORDER BY ydate)  lag_cp1d
,LAG(closing_price,5,closing_price) OVER (ORDER BY ydate)  lag_cp1w
,AVG(closing_price) OVER (ORDER BY ydate ROWS BETWEEN 100 PRECEDING AND 1 PRECEDING) ma100
-- now
,ydate
,opn
,closing_price cp
-- future
,LEAD(closing_price,1,NULL) OVER (ORDER BY ydate)          lead_cp
FROM mydata
ORDER BY ydate
;

-- Calculate normalized 1 day gain (n1dg)
-- for each row:
DROP   TABLE vec2;
CREATE TABLE vec2 AS
SELECT
-- now
ydate
,cp
,(cp - lag_cp1d) / lag_cp1d n1dlagd
,(cp - lag_cp1w) / lag_cp1w n1wlagd
,cp / ma100                 cpma
-- future
,(lead_cp - cp) / cp        n1dg
FROM vec1
ORDER BY ydate
;

-- Create vectors.
-- Also calculate 'y-value' for each vector:
DROP   TABLE vec3;
CREATE TABLE vec3 AS
SELECT
-- now:
ydate 
,cp
,n1dlagd
,n1wlagd
,cpma
-- data in the future:
,n1dg
,100 * n1dg AS pct_gain
,n1dg       AS yvalue
,CASE WHEN n1dg  IS NULL THEN NULL WHEN n1dg <= 0.0 THEN false ELSE true END  yvalue1d
-- yvalue1d is a poor name. I should have called it yclass.
FROM vec2
ORDER BY ydate
;

-- Create vectors.
DROP   TABLE my_small_vectors;
CREATE TABLE my_small_vectors AS
SELECT
-- now:
ydate 
,cp
,n1dlagd
,n1wlagd
,cpma
-- my_vector contains data from now, NOT future:
,ARRAY[1::FLOAT8
,cpma::FLOAT8
,n1dlagd::FLOAT8
,n1wlagd::FLOAT8] my_vector
-- data in the future:
,n1dg
,pct_gain
,yvalue
,yvalue1d
FROM vec3
WHERE 
cp
+n1dlagd
+n1wlagd
+cpma
IS NOT NULL
ORDER BY ydate
;

-- rpt, what have we got?
SELECT
yvalue1d
,MIN(ydate)
,COUNT(ydate)
,MAX(ydate)
,AVG(pct_gain)
FROM my_small_vectors
GROUP BY yvalue1d
;
