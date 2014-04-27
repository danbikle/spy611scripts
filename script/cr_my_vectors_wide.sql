--
-- ~/spy611/script/cr_my_vectors_wide.sql
--

-- Demo:
-- ./psqlmad.bash -f cr_my_vectors_wide.sql -v algo="'lr'"

DROP TABLE IF EXISTS my_vectors_wide;
CREATE TABLE my_vectors_wide AS
SELECT
ydate
,algo
-- data in the past:
,ARRAY[1
,cpma
,n1dg1
,n1dg2
,n1dg3
,n2dlagd
,n1wlagd
,n2wlagd
,n1mlagd
,n2mlagd
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
WHERE algo = :algo
ORDER BY ydate
;

-- rpt
SELECT DISTINCT algo   FROM my_vectors_wide;
SELECT MIN(ydate),COUNT(ydate),MAX(ydate) FROM my_vectors_wide;
