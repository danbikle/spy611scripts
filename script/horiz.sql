--
-- ~/spy611/script/horiz.sql
--

-- I use this script to demo how to get horizontal distance from 52wk max.
-- I Start by getting the value of the 52wk max for each day in the past.

DROP TABLE   h10;
CREATE TABLE h10 AS
SELECT
ydate
,closing_price cp
,MAX(closing_price) OVER (ORDER BY ydate ROWS BETWEEN 250 PRECEDING AND 0 PRECEDING) mx52
FROM mydata
ORDER BY ydate
;

-- Now join that value with past prices so 
-- I can get dates of 52wk max for each day in the past.
-- Know that when I join  a.mx52 = b.cp,
-- I cannot assume that a.mx52 is unique so obviously
-- I will sometimes get multiple joins.
-- Also I add a predicate to ensure 
-- I am only looking backwards in time for prices I want to join with.

DROP TABLE   h12;
CREATE TABLE h12 AS
SELECT
a.ydate
,b.ydate mx52date
,a.cp
,a.mx52
FROM h10 a, h10 b
WHERE a.mx52 = b.cp
AND a.ydate >= b.ydate
ORDER BY a.ydate, b.ydate
;

-- I dont want all the rows in h12.
-- I want the most recent row for each join of a.mx52 = b.cp
-- I use a GROUP BY technique combined with MAX() to force uniqueness.
-- The number of rows in h14 should be very near the h10 count.

DROP TABLE   h14;
CREATE TABLE h14 AS
SELECT
MAX(mx52date) mx52date
,ydate
,cp
,mx52
FROM h12
GROUP BY ydate,cp,mx52
ORDER BY ydate;
;

-- Now for each date I know the 52 week high and I know the date of that high.

-- For each row, I can now calculate horizontal distance between today
-- and the date of the last 52 week high.

DROP TABLE   h16;
CREATE TABLE h16 AS
SELECT
ydate
,mx52date
,cp
,mx52
,ydate - mx52date horiz_dist_mx52
FROM h14
ORDER BY ydate;
;

-- Lets look at the distribution of horiz_dist_mx52.
-- I expect the min to be near 0.
-- I expect the max to be near 365.

SELECT
MIN( horiz_dist_mx52)
,MAX(horiz_dist_mx52)
,AVG(horiz_dist_mx52)
,STDDEV(horiz_dist_mx52)
FROM h16
;

-- Add pct_gain to h16.

DROP TABLE   h18;
CREATE TABLE h18 AS
SELECT
ydate
,cp
,horiz_dist_mx52
,100 * (LEAD(cp) OVER (ORDER BY ydate) - cp) / cp pct_gain
FROM h16
ORDER BY ydate;
;

-- Look for simple relationships between horiz_dist_mx52 and pct_gain

SELECT COUNT(pct_gain),MIN(ydate),MAX(ydate),CORR(horiz_dist_mx52, pct_gain) FROM h18;
SELECT COUNT(pct_gain),MIN(ydate),MAX(ydate),AVG(pct_gain) FROM h18 WHERE horiz_dist_mx52 < 9;
SELECT COUNT(pct_gain),MIN(ydate),MAX(ydate),AVG(pct_gain) FROM h18 WHERE horiz_dist_mx52 BETWEEN 9 AND 357;
SELECT COUNT(pct_gain),MIN(ydate),MAX(ydate),AVG(pct_gain) FROM h18 WHERE horiz_dist_mx52 > 357;

-- done
-- Homework:

-- Write a similar script which studies horizontal distance between
-- today and data of last 52 week low.

