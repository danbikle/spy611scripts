% noon55price.m

% I use this script to help me manually add estimated closing price to the oos-data.

% I intend to edit this script once a day at 12:55 and then run
% noon55.m which will predict tomorrow's closing price.

% Format:

% noon55_price = 2001.24
% noon55_date = datenum([2014 9 17])

noon55_price = 1992.00
noon55_date = datenum([2014 9 24])
noon55_datestr = datestr(noon55_date, 'yyyy-mm-dd')
now_is = datestr(now,'yyyy-mm-dd hh')


