--
-- ~/spy611/script/backtests/drop_ip.sql
--

-- I use this script to drop initial prediction tables before I fill them from 
-- ~/spy611/script/backtests/night.bash

drop table IF EXISTS ip_n1dg;
drop table IF EXISTS ip_n2dg;
drop table IF EXISTS ip_n1wg;


