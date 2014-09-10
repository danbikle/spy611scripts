% /a/ks/b/matlab/panera14.m

format compact

% I use this script to demo building of vectors for machine learning.

% Start with a recent date then enhance this script later
startDate = datenum( [ 1950 1 1 ] )

endDate = now

symbl = '^GSPC'

freq = 'd'

[date, close, open, low, high, volume, closeadj] = StockQuoteQuery( symbl, startDate, endDate, freq);

% Work towards features described here:
% http://www.spy611.com/blog

% Work towards Normalized 1-Day Gain.

mylead = [close(2:end)' [NaN]]';

mydiff = mylead - close;

n1dg = mydiff ./ close;

% Now that I have n1dg, work towards collecting features.

% Normalized 1-Day Gain, but a day ago:
n1dg1 = [[NaN] n1dg(1:end-1)']';

% Normalized 1-Day Gain, but 2 days ago:
n1dg2 = [[NaN] n1dg1(1:end-1)']';

% Normalized 1-Day Gain, but 3 days ago:
n1dg3 = [[NaN] n1dg2(1:end-1)']';

% Normalized Gain over past 2 days:
n2dlagd = n1dg1 + n1dg2;

% I want 1 week lag:

lag = 5

% I need vector of 5 NaNs:
mynans = NaN * ones(1,lag)

% Use them:
wlag1 = [mynans close(1:end - lag)']';

% Here is the feature I want, normalized 1 week lag:
n1wlagd = (close - wlag1) ./ wlag1;

% Next feature,
% I want 1 week lag, but from a week ago:
n2wlagd = [mynans n1wlagd(1:end - lag)']';

% Work towards the 2 features which are month-based.
% Use syntax similar to the above-week-syntax:
% I want 1 month lag:

lag = 20
mynans = NaN * ones(1,lag);
mlag1 = [mynans close(1:end - lag)']';

% Here is the feature I want, normalized 1 month lag:
n1mlagd = (close - mlag1) ./ mlag1;

% I want 1 month lag but from a month ago:
n2mlagd = [mynans n1mlagd(1:end - lag)']';

% Visualize first 60 rows:
first60 = [n1dg1(1:60) ...
n1dg2(1:60) ...
n1dg3(1:60) ...
n2dlagd(1:60) ...
n1wlagd(1:60) ...
n2wlagd(1:60) ...
n1mlagd(1:60) ...
]
% n2mlagd(1:60)]


% Visualize last 60 rows:
last60 = [n1dg1(end-59:end) ...
n1dg2(end-59:end) ...
n1dg3(end-59:end) ...
n2dlagd(end-59:end) ...
n1wlagd(end-59:end) ...
n2wlagd(end-59:end) ...
n1mlagd(end-59:end) ...
]
% n2mlagd(end-59:end)]

