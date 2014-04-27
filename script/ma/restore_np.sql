--
-- ~/spy611/script/ma/restore_np.sql
--

DROP TABLE np_n1dg;
DROP TABLE np_n2dg;
DROP TABLE np_n1wg;

CREATE TABLE np_n1dg AS SELECT * FROM np_n1dg_bak0409;
CREATE TABLE np_n2dg AS SELECT * FROM np_n2dg_bak0409;
CREATE TABLE np_n1wg AS SELECT * FROM np_n1wg_bak0409;
