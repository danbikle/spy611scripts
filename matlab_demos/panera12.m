% panera12.m

% I use this script to demo how to calculate moving avg of stock market close price

% Start with a recent date then enhance this script later
startDate = datenum( [ 2013 1 1 ] )

endDate = now

symbl = '^GSPC'

freq = 'd'

[date, close, open, low, high, volume, closeadj] = StockQuoteQuery( symbl, startDate, endDate, freq)

% I want 100day mvg avg:
wndw  = 100
bval1 = ones(1,wndw);
bval2 = bval1/wndw;
aval  = 1
ma100 = filter(bval2, aval, close);
ma100(end-4:end)

% To check that filter() does what I want,
% I try to compute the mvg avg for the very last elem:
last100 = close(end-wndw-1:end);
ma100last = sum(last100)/wndw
% ma100last should match the last elem in ma100

% Later on,
% Here is the feature I want:
cpma = close ./ ma100 ;

% Look at last 5:
cpma(end-4:end)
