--
-- ~/spy611/script/ma/cr_my_vectors_wide.sql
--

-- Start by collecting prob_willbetrue and corrs:

DROP   TABLE IF EXISTS ip_n1dg10;
CREATE TABLE           ip_n1dg10 AS
SELECT algo,ydate,prob_willbetrue,pctgain
,CORR(prob_willbetrue,pctgain) OVER (PARTITION BY algo ORDER BY ydate ROWS BETWEEN 100 PRECEDING AND 1 PRECEDING) corr
FROM ip_n1dg
ORDER BY algo,ydate
;

-- rpt
SELECT MIN(ydate),COUNT(ydate),MAX(ydate) FROM ip_n1dg10 WHERE corr IS NULL;

DROP   TABLE IF EXISTS ip_n1dg_c;
CREATE TABLE           ip_n1dg_c AS
SELECT algo, ydate,prob_willbetrue,pctgain
,CASE WHEN corr IS NULL THEN 0 ELSE corr END corr
FROM ip_n1dg10
ORDER BY algo,ydate
;

-- rpt
SELECT MIN(ydate),COUNT(ydate),MAX(ydate) FROM ip_n1dg_c WHERE corr IS NULL;
SELECT MIN(ydate),MAX(ydate),COUNT(ydate) FROM ip_n1dg_c WHERE corr = 0;
SELECT MIN(corr),COUNT(corr),AVG(corr),MAX(corr) FROM ip_n1dg_c;

DROP   TABLE IF EXISTS ip_n2dg10;
CREATE TABLE           ip_n2dg10 AS
SELECT algo, ydate,prob_willbetrue,pctgain
,CORR(prob_willbetrue,pctgain) OVER (PARTITION BY algo ORDER BY ydate ROWS BETWEEN 100 PRECEDING AND 1 PRECEDING) corr
FROM ip_n2dg
ORDER BY algo,ydate
;

DROP   TABLE IF EXISTS ip_n1wg10;
CREATE TABLE           ip_n1wg10 AS
SELECT algo, ydate,prob_willbetrue,pctgain
,CORR(prob_willbetrue,pctgain) OVER (PARTITION BY algo ORDER BY ydate ROWS BETWEEN 100 PRECEDING AND 1 PRECEDING) corr
FROM ip_n1wg
ORDER BY algo,ydate
;

DROP   TABLE IF EXISTS ip_n2dg_c;
CREATE TABLE           ip_n2dg_c AS
SELECT algo, ydate,prob_willbetrue,pctgain
,CASE WHEN corr IS NULL THEN 0 ELSE corr END corr
FROM ip_n2dg10
ORDER BY algo,ydate
;

DROP   TABLE IF EXISTS ip_n1wg_c;
CREATE TABLE           ip_n1wg_c AS
SELECT algo, ydate,prob_willbetrue,pctgain
,CASE WHEN corr IS NULL THEN 0 ELSE corr END corr
FROM ip_n1wg10
ORDER BY algo,ydate
;

-- Lets joinem:

DROP TABLE IF EXISTS ip_c10;
CREATE TABLE ip_c10 AS
SELECT
i1.algo,i1.ydate
,i1.prob_willbetrue prob1
,i2.prob_willbetrue prob2
,i3.prob_willbetrue prob3
,i1.corr corr1
,i2.corr corr2
,i3.corr corr3
FROM ip_n1dg_c i1, ip_n2dg_c i2, ip_n1wg_c i3
WHERE i1.algo||i1.ydate = i2.algo||i2.ydate
AND   i1.algo||i1.ydate = i3.algo||i3.ydate
;

-- Remove dups

DROP TABLE IF EXISTS ip_c;
CREATE TABLE ip_c AS
SELECT
algo,ydate
,AVG(prob1) prob1
,AVG(prob2) prob2
,AVG(prob3) prob3
,AVG(corr1) corr1
,AVG(corr2) corr2
,AVG(corr3) corr3
FROM ip_c10
GROUP BY algo,ydate
ORDER BY algo,ydate
;

-- rpt
select count(*) from ip_c;

DROP   TABLE my_vectors_ip;
CREATE TABLE my_vectors_ip AS
SELECT
-- now:
v.ydate 
,cp
-- data in the past:
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
,ROUND(i.prob1::DECIMAL,4) prob1
,ROUND(i.prob2::DECIMAL,4) prob2
,ROUND(i.prob3::DECIMAL,4) prob3
,ROUND(i.corr1::DECIMAL,4) corr1
,ROUND(i.corr2::DECIMAL,4) corr2
,ROUND(i.corr3::DECIMAL,4) corr3
,i.algo
-- data in the future:
,n1dg -- norm. 1 day gain
,n2dg -- norm. 2 day gain
,n1wg -- norm. 1 wk  gain
,yvalue1d
,yvalue2d
,yvalue1w
FROM my_vectors v, ip_c i
WHERE v.ydate = i.ydate
AND i.algo = 'gbm'
ORDER BY v.ydate
;

DROP TABLE IF EXISTS my_vectors_wide;
CREATE TABLE my_vectors_wide AS
SELECT
ydate
,algo
-- data in the past:
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
,prob1
,prob2
,prob3
,corr1
,corr2
,corr3] my_vector
-- data in the future:
,n1dg
,n2dg
,n1wg
,yvalue1d
,yvalue2d
,yvalue1w
FROM my_vectors_ip
ORDER BY ydate
;

-- rpt
-- I want queries below to return 0's or small numbers:
SELECT MIN(ydate),COUNT(ydate),MAX(ydate) FROM my_vectors_ip WHERE corr1 IS NULL;
SELECT MIN(ydate),COUNT(ydate),MAX(ydate) FROM my_vectors_ip WHERE corr2 IS NULL;
SELECT MIN(ydate),COUNT(ydate),MAX(ydate) FROM my_vectors_ip WHERE corr3 IS NULL;
