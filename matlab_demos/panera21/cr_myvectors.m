% /a/ks/b/matlab/panera21/cr_myvectors.m

% This script depends on 2 vectors:
% ydate
% cp

% Assume that I now have data from StockQuoteQuery() and noon55price.m

% datestr(ydate) is useful later on. Get it now:
ydatestr = datestr(ydate,'yyyy-mm-dd');

% Work towards features described here:
% http://www.spy611.com/blog

% Work towards current_price / 100day-moving-avg
% which I call cpma.
% Google: How I use matlab to calculate moving average?
% Leads to, matlab-gui: help filter

% step 1, pick a window.
% Here, the window is 100 days:
wndw = 100
% Follow what matlab-help-filter shows:
bval = ones(1,wndw)/wndw;
aval = 1
mvgavg100 = filter(bval, aval, cp);

% I want the 1st 100 values of mvgavg100 to be same as the variable I am averaging:
mvgavg100(1:100) = cp(1:100);

% Now that I have 100day mvg avg I can calculate cpma, the feature I want:
cpma = cp ./ mvgavg100;

% Now, work towards Normalized 1Day Gain which will eventually give me both yvals and 4 features.

mylead = [cp(2:end)' [NaN]]';

mydiff = mylead - cp;

n1dg = mydiff ./ cp;

% Now that I have n1dg, use it to work towards collecting features.

% Normalized 1-Day Gain, but a day ago:
n1dg1 = [0.0 n1dg(1:end-1)']';
% Above, n1dg1(1) is unknown so I set it to 0.0 which is a safe value.

% Normalized 1-Day Gain, but 2 days ago:
n1dg2 = [0.0 n1dg1(1:end-1)']';

% Normalized 1-Day Gain, but 3 days ago:
n1dg3 = [0.0 n1dg2(1:end-1)']';

% Normalized Gain over past 2 days:
n2dlagd = n1dg1 + n1dg2;

% I'm done with n1dg.
% Now, I want 1 week lag:

lag = 5

% Estimate 1st lag elements:
wlag1 = [cp(1:lag)' cp(1:end - lag)']';

% Here is the feature I want, normalized 1 week lag:
n1wlagd = (cp - wlag1) ./ wlag1;

% Next feature,
% I want 1 week lag, but from a week ago:
n2wlagd = [n1wlagd(1:lag)' n1wlagd(1:end - lag)']';

% Work towards the 2 features which are month-based.
% Use syntax similar to the above-week-syntax:
% I want 1 month lag:

lag = 20
mlag1 = [cp(1:lag)' cp(1:end - lag)']';

% Here is the feature I want, normalized 1 month lag:
n1mlagd = (cp - mlag1) ./ mlag1;

% I want 1 month lag but from a month ago:
n2mlagd = [n1mlagd(1:lag)' n1mlagd(1:end - lag)']';

% Work towards collecting future data which I will then transform into 3 types of y-values:

n2dg = [n2dlagd(3:end)' [NaN NaN]]';
n1wg = [n1wlagd(6:end)' [NaN NaN NaN NaN NaN]]';

% Now I have 3 future values: n1dg, n2dg, n1wg.

% Use terse matlab syntax to get vectors of yvalues.
% A y value is either 1 or 2 (Logistic regression prefers positive integers):
% I want this logic:
% If n1dg > 0.00042 then yvalue1d is 2 else it is 1.
% If n2dg > 0.00089 then yvalue2d is 2 else it is 1.
% If n1wg > 0.00259 then yvalue1w is 2 else it is 1.
yvalue1d = (n1dg > 0.00042);
% Now each yvalue1d is 0 or 1, add 1 to make em 1 or 2:
yvalue1d = yvalue1d + 1;
yvalue2d = 1 + (n2dg > 0.00089);
yvalue1w = 1 + (n1wg > 0.00259);

% Now that I have all my 9 features:
% cpma 
% n1dg1
% n1dg2
% n1dg3
% n2dlagd
% n1wlagd
% n2wlagd
% n1mlagd
% n2mlagd
% and yvalues: yvalue1d, yvalue2d, yvalue1w

% Store them in a table, myvectors, which I intend to act as a global datastore:

myvectors = table(...
ydate     ...
,ydatestr ...
,cp       ...
,cpma     ...
,n1dg1    ...
,n1dg2    ...
,n1dg3    ...
,n2dlagd  ...
,n1wlagd  ...
,n2wlagd  ...
,n1mlagd  ...
,n2mlagd  ...
,yvalue1d ...
,yvalue2d ...
,yvalue1w ...
,n1dg     ...
,n2dg     ...
,n1wg     ...
);

