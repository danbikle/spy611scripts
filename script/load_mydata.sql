--
-- ~/spy611/script/load_mydata.sql
--

TRUNCATE TABLE mydata;

-- Now fill ydata

COPY mydata (
ydate     
,opn      
,mx
,mn
,closing_price
,vol
,adjclse
) FROM '/tmp/mydata.csv' WITH csv
;

-- DELETE old data:
-- DELETE FROM mydata WHERE ydate < '1950-01-01';

-- Report:
SELECT
MIN(ydate)          min_ydate
,COUNT(ydate)       count_ydate
,MAX(ydate)         max_ydate
,MIN(closing_price) min_closing_price
,AVG(closing_price) avg_closing_price
,MAX(closing_price) max_closing_price
FROM mydata
;
