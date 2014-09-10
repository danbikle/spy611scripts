% /a/ks/b/matlab/panera15.m

% A simple demo of using both mnrfit(xvals,yvals) and mnrval(bvals,xoos).
% mnrfit() creates bvals which contains predictive information.
% mnrval() uses bvals to predict yvals for xoos

% Here are 4 days of dummy pct-gains:
gains = [0.1 -0.1 0.2 -0.3]'

% Pretend the above gains depend on xvals:
xvals = -1 * gains

% Matlab has some convenient, but terse syntax I can use to transform a vector of gains 
% into a vector of class-values:
yvals = (gains > 0)
yvals = 1 + yvals
% Now I am setup to do Logistic Regression.

% ref:
% http://www.mathworks.com/help/stats/mnrfit.html
% Using matlab jargon, now I can 'fit'.
bvals = mnrfit(xvals, yvals)

% Now predict tomorrow after a down day with pct-gain of -0.05:
xoos_down = [-0.05]

% pihat gives me probabilities of where tomorrow will land:
pihat = mnrval(bvals,xoos_down)

% Since I only have 2 classes, 
% I should see only 2 probabilities,
% and they should add up to 1.

% I am interested in the 2nd probability.
% It is the probability that tomorrow will be an up day.
