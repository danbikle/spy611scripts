% /a/ks/b/matlab/panera22/cr_myvectors.m

% I use this function to help me fill a table named spyv
% which I use to hold vectors headed for Logistic Regression.

% Demo:
% spyv = cr_myvectors(spyall);

function tableout = cr_myvectors(tablein)
tableout = table();

cp     = tablein.cp;
cpdate = tablein.cpdate;

% Track time gaps between observations.
% Most gaps are 30 min apart.
% UOM of tablein.cp is day:
cpdate1 = [cpdate(1) cpdate(1:end-1)' ]' ;
% Convert to minutes:
timegap = 60 * 24 * (cpdate - cpdate1);

% Logistic Regression likes simplified features.
% Intent: timegap1 is 1 if (timegap > 31) else timegap1 is 0:
timegap1 = (timegap > 31);

% Build some columns I want to use to build vectors.
% Get a copy of cp and shift it down 1 so lagging cp lines up with cp:
cplag1 = [cp(1) cp(1:end-1)' ]' ;
% thrice more
cplag2 = [cp(1) cplag1(1:end-1)' ]' ;
cplag3 = [cp(1) cplag2(1:end-1)' ]' ;
cplag4 = [cp(1) cplag3(1:end-1)' ]' ;
% Calculate the moving avg of the last 100 observations:
wndw = 100
bval = ones(1,wndw)/wndw;
mvgavg100 = filter(bval, 1, cp);

% I want the 1st 100 values of mvgavg100 to be same as the variable I am averaging:
mvgavg100(1:100) = cp(1:100);

% Now I can calculate some features
nlag1 = (cp-cplag1) ./ cp;
nlag2 = (cp-cplag2) ./ cp;
nlag3 = (cp-cplag3) ./ cp;
nlag4 = (cp-cplag4) ./ cp;
cpma  = cp ./ mvgavg100;

% Get a copy of cp and shift it up twice so 2nd leading cp lines up with cp:
cplead = [cp(3:end)' [NaN NaN] ]' ;
% pct 1hr gain:
pct1hg = 100.0 * (cplead - cp) ./ cp;
% My eventual intent is to predict direction of pct1hg.

% Logistic Regression wants me to categorize my gains.
% Intent: yval is 1 if (pct1hg <= 0) else yval is 2:
yval = (pct1hg > 0) + 1;

% Place all this new data into a table:
tableout = tablein;
tableout.timegap  = timegap;
tableout.timegap1 = timegap1;
tableout.cpma   = cpma;
tableout.nlag4  = nlag4;
tableout.nlag3  = nlag3;
tableout.nlag2  = nlag2;
tableout.nlag1  = nlag1;
tableout.pct1hg = pct1hg;
tableout.yval   = yval;

% Time for a backup:
writetable(tableout,'data/spyv.csv');

% done

