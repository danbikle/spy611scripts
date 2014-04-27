--
-- ~/spy611/script/ma/restore_ip.sql
--

DROP TABLE ip_n1dg;
DROP TABLE ip_n2dg;
DROP TABLE ip_n1wg;

CREATE TABLE ip_n1dg AS SELECT algo,ydate,prob1 prob_willbetrue,100*n1dg pctgain FROM my_vectors_ip_bak0409;
CREATE TABLE ip_n2dg AS SELECT algo,ydate,prob2 prob_willbetrue,100*n2dg pctgain FROM my_vectors_ip_bak0409;
CREATE TABLE ip_n1wg AS SELECT algo,ydate,prob3 prob_willbetrue,100*n1wg pctgain FROM my_vectors_ip_bak0409;
