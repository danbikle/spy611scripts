% /a/ks/b/matlab/panera25/six35price.m

% I use this script to help me manually convey recently observed SPY opening price to six35oc.m

% I intend to edit this script once a day at 06:35 and then run
% six35.m which will predict direction of today's closing price.

% Format:

% six35_price = 200.24
% six35_date = datenum([2014 9 17])

six35_date = datenum([2014 9 29])
six35_datestr = datestr(six35_date, 'yyyy-mm-dd')
six35_openp = 197.05

now_is = datestr(now,'yyyy-mm-dd hh')


