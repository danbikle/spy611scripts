--
-- ~/spy611/script/cr_vectors.sql
--

-- I use this script to create some vectors to be used with MADlib.

-- Also the vectors are useful for studying heuristic based predictions.

-- Start by calculating the normalized 1-day, 2-day, 1-wk gains for all rows 
-- except the most recent which has no value yet.

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

-- Avg is easy to calculate.
-- If I want Median, I need to sort.
-- Then I need to count to the midpoint of sort.

-- Calculate y-value boundry (the median, not avg) from in-sample data:

WITH sq AS
(
SELECT
n1dg
,row_number() OVER (ORDER BY n1dg) rnum
FROM vec2
WHERE ydate < '2013-01-01'
ORDER BY n1dg
)
SELECT n1dg n1dg_median FROM sq
WHERE rnum = (SELECT ROUND(AVG(rnum)) FROM sq)
;

WITH sq AS
(
SELECT
n2dg
,row_number() OVER (ORDER BY n2dg) rnum
FROM vec2
WHERE ydate < '2013-01-01'
ORDER BY n2dg
)
SELECT n2dg n2dg_median FROM sq
WHERE rnum = (SELECT ROUND(AVG(rnum)) FROM sq)
;

WITH sq AS
(
SELECT
n1wg
,row_number() OVER (ORDER BY n1wg) rnum
FROM vec2
WHERE ydate < '2013-01-01'
ORDER BY n1wg
)
SELECT n1wg n1wg_median FROM sq
WHERE rnum = (SELECT ROUND(AVG(rnum)) FROM sq)
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
,CASE WHEN n2dg  IS NULL THEN NULL WHEN n2dg <= (0.00088) THEN false ELSE true END  yvalue2d
,CASE WHEN n1wg  IS NULL THEN NULL WHEN n1wg <= (0.0025) THEN false ELSE true END  yvalue1w
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
,n2mlagd] my_vector -- this for day1.sql, ...
,yvalue1d
,yvalue2d
,yvalue1w
FROM vec3
ORDER BY ydate
;

-- Create training vectors:
DROP   TABLE training_vectors;
CREATE TABLE training_vectors AS
SELECT * FROM my_vectors
WHERE ydate < '2014-01-01'
ORDER BY ydate
;

-- Create 'Out of Sample' vectors to-be-predicted and then studied:
DROP   TABLE oos_vectors;
CREATE TABLE oos_vectors AS
SELECT * FROM my_vectors
WHERE ydate > '2014-01-01'
ORDER BY ydate
;

-- Study distributions:

SELECT yvalue1d, COUNT(yvalue1d) FROM my_vectors WHERE ydate < '2013-01-01' GROUP BY yvalue1d;
SELECT yvalue2d, COUNT(yvalue2d) FROM my_vectors WHERE ydate < '2013-01-01' GROUP BY yvalue2d;
SELECT yvalue1w, COUNT(yvalue1w) FROM my_vectors WHERE ydate < '2013-01-01' GROUP BY yvalue1w;

SELECT 
ROUND(MIN(n1dg),5)  min_n1dg
,ROUND(AVG(n1dg),5) avg_n1dg
,ROUND(MAX(n1dg),5) max_n1dg
,ROUND(STDDEV(n1dg),5) stddev_n1dg
FROM my_vectors
;

SELECT 
ROUND(MIN(n2dg),5)  min_n2dg
,ROUND(AVG(n2dg),5) avg_n2dg
,ROUND(MAX(n2dg),5) max_n2dg
,ROUND(STDDEV(n2dg),5) stddev_n2dg
FROM my_vectors
;

SELECT 
ROUND(MIN(n1wg),5)  min_n1wg
,ROUND(AVG(n1wg),5) avg_n1wg
,ROUND(MAX(n1wg),5) max_n1wg
,ROUND(STDDEV(n1wg),5) stddev_n1wg
FROM my_vectors
;

-- Are the tails interesting?

-- English:
-- Count the yvalues,
-- Where today was down by more than 1-std-deviation,
-- And yesterday was down by more than 1-std-deviation

SELECT 
yvalue1d
,COUNT(yvalue1d)
FROM my_vectors
WHERE n1dg1 < -0.012
AND   n1dg2 < -0.012
GROUP BY yvalue1d
;


-- English:
-- Count the yvalues,
-- Where today was up by more than 1-std-deviation,
-- And yesterday was up by more than 1-std-deviation

SELECT 
yvalue1d
,COUNT(yvalue1d)
FROM my_vectors
WHERE n1dg1 > 0.012
AND   n1dg2 > 0.012
GROUP BY yvalue1d
;

-- Study the other tails:

SELECT 
yvalue2d
,COUNT(yvalue2d)
FROM my_vectors
WHERE n2dlagd < (SELECT -STDDEV(n2dlagd) FROM my_vectors)
GROUP BY yvalue2d
;
SELECT 
yvalue2d
,COUNT(yvalue2d)
FROM my_vectors
WHERE n2dlagd > (SELECT STDDEV(n2dlagd) FROM my_vectors)
GROUP BY yvalue2d
;

SELECT 
yvalue1w
,COUNT(yvalue1w)
FROM my_vectors
WHERE n1wlagd < (SELECT -STDDEV(n1wlagd) FROM my_vectors)
AND   n2wlagd < (SELECT -STDDEV(n2wlagd) FROM my_vectors)
GROUP BY yvalue1w
;
SELECT 
yvalue1w
,COUNT(yvalue1w)
FROM my_vectors
WHERE n1wlagd > (SELECT STDDEV(n1wlagd) FROM my_vectors)
AND   n2wlagd > (SELECT STDDEV(n2wlagd) FROM my_vectors)
GROUP BY yvalue1w
;
