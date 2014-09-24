--
-- /a/ks/b/matlab/panera24/rptvia_sqlite1.sql
--

DROP   TABLE nxt_prdctns;
CREATE TABLE nxt_prdctns (
ydatestr VARCHAR(22)
,ydate    INT
,cp       DECIMAL
);
.separator ","
.import data/nxt_prdctns.csv nxt_prdctns
.quit

