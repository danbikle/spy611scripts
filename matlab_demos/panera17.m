% /a/ks/b/matlab/panera17.m

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

% Use terse matlab syntax to get a vector of yvalues.
% A y value is either 1 or 2.
% I want this logic:
% If n1dg > 0 then yval is 2 else it is 1.
yvals = (n1dg > 0);
yvals = yvals + 1;

% Now that I have yvals, use n1dg to work towards collecting features.

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
% I can use them to create some training data.

% I want my training data to span from 6500 trading-days ago to 200 trading-days ago.
% I want my out-of-sample data to span from 199 days ago to yesterday.

xtraining = [ ...
cpma(end-6500:end-200) ...
n1dg1(end-6500:end-200) ...
n1dg2(end-6500:end-200) ...
n1dg3(end-6500:end-200) ...
n2dlagd(end-6500:end-200) ...
n1wlagd(end-6500:end-200) ...
n2wlagd(end-6500:end-200) ...
n1mlagd(end-6500:end-200) ...
n2mlagd(end-6500:end-200) ...
];

x_oos = [ ...
cpma(end-199:end-1) ...
n1dg1(end-199:end-1) ...
n1dg2(end-199:end-1) ...
n1dg3(end-199:end-1) ...
n2dlagd(end-199:end-1) ...
n1wlagd(end-199:end-1) ...
n2wlagd(end-199:end-1) ...
n1mlagd(end-199:end-1) ...
n2mlagd(end-199:end-1) ...
];

ytraining = yvals(end-6500:end-200);
y_oos     = yvals(end-199:end-1);

% Lets train.
% ref:
% http://www.mathworks.com/help/stats/mnrfit.html
% Using matlab jargon, now I can 'fit'.
bvals = mnrfit(xtraining,ytraining)

% Predict probabilities for the x_oos data.
% I am interested in the 2nd probability.
% It is the probability that tomorrow will be an up day.

pihat = mnrval(bvals, x_oos);

% Display the up-probabilities of x_oos.
% Match them up with y_oos.

prob_y_oos = [pihat(:,2) y_oos];

% Display 5 rows:
prob_y_oos(1:5, :)

% Select from prob_y_oos where y_oos == 1.0

sv1 = (prob_y_oos(:, 2) == 1)
sv2 = (prob_y_oos(:, 2) == 2)

prob_y_oos1 = prob_y_oos(sv1,:)
prob_y_oos2 = prob_y_oos(sv2,:)

% For each set of probabilities, what is count and avg?

% Count of down days:
count1 = length(prob_y_oos1(:,1))

% Count of up days:
count2 = length(prob_y_oos2(:,1))

% Avg prediction for the down days:
avg1 = mean(prob_y_oos1(:,1))

% Avg prediction for the up days:
avg2 = mean(prob_y_oos2(:,1))
