/a/ks/b/matlab/panera21/readme.txt

The files in this dir support an operational effort to predict tomorrow's SPY closing-price.

Much of the syntax used here is borrowed from scripts associated with panera20.m

I used panera20.m to backtest Matlab-logistic-regression
combined with my ideas of optimal training data.

I used panera20.m to convince myself that I could use
Matlab-logistic-regression to effectively predict SPY on a daily basis.

panera21 is not focused on backtesting like panera20.m is.

Instead panera21 is for 'operations'; I use it daily.

I operate the panera21 software in this directory to support 3 use-cases:

1. In the morning I setup optimal training data.

2. Near, but before, market-close I add an estimate of today's closing
price and then predict tomorrow's closing price.

3. On Friday night I study the effectiveness of my predictions from the last week and month.

Here are some details connected to each of the above use-cases:

1. I use a script called morning.m to get most of the training data I need ready for use-case2.

2. I use a script called noon55.m to accept an estimate of today's closing
price and then predict tomorrow's closing price.
I intend to run noon55.m at 12:55 California time which is 5 minutes before market close.
I want noon55.m to give me a prediction by 12:58 so have 2 minutes to act on it.

3. I use a script called frinight.m to report on the effectiveness
of noon55.m-predictions from the last week and month.

