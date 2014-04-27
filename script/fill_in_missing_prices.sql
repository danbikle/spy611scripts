--
-- ~/spy611/script/fill_in_missing_prices.sql
--

-- This is a demo script I use to help me fill in missing prices near noon.
-- Usually I scrape the latest price off a web page.
-- This script allows me to fill in a price by hand.
-- I activate this script by copying it to /tmp/ and then editing the copy.
-- The edited copy is then run by:
-- ~/spy611/script/noon.bash

DELETE FROM mydata WHERE ydate = '2014-03-21';
INSERT INTO mydata (ydate,closing_price) VALUES ('2014-03-21',1868.70);
