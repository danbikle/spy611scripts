--
-- ~/spy611/script/delete_pred4night.sql
--

-- Demo:
-- ./psqlmad.bash -f delete_pred4night.sql -v $YR

-- I use this script to delete some rows from:
-- ip_n1dg
-- ip_n2dg
-- ip_n1wg

-- np_n1dg
-- np_n2dg
-- np_n1wg

-- I do this because the rows are about to get refilled
-- by ~/spy611/script/night.bash

SELECT COUNT(*) FROM ip_n1dg WHERE TO_CHAR(ydate,'YYYY') = '2014';
SELECT COUNT(*) FROM np_n1dg WHERE TO_CHAR(ydate,'YYYY') = '2014';

DELETE FROM ip_n1dg WHERE TO_CHAR(ydate,'YYYY') = :yr;
DELETE FROM ip_n2dg WHERE TO_CHAR(ydate,'YYYY') = :yr;
DELETE FROM ip_n1wg WHERE TO_CHAR(ydate,'YYYY') = :yr;

DELETE FROM np_n1dg WHERE TO_CHAR(ydate,'YYYY') = :yr;
DELETE FROM np_n2dg WHERE TO_CHAR(ydate,'YYYY') = :yr;
DELETE FROM np_n1wg WHERE TO_CHAR(ydate,'YYYY') = :yr;

SELECT COUNT(*) FROM ip_n1dg WHERE TO_CHAR(ydate,'YYYY') = '2014';
SELECT COUNT(*) FROM np_n1dg WHERE TO_CHAR(ydate,'YYYY') = '2014';
