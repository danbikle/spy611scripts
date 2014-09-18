% /a/ks/b/matlab/panera21/cr_ip.m

% Using  25 years of training data starting in 1964,
% create 25 years of initial predictions (for years 1989 through 2014).
% Data goes back to 1950, I might as well get it all:
startDate = datenum( [ 1950 1 1 ] )

endDate = now

symbl = '^GSPC'

freq = 'd'

% cp is closing-price:
[ydate, cp, openp, lowp, highp, volume, closeadj] = StockQuoteQuery( symbl, startDate, endDate, freq);

cr_myvectors

% Keep in mind I need to restrict training data to 25 years in the past before each prediction.
% I do this by batching up initial predictions by year.

yrs = (1989:2014)

ip25yr = table();
for yr = yrs
  ip25yr = vertcat(ip25yr, cr_ip4yr(yr,myvectors));
end

size_myvectors = size(myvectors)
size_ip25yr    = size(ip25yr)

% done

