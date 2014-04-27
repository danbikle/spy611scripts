--
-- ~/spy611/script/ma/qry_recent.sql
--

SELECT * FROM np_n1dg WHERE ydate +30 > (SELECT MAX(ydate) FROM np_n1dg) ORDER BY ydate;
SELECT * FROM np_n2dg WHERE ydate +30 > (SELECT MAX(ydate) FROM np_n2dg) ORDER BY ydate;
SELECT * FROM np_n1wg WHERE ydate +30 > (SELECT MAX(ydate) FROM np_n1wg) ORDER BY ydate;
