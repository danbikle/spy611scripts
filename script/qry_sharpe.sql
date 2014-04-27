--
-- ~/spy611/script/qry_sharpe.sql
--

CREATE OR REPLACE VIEW sharpe20 AS
SELECT
ydate
,(LEAD(closing_price) OVER (ORDER BY ydate) - closing_price)/closing_price     n1dg
,(LEAD(closing_price,5) OVER (ORDER BY ydate) - closing_price)/closing_price   n1wg
,(LEAD(closing_price,21) OVER (ORDER BY ydate) - closing_price)/closing_price  n1mg
,(LEAD(closing_price,251) OVER (ORDER BY ydate) - closing_price)/closing_price n1yg
FROM mydata
ORDER BY ydate
;

SELECT
MIN(ydate)                min_date
,COUNT(ydate)             count_date
,MAX(ydate)               max_date
,ROUND(AVG(n1dg) / STDDEV(n1dg),3) sharpe_r_1day
,ROUND(AVG(n1wg) / STDDEV(n1wg),3) sharpe_r_1week
,ROUND(AVG(n1mg) / STDDEV(n1mg),3) sharpe_r_1month
,ROUND(AVG(n1yg) / STDDEV(n1yg),3) sharpe_r_1yr
FROM sharpe20
WHERE ydate > '2000-01-01'
;

SELECT
MIN(ydate)                min_date
,COUNT(ydate)             count_date
,MAX(ydate)               max_date
,ROUND(AVG(n1dg) / STDDEV(n1dg),3) sharpe_r_1day
,ROUND(AVG(n1wg) / STDDEV(n1wg),3) sharpe_r_1week
,ROUND(AVG(n1mg) / STDDEV(n1mg),3) sharpe_r_1month
,ROUND(AVG(n1yg) / STDDEV(n1yg),3) sharpe_r_1yr
FROM sharpe20
;


