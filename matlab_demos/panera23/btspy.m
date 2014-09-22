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

spyv = readtable('data/dateprice.csv');
spyv.opnxt = vertcat(spyv.openp(2:end), NaN);
spyv.pctg  = 100.0*(spyv.opnxt - spyv.cp)./spyv.cp;
spyv.yval  = 1+(spyv.pctg >= 0);
% cpma is my 1st feature:
wndw             = 100;
bval             = ones(1,wndw)/wndw;
mvgavg100        = filter(bval, 1, spyv.cp);
mvgavg100(1:100) = spyv.cp(1:100);
spyv.cpma = spyv.cp ./ mvgavg100;

cplag      = vertcat(NaN, spyv.cp(1:end-1) )    ;
spyv.n1dg1 = (spyv.cp - cplag) ./ cplag         ;
spyv.n1dg2 = vertcat(NaN, spyv.n1dg1(1:end-1) ) ;
spyv.n1dg3 = vertcat(NaN, spyv.n1dg2(1:end-1) ) ;

lag = 5;
wlag1 = vertcat(spyv.cp(1:lag), spyv.cp(1:end - lag));
spyv.n1wlagd = (spyv.cp - wlag1) ./ wlag1;
spyv.n2wlagd = vertcat(spyv.n1wlagd(1:lag), spyv.n1wlagd(1:end - lag));

lag = 20
mlag1 = vertcat(spyv.cp(1:lag), spyv.cp(1:end - lag));
spyv.n1mlagd = (spyv.cp - mlag1) ./ mlag1;
spyv.n2mlagd = vertcat(spyv.n1mlagd(1:lag), spyv.n1mlagd(1:end - lag));

% Features calculated now.

% Now work towards collecting initial predictions.


