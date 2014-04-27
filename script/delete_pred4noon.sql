--
-- ~/spy611/script/delete_pred4noon.sql
--

-- Demo:
-- ./psqlmad.bash -f delete_pred4noon.sql -v yr="'2014'"

-- I use this script to delete some rows from:
-- ip_n1dg
-- ip_n2dg
-- ip_n1wg
-- I do this because the rows are about to get refilled
-- by ~/spy611/script/noon.bash

DELETE FROM ip_n1dg WHERE TO_CHAR(ydate,'YYYY') = :yr;
DELETE FROM ip_n2dg WHERE TO_CHAR(ydate,'YYYY') = :yr;
DELETE FROM ip_n1wg WHERE TO_CHAR(ydate,'YYYY') = :yr;
