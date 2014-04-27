--
-- ~/spy611/script/cr_my_vectors.sql
--

-- I use this script to create my_vectors from mydata
-- which is created from:
-- ~/spy611/script/wgetit.bash
-- ~/spy611/script/load_mydata.bash

-- Demo:
-- ./psqlmad.bash -f ~/spy611/script/cr_my_vectors.sql

DROP   TABLE vec1;
CREATE TABLE vec1 AS
SELECT
ydate
,opn
,closing_price cp
,LAG(closing_price,2,closing_price) OVER (ORDER BY ydate)  lag_cp2d
,LAG(closing_price,5,closing_price) OVER (ORDER BY ydate)  lag_cp1w
,LAG(closing_price,10,closing_price) OVER (ORDER BY ydate) lag_cp2w
,LAG(closing_price,20,closing_price) OVER (ORDER BY ydate) lag_cp1m
,LAG(closing_price,40,closing_price) OVER (ORDER BY ydate) lag_cp2m
,AVG(closing_price) OVER (ORDER BY ydate ROWS BETWEEN 100 PRECEDING AND 1 PRECEDING) ma100
,LEAD(opn,1,closing_price) OVER (ORDER BY ydate)   lead_opn
,LEAD(closing_price,1,NULL) OVER (ORDER BY ydate)  lead_cp
,LEAD(closing_price,2,NULL) OVER (ORDER BY ydate)  lead_cp2d
,LEAD(closing_price,5,NULL) OVER (ORDER BY ydate)  lead_cp1w
FROM mydata
ORDER BY ydate
;

-- Calculate normalized 1 day gain 
-- 2 day gain
-- 1 week gain
-- 1 month gain
-- for each row:
DROP   TABLE vec2;
CREATE TABLE vec2 AS
SELECT
ydate -- boundry of past, future.
,cp
-- past data,  normalized lag-deltas:
,(cp - lag_cp2d) / lag_cp2d       n2dlagd
,(cp - lag_cp1w) / lag_cp1w       n1wlagd
,(cp - lag_cp1m) / lag_cp1m       n1mlagd
,(lag_cp1w - lag_cp2w) / lag_cp2w n2wlagd
,(lag_cp1m - lag_cp2m) / lag_cp2m n2mlagd
-- I might like this vector element:
,cp / ma100 cpma
-- future data:
,(lead_cp - cp) / cp              n1dg
,(lead_cp2d - cp) / cp            n2dg
,(lead_cp1w - cp) / cp            n1wg
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
,cpma
-- data in the past:
,lag(n1dg,1,n1dg) OVER (ORDER BY ydate) n1dg1
,lag(n1dg,2,n1dg) OVER (ORDER BY ydate) n1dg2
,lag(n1dg,3,n1dg) OVER (ORDER BY ydate) n1dg3
,n2dlagd
,n1wlagd
,n2wlagd
,n1mlagd
,n2mlagd
-- data in the future:
,n1dg -- norm. 1 day gain
,n2dg -- norm. 2 day gain
,n1wg -- norm. 1 wk  gain
,CASE WHEN n1dg  IS NULL THEN NULL WHEN n1dg <= (0.00042) THEN false ELSE true END  yvalue1d
,CASE WHEN n2dg  IS NULL THEN NULL WHEN n2dg <= (0.00089) THEN false ELSE true END  yvalue2d
,CASE WHEN n1wg  IS NULL THEN NULL WHEN n1wg <= (0.00259) THEN false ELSE true END  yvalue1w
FROM vec2
ORDER BY ydate
;

-- Create vectors.
-- Also calculate 'y-value' for each vector:
DROP   TABLE my_vectors;
CREATE TABLE my_vectors AS
SELECT
-- now:
ydate 
,cp
,cpma
-- data in the past:
,n1dg1
,n1dg2
,n1dg3
,n2dlagd
,n1wlagd
,n2wlagd
,n1mlagd
,n2mlagd
-- data in the future:
,n1dg -- norm. 1 day gain
,n2dg -- norm. 2 day gain
,n1wg -- norm. 1 wk  gain
-- my_vector contains data from past:
,ARRAY[1
,cpma
,n1dg1
,n1dg2
,n1dg3
,n2dlagd
,n1wlagd
,n2wlagd
,n1mlagd
,n2mlagd] my_vector
,yvalue1d
,yvalue2d
,yvalue1w
FROM vec3
WHERE 
cp
+cpma
+n1dg1
+n1dg2
+n1dg3
+n2dlagd
+n1wlagd
+n2wlagd
+n1mlagd
+n2mlagd
IS NOT NULL
ORDER BY ydate
;

-- rpt
SELECT
MIN(ydate)
,COUNT(ydate)
,MAX(ydate)
,AVG(n1dg)
,AVG(n2dg)
,AVG(n1wg)
FROM my_vectors
;
