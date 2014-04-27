--
-- ~/spy611/script/ma/qry_wide.sql
--

SELECT
algo,
TO_CHAR(ydate,'YYYY') yr
,COUNT(TO_CHAR(ydate,'YYYY')) count_yr
FROM ip_n1dg
GROUP BY algo,TO_CHAR(ydate,'YYYY')
ORDER BY algo,TO_CHAR(ydate,'YYYY')
;

SELECT
algo,
TO_CHAR(ydate,'YYYY') yr
,COUNT(TO_CHAR(ydate,'YYYY')) count_yr
FROM ip_n2dg
GROUP BY algo,TO_CHAR(ydate,'YYYY')
ORDER BY algo,TO_CHAR(ydate,'YYYY')
;

SELECT
algo,
TO_CHAR(ydate,'YYYY') yr
,COUNT(TO_CHAR(ydate,'YYYY')) count_yr
FROM ip_n1wg
GROUP BY algo,TO_CHAR(ydate,'YYYY')
ORDER BY algo,TO_CHAR(ydate,'YYYY')
;

SELECT
algo,TO_CHAR(ydate,'YYYY') yr
,COUNT(algo) count_rows
FROM ip_c
GROUP BY algo,TO_CHAR(ydate,'YYYY')
ORDER BY algo,TO_CHAR(ydate,'YYYY')
;

SELECT
algo,TO_CHAR(ydate,'YYYY') yr
,COUNT(algo) count_rows
FROM my_vectors_ip
GROUP BY algo,TO_CHAR(ydate,'YYYY')
ORDER BY algo,TO_CHAR(ydate,'YYYY')
;

SELECT
algo,TO_CHAR(ydate,'YYYY') yr
,COUNT(algo) count_rows
FROM my_vectors_wide
GROUP BY algo,TO_CHAR(ydate,'YYYY')
ORDER BY algo,TO_CHAR(ydate,'YYYY')
;
