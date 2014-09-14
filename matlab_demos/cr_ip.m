% /a/ks/b/matlab/cr_ip.m

% under construction

% Using  25 years of training data starting in 1964,
% create 25 years of initial predictions (for years 1989 through 2014).
% Data goes back to 1950, I might as well get it all:
startDate = datenum( [ 1950 1 1 ] )

endDate = now

symbl = '^GSPC'

freq = 'd'

% cp is closing-price:
[ydate, cp, openp, lowp, highp, volume, closeadj] = StockQuoteQuery( symbl, startDate, endDate, freq);

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

% Now that I have 100day mvg avg I can calculate cpma, the feature I want:
cpma = cp ./ mvgavg100;

% Now, work towards Normalized 1Day Gain which will eventually give me both yvals and 4 features.

mylead = [cp(2:end)' [NaN]]';

mydiff = mylead - cp;

n1dg = mydiff ./ cp;

% Now that I have n1dg, use it to work towards collecting features.

% Normalized 1-Day Gain, but a day ago:
n1dg1 = [[NaN] n1dg(1:end-1)']';

% Normalized 1-Day Gain, but 2 days ago:
n1dg2 = [[NaN] n1dg1(1:end-1)']';

% Normalized 1-Day Gain, but 3 days ago:
n1dg3 = [[NaN] n1dg2(1:end-1)']';

% Normalized Gain over past 2 days:
n2dlagd = n1dg1 + n1dg2;

% I'm done with n1dg.
% Now, I want 1 week lag:

lag = 5

% I need vector of 5 NaNs:
mynans = NaN * ones(1,lag)

% Use them:
wlag1 = [mynans cp(1:end - lag)']';

% Here is the feature I want, normalized 1 week lag:
n1wlagd = (cp - wlag1) ./ wlag1;

% Next feature,
% I want 1 week lag, but from a week ago:
n2wlagd = [mynans n1wlagd(1:end - lag)']';

% Work towards the 2 features which are month-based.
% Use syntax similar to the above-week-syntax:
% I want 1 month lag:

lag = 20
mynans = NaN * ones(1,lag);
mlag1 = [mynans cp(1:end - lag)']';

% Here is the feature I want, normalized 1 month lag:
n1mlagd = (cp - mlag1) ./ mlag1;

% I want 1 month lag but from a month ago:
n2mlagd = [mynans n1mlagd(1:end - lag)']';

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

% Store them in a struct, myvectors, which I intend to act as a global datastore:

myvectors.ydate    = ydate   ;
myvectors.cp       = cp	     ;
myvectors.cpma     = cpma    ;
myvectors.n1dg1    = n1dg1   ;
myvectors.n1dg2    = n1dg2   ;
myvectors.n1dg3    = n1dg3   ;
myvectors.n2dlagd  = n2dlagd ;
myvectors.n1wlagd  = n1wlagd ;
myvectors.n2wlagd  = n2wlagd ;
myvectors.n1mlagd  = n1mlagd ;
myvectors.n2mlagd  = n2mlagd ;
myvectors.yvalue1d = yvalue1d;
myvectors.yvalue2d = yvalue2d;
myvectors.yvalue1w = yvalue1w;
myvectors.n1dg     = n1dg    ;
myvectors.n2dg     = n2dg    ;
myvectors.n1wg     = n1wg    ;
			      
% I can use them to create initial predictions.

% Keep in mind I need to restrict training data to 25 years in the past before each prediction.
% I do this by batching up initial predictions by year.

yrs = (1989:2014)

ip25yr = []
for yr = yrs
  ip25yr = vertcat(ip25yr, cr_ip4yr(yr,myvectors));
end

% debug
% Lets look at the data:
size_ip25yr = size(ip25yr)
firstr = ip25yr(1:1,:)
lastr = ip25yr(end:end,:)

firstr = ip25yr(1:1,1:3)
lastr = ip25yr(end:end,1:3)

d1 = datestr(ip25yr(1:1,19),'yyyy-mm-dd')
d2 = datestr(ip25yr(end:end,19),'yyyy-mm-dd')

% debug
