--
-- ~/spy611/script/bak_ip.sql
--

-- I use this script to backup initial predictions:

-- DROP TABLE my_vectors_ip_bak;
CREATE TABLE my_vectors_ip_bak AS SELECT * FROM my_vectors_ip;
CREATE TABLE my_vectors_ip_bak0409 AS SELECT * FROM my_vectors_ip;

-- Restore with this syntax...
-- CREATE TABLE ip_n1dg AS SELECT algo,ydate,prob1 prob_willbetrue,100*n1dg pctgain FROM my_vectors_ip_bak;
-- CREATE TABLE ip_n2dg AS SELECT algo,ydate,prob2 prob_willbetrue,100*n2dg pctgain FROM my_vectors_ip_bak;
-- CREATE TABLE ip_n1wg AS SELECT algo,ydate,prob3 prob_willbetrue,100*n1wg pctgain FROM my_vectors_ip_bak;
