% /a/ks/b/matlab/panera19.m

format compact

% I use this script to demo logistic regression.

% Go back to 1950
startDate = datenum( [ 1950 1 1 ] )

endDate = now

symbl = '^GSPC'

freq = 'd'

[date, close, open, low, high, volume, closeadj] = StockQuoteQuery( symbl, startDate, endDate, freq);

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
mvgavg100 = filter(bval, aval, close);

% Now that I have 100day mvg avg I can calculate cpma, the feature I want:
cpma = close ./ mvgavg100;

% Now, work towards Normalized 1Day Gain which will eventually give me both yvals and 4 features.

mylead = [close(2:end)' [NaN]]';

mydiff = mylead - close;

n1dg = mydiff ./ close;

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
% and yvalues: yvalue1d, yvalue2d, yvalue1w,

% I can use them to create some training data.

% I want my training data to span from 6500 trading-days ago to 200 trading-days ago.
% I want my out-of-sample data to span from 194 days ago to yesterday.

% I need to add weight to the training data.
% I want the more recent data to have more weight.

w1_cpma     = cpma(end-6500:end-200);
w1_n1dg1    = n1dg1(end-6500:end-200);
w1_n1dg2    = n1dg2(end-6500:end-200);
w1_n1dg3    = n1dg3(end-6500:end-200);
w1_n2dlagd  = n2dlagd(end-6500:end-200);
w1_n1wlagd  = n1wlagd(end-6500:end-200);
w1_n2wlagd  = n2wlagd(end-6500:end-200);
w1_n1mlagd  = n1mlagd(end-6500:end-200);
w1_n2mlagd  = n2mlagd(end-6500:end-200);
w1_yvalue1d = yvalue1d(end-6500:end-200);
w1_yvalue2d = yvalue2d(end-6500:end-200);
w1_yvalue1w = yvalue1w(end-6500:end-200);

% Add weight from last 5 years:
w2_cpma     = w1_cpma(end-5*251:end);
w2_n1dg1    = w1_n1dg1(end-5*251:end);
w2_n1dg2    = w1_n1dg2(end-5*251:end);
w2_n1dg3    = w1_n1dg3(end-5*251:end);
w2_n2dlagd  = w1_n2dlagd(end-5*251:end);
w2_n1wlagd  = w1_n1wlagd(end-5*251:end);
w2_n2wlagd  = w1_n2wlagd(end-5*251:end);
w2_n1mlagd  = w1_n1mlagd(end-5*251:end);
w2_n2mlagd  = w1_n2mlagd(end-5*251:end);
w2_yvalue1d = w1_yvalue1d(end-5*251:end);
w2_yvalue2d = w1_yvalue2d(end-5*251:end);
w2_yvalue1w = w1_yvalue1w(end-5*251:end);

w1_xtraining = [ ...
w1_cpma    ...
w1_n1dg1   ...
w1_n1dg2   ...
w1_n1dg3   ...
w1_n2dlagd ...
w1_n1wlagd ...
w1_n2wlagd ...
w1_n1mlagd ...
w1_n2mlagd ...
];

w2_xtraining = [ ...
w2_cpma    ...
w2_n1dg1   ...
w2_n1dg2   ...
w2_n1dg3   ...
w2_n2dlagd ...
w2_n1wlagd ...
w2_n2wlagd ...
w2_n1mlagd ...
w2_n2mlagd ...
];

xtraining = vertcat(w1_xtraining, w2_xtraining);

yvalue1d_training = vertcat(w1_yvalue1d, w2_yvalue1d);
yvalue2d_training = vertcat(w1_yvalue2d, w2_yvalue2d);
yvalue1w_training = vertcat(w1_yvalue1w, w2_yvalue1w);

% Now I can fit (aka train).

bvals1d = mnrfit(xtraining, yvalue1d_training);
bvals2d = mnrfit(xtraining, yvalue2d_training);
bvals1w = mnrfit(xtraining, yvalue1w_training);

x_oos = [ ...
cpma(end-194:end-1) ...
n1dg1(end-194:end-1) ...
n1dg2(end-194:end-1) ...
n1dg3(end-194:end-1) ...
n2dlagd(end-194:end-1) ...
n1wlagd(end-194:end-1) ...
n2wlagd(end-194:end-1) ...
n1mlagd(end-194:end-1) ...
n2mlagd(end-194:end-1) ...
];

yvalue1d_oos = yvalue1d(end-194:end-1);
yvalue2d_oos = yvalue2d(end-194:end-1);
yvalue1w_oos = yvalue1w(end-194:end-1);

% Now predict the oos data and see how accurate the predictions are.

pihat1d = mnrval(bvals1d, x_oos);
pihat2d = mnrval(bvals2d, x_oos);
pihat1w = mnrval(bvals1w, x_oos);

% The down-probabilities of x_oos are in the 1stcol.
% The up-probabilities   of x_oos are in the 2nd col.
% I want the up-probabilities.

prob_y_oos1d = pihat1d(:,2);
prob_y_oos2d = pihat2d(:,2);
prob_y_oos1w = pihat1w(:,2);

% Display 5 rows:
prob_y_oos1d(1:5)
prob_y_oos2d(1:5);
prob_y_oos1w(1:5);

% Note the up y-values
upy1d = (yvalue1d_oos == 2);
upy2d = (yvalue2d_oos == 2);
upy1w = (yvalue1w_oos == 2);

% Note the down y-values
downy1d = (yvalue1d_oos == 1);
downy2d = (yvalue2d_oos == 1);
downy1w = (yvalue1w_oos == 1);

% Note the corresponding probabilities.
% SQL equivalent:
% SELECT prob FROM probs WHERE yval == 2
% SELECT prob FROM probs WHERE yval == 1

upprob1d = prob_y_oos1d(upy1d);
upprob2d = prob_y_oos2d(upy2d);
upprob1w = prob_y_oos1w(upy1w);

downprob1d = prob_y_oos1d(downy1d);
downprob2d = prob_y_oos2d(downy2d);
downprob1w = prob_y_oos1w(downy1w);

% Look at counts.
% For 2014 I should see more ups than downs:
length(upprob1d)
length(upprob2d)
length(upprob1w)

length(downprob1d)
length(downprob2d)
length(downprob1w)

% Look at averages.
% If Logistic Regression is predictive,
% I should see that probabilities associated with up-observations are
% higher than probabilities associated with down-observations.:

mean(upprob1d)
mean(upprob2d)
mean(upprob1w)

mean(downprob1d)
mean(downprob2d)
mean(downprob1w)


