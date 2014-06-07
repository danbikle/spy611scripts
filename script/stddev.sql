--
-- ~/spy611/script/stddev.sql
--

-- I use this script to study relationship between pct_gain and volatility of past pct_gain.

DROP TABLE   s1;
CREATE TABLE s1 AS
SELECT
ydate
,closing_price cp
,LEAD(closing_price) OVER (ORDER BY ydate) ldcp
FROM mydata
ORDER BY ydate
;

-- Now that I have ldcp, I can calculate pct_gain

DROP TABLE   s3;
CREATE TABLE s3 AS
SELECT
ydate
,100 * (ldcp - cp)/cp pct_gain
FROM s1
ORDER BY ydate
;

-- Now that I have pct_gain, I can calculate recent_volatility of pct_gain

DROP TABLE   s5;
CREATE TABLE s5 AS
SELECT
ydate
,pct_gain
,STDDEV(pct_gain) OVER (ORDER BY ydate ROWS BETWEEN 40 PRECEDING AND 0 PRECEDING) recent_volatility
FROM s3
ORDER BY ydate
;

-- Now that I have both pct_gain and recent_volatility
-- I can look at how they relate.

DROP TABLE   s7;
CREATE TABLE s7 AS
SELECT
CORR(recent_volatility, pct_gain) corr_rv_pg
,COUNT(recent_volatility)         count_rv
,MIN(recent_volatility)           min_rv
,AVG(recent_volatility)           avg_rv
,MAX(recent_volatility)           max_rv
,STDDEV(recent_volatility)        stddev_rv
,AVG(pct_gain)                    avg_pct_gain
FROM s5
;

SELECT
count_rv
,ROUND(corr_rv_pg::NUMERIC,6)    corr_rv_pg
,ROUND(min_rv::NUMERIC,6)        min_rv
,ROUND(avg_rv::NUMERIC,6)        avg_rv
,ROUND(max_rv::NUMERIC,6)        max_rv
,ROUND(stddev_rv::NUMERIC,6)     stddev_rv
,ROUND(avg_pct_gain::NUMERIC,6)  avg_pct_gain
FROM s7
;

-- Look at pct_gain where recent_volatility is abnormally small

SELECT
COUNT(recent_volatility)
,MIN(ydate)
,MAX(ydate)
,AVG(pct_gain)
FROM s5
WHERE recent_volatility < 
  (SELECT avg_rv - 1.1*stddev_rv FROM s7)
;

-- Look at pct_gain where recent_volatility is near avg_recent_volatility

SELECT
COUNT(recent_volatility)
,MIN(ydate)
,MAX(ydate)
,AVG(pct_gain)
FROM s5
WHERE recent_volatility BETWEEN
  (SELECT avg_rv - 1.1*stddev_rv FROM s7)
  AND
  (SELECT avg_rv + 3*stddev_rv FROM s7)
;

-- Look at pct_gain where recent_volatility is abnormally large

SELECT
COUNT(recent_volatility)
,MIN(ydate)
,MAX(ydate)
,AVG(pct_gain)
FROM s5
WHERE recent_volatility > 
  (SELECT avg_rv + 3*stddev_rv FROM s7)
;

-- Look at recent data

SELECT
COUNT(recent_volatility)
,ROUND(AVG(recent_volatility),6) avg_recent_volatility
,MIN(ydate)
,MAX(ydate)
,AVG(pct_gain)
FROM s5
WHERE ydate > now()::DATE - 60
;
