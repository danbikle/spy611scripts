% /a/ks/b/matlab/crvec3.m

% I use this script to demo some vector creations for ML.
% Demo:
% run('/a/ks/b/matlab/crvec3.m')

% This script depends on these shell commands:
% cd /a/tmp/
% wget --output-document=/a/tmp/gspc.csv  http://ichart.finance.yahoo.com/table.csv?s=%5EGSPC

% Fill a structure which Matlab calls a table:
mytable10 = readtable('/a/tmp/gspc.csv');
% If you on windows you might have something like this:
mytable10 = readtable('c:\Users\zvi\Downloads\gspc.csv')

% Look at Date and Close of 9 rows:
mytable10(1:9,{'Date','Close'});

% debug
% develop this script with a small amount of data (22 rows) and then
% eventually remove this line:
mytable11 = mytable10(1:22,{'Date','Close'});
% debug

% Order the table by Date
[mytable12, index] = sortrows(mytable11, 'Date');

% Look at Date and Close of 9 rows:
mytable12(1:9,{'Date','Close'})

% Create a new column and call it lagp.
% To do that...
% Shift prices down 1 day via circshift() to add lag price to each row:
mytable12.lagp = circshift(mytable12.Close,1);
% circshift() put last day in first day, I dont like that.
% Flag the first day as bad data:
mytable12.lagp(1) = NaN;

% Look at 1st 9 rows:
mytable12(1:9,{'Date','Close','lagp'})


% Create a new column.
% I want (today - yesterday) / today
% I call it normalized lag:
mytable12.nlag = (mytable12.Close - mytable12.lagp)./mytable12.Close;

% Look at 1st 9 rows:
mytable12(1:9,{'Date','Close','lagp','nlag'})

% Create a new column and call it leadp.
% To do that...
% Shift prices up 1 day via circshift() to add lead price to each row:
mytable12.leadp = circshift(mytable12.Close,-1);
% circshift() put first day in last day, I dont like that.
% Flag the last day as bad data:
mytable12.leadp(end) = NaN;

% Look at last 9 rows:
mytable12(end-9:end,{'Date','Close','lagp','nlag','leadp'})

% Create a new column.
% I want (tomorrow - today) / today
% I call it normalized gain:
mytable12.ngain = (mytable12.leadp - mytable12.Close)./mytable12.Close;
% Flag the last day as bad data since we dont know the gain for the
% last day yet:
mytable12.ngain(end) = NaN;

% Look at last 9 rows:
mytable12(end-9:end,{'Date','Close','lagp','nlag','leadp','ngain'})

% Look for negative correlation-tween nlag and ngain:
columns = {'Date','nlag','ngain'};
mytable14 = mytable12(:,columns);
% But first I need to filter out NaN rows:
rows = not(isnan(mytable14.nlag));
mytable16 = mytable14(rows, columns);
rows = not(isnan(mytable16.ngain));
mytable18 = mytable16(rows, columns);
mytable18
% Now I can Look for negative correlation-tween nlag and ngain:
corr(mytable18.nlag,mytable18.ngain)

% Create a new column.
% If ngain > 0 I want 2 else I want 1.
% This will place ngain into 2 categories.

% To start, I want this:
% mytable18.yval = 1;
% That is invalid syntax tho.
% So create a vector of ones:
myv1 = ones(height(mytable18),1);
% Convert it to a table:
my1table = array2table(myv1);

% matlab allows me to create a column from a table.
% Now create a column named yval which is full of ones:
mytable18(:,{'yval'}) = my1table

% Change some of the ones to a 2 where ngain > 0:
mytable18.yval(mytable18.ngain > 0) = 2;

mytable18

% Now I am setup to do Logistic Regression.

% ref:
% http://www.mathworks.com/help/stats/mnrfit.html
xvals = table2array(mytable18(:,{'nlag'}));
yvals = table2array(mytable18(:,{'yval'}));
% Using matlab jargon, now I can 'fit'.
% I prefer the term 'train':
bvals = mnrfit(xvals, yvals)

% Suppose SPY goes up/down 1% today,
% What will happen tomorrow?
xoos_up = [1.0/100.00]
xoos_down = [-1.0/100.00]

% ref
% http://www.mathworks.com/help/stats/mnrval.html

% Here I should see 2 probabilites, they should add to 1.0
% First prob is for class 1 which I call the 'down-class'
% 2nd prob is for the 'up-class'.
% I should see that prob1 is greater than prob2,
% because SPY nlag is negatively correlated with ngain.
% Or in stock jargon,
% A 1-percent move up is a bearish indicator:
pihat = mnrval(bvals,xoos_up)

% Here I see probabilities for a large negative SPY nlag:
pihat = mnrval(bvals,xoos_down)

% Also I should see that the bullish indicator is stronger
% for large down drops.

% Mean reversion is stronger after sharp drops compared to
% Mean reversion after sharp gains.
