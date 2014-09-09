% panera11.m

% I use this script to demo logistic regression of stock market data

% Start with a recent date then enhance this script later
startDate = datenum( [ 2014 8 1 ] )

endDate = now

symbl = '^GSPC'

freq = 'd'

[date, close, open, low, high, volume, closeadj] = StockQuoteQuery( symbl, startDate, endDate, freq)

% Work towards Normalized 1-Day Gain.
% Instead of using circshift, use a combo of horzcat and indexing:

mylead = [close(2:end)' [NaN]]'

twoc = [close mylead]

mydiff = mylead - close

n1dg = mydiff ./ close

% now that I have n1dg, work towards collecting features

n1dg1 = [[NaN] n1dg(1:end-1)']'

n1dg2 = [[NaN] n1dg1(1:end-1)']'

n1dg3 = [[NaN] n1dg2(1:end-1)']'

% visualize 3 features and dependent yvalue (n1dg): 

threeFand1Yval = [n1dg3 n1dg2 n1dg1 n1dg]
