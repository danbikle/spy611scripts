% /a/ks/b/matlab/panera23/btspy.m

% I use this script as a main entry point into my effort 
% to backtest close-to-open predictions of spy.

% Get some data:

% startDate = datenum( [ 1993 1 1 ] );
% endDate = now;
% symbl = 'SPY';
% freq = 'd';
% 
% % cp is closing-price:
% [ydate, cp, openp, lowp, highp, volume, closeadj] = StockQuoteQuery(symbl, startDate, endDate, freq);
% 
% dateprice = table();
% dateprice.ydatestr = datestr(ydate,'yyyy-mm-dd');
% dateprice.ydate    = ydate;
% dateprice.openp    = openp;
% dateprice.cp       = cp;
% 
% writetable(dateprice, 'data/dateprice.csv');

dateprice = readtable('data/dateprice.csv');

% Create vectors from dates and prices:
spyv = cr_spyv(dateprice);

% Now work towards collecting initial predictions
% where each prediction comes from 20 years of training observations:

myfeatures = {...
'cpma'
,'ocg'
,'n1dg1'
,'n1dg2'
,'n1dg3'
,'n1wlagd'
,'n2wlagd'
,'n1mlagd'
,'n2mlagd'
};

ip20yr = table();
for yr = (2013:2014)
  ip20yr = vertcat(ip20yr, co_ip4yr(yr,spyv, myfeatures));
end

% Report on initial-prediction effectiveness:
myiprpt = rpt_ip(ip20yr);
