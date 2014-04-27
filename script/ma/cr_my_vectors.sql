--
-- ~/spy611/script/ma/cr_my_vectors.sql
--

-- I use this script to create my_vectors from mydata
-- which is created from:
-- ~/spy611/script/wgetit.bash
-- ~/spy611/script/load_mydata.bash

-- Demo:
-- ./psqlmad.bash -f ~/spy611/script/ma/cr_my_vectors.sql

DROP   TABLE IF EXISTS vec1;
CREATE TABLE vec1 AS
SELECT
ydate
,closing_price cp
,AVG(closing_price) OVER (ORDER BY ydate ROWS BETWEEN 5 PRECEDING AND 0 PRECEDING) ma50
,AVG(closing_price) OVER (ORDER BY ydate ROWS BETWEEN 4 PRECEDING AND 0 PRECEDING) ma40
,AVG(closing_price) OVER (ORDER BY ydate ROWS BETWEEN 3 PRECEDING AND 0 PRECEDING) ma30
,AVG(closing_price) OVER (ORDER BY ydate ROWS BETWEEN 6 PRECEDING AND 1 PRECEDING) ma61
,AVG(closing_price) OVER (ORDER BY ydate ROWS BETWEEN 5 PRECEDING AND 1 PRECEDING) ma51
,AVG(closing_price) OVER (ORDER BY ydate ROWS BETWEEN 4 PRECEDING AND 1 PRECEDING) ma41
,AVG(closing_price) OVER (ORDER BY ydate ROWS BETWEEN 5*5 PRECEDING AND 0 PRECEDING) ma250
,AVG(closing_price) OVER (ORDER BY ydate ROWS BETWEEN 4*5 PRECEDING AND 0 PRECEDING) ma200
,AVG(closing_price) OVER (ORDER BY ydate ROWS BETWEEN 3*5 PRECEDING AND 0 PRECEDING) ma150
,AVG(closing_price) OVER (ORDER BY ydate ROWS BETWEEN 6*5 PRECEDING AND 5 PRECEDING) ma301
,AVG(closing_price) OVER (ORDER BY ydate ROWS BETWEEN 5*5 PRECEDING AND 5 PRECEDING) ma251
,AVG(closing_price) OVER (ORDER BY ydate ROWS BETWEEN 4*5 PRECEDING AND 5 PRECEDING) ma201
,AVG(closing_price) OVER (ORDER BY ydate ROWS BETWEEN 100 PRECEDING AND 1 PRECEDING) ma1001
,LEAD(closing_price,1,NULL) OVER (ORDER BY ydate)  lead_cp
,LEAD(closing_price,2,NULL) OVER (ORDER BY ydate)  lead_cp2d
,LEAD(closing_price,5,NULL) OVER (ORDER BY ydate)  lead_cp1w
FROM mydata
ORDER BY ydate
;

DROP   TABLE IF EXISTS vec2;
CREATE TABLE vec2 AS
SELECT
ydate
,cp
,cp / ma50        r50    
,cp / ma40        r40    
,cp / ma30        r30    
,cp / ma250       r250 
,cp / ma200       r200 
,cp / ma150       r150 
,cp /ma1001       r1001
,(ma61-ma50)/cp   s5
,(ma51-ma40)/cp   s4
,(ma41-ma30)/cp   s3
,(ma301-ma250)/cp s5w
,(ma251-ma200)/cp s4w
,(ma201-ma150)/cp s3w
-- future data:
,(lead_cp - cp) / cp   n1dg
,(lead_cp2d - cp) / cp n2dg
,(lead_cp1w - cp) / cp n1wg
FROM vec1
ORDER BY ydate
;

-- Calculate 'y-value' for each vector:
DROP   TABLE vec3;
CREATE TABLE vec3 AS
SELECT
-- now:
ydate 
,cp
,r50     
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
DROP   TABLE my_vectors;
CREATE TABLE my_vectors AS
SELECT
-- now:
ydate 
,cp
,r50     
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
-- my_vector contains data from past:
,ARRAY[1
,r50     
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
] my_vector
-- data in the future:
,n1dg -- norm. 1 day gain
,n2dg -- norm. 2 day gain
,n1wg -- norm. 1 wk  gain
,yvalue1d
,yvalue2d
,yvalue1w
FROM vec3
WHERE 
cp
+r50     
+r40     
+r30     
+r250 
+r200 
+r150 
+r1001
+s5
+s4
+s3
+s5w
+s4w
+s3w IS NOT NULL
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
