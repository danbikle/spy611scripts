% /a/ks/b/matlab/panera22/pspy.m

% I use this script to get recent prices and then issue predictions.

% General algorithm intent:

% I refer to algoart.txt for ASCII art to help me visualize pspy-data.

% I get SPY dates and prices from net into spyall.
% I generate features, future prices, and yvalues into spyv.
% I divide spyv into 4 pieces using boundry1, boundry2, and boundry3.
% boundry1 is 103 observations before now.
% I intend to judge the effectiveness of LR2LR on 100 recent observations,
% using recent data.

% The outcome of the last 3 observations should not be known yet.

% boundry2 is 10,000 observations before boundry1.
% boundry3 is 10,000 observations before boundry2.

% Note that boundry1 is fixed while LR2LR runs.

% Note that boundry2, and boundry3 maintain their 10,000 observation distance.

% During the process of generating initial predictions between boundry1 and boundry2,
% I will slide boundry2, and boundry3 to the right as I calculate initial predictions.
% The amount of each slide is controlled by variable: oospieces.
% Currently oospieces is set to 10, so boundry2-boundry3 will slide 10 times before
% boundry2 encounters boundry1.

% The observations between boundry2 and boundry3 are called is2-data.

% From spyv, I generate is2-data into is2table.

% Before and during the calculation of initial predictions,
% I call their container, oos2-data.

% After I fill oos2-data with predictions,
% I declare that I have a new feature: upprob1.

% I calculate the correlation between upprob1 and pct1hg and declare it to be another new feature:
% corrp

% Note that corrp only looks back 9 observations.
% This lookback-amount could be studied later.
% It is controlled in the code as variable: corrpwindow_rowcount.
% 9 observations feels right but perhaps it could be larger.
% On spy611.com I have corrpwindow_rowcount set to 100 which might be too large.

% Next, I declare that the observations between boundry2 and boundry3 are no longer oos2-data.
% They can now be used to train the 2nd pass of LR.

% I declare them to be is3-data.

% Now that is3-data has 2 new features, I need to add 2 new features to the 103-oos-observations
% which lie to the right of boundry1.

% I add them the same way I added them to is3-data.

% Next, I use a final run of LR to predict the 103-oos-observations.


% debug
% spyall = fill_spyall;
% spyall = readtable('data/spyall.csv');
% spyv   = cr_myvectors(spyall);
spyv = readtable('data/spyv.csv');
% debug

% I use this to tell LR2LR how far back to look in time 
% at recent predictions when it calculates the corrp feature:
corrpwindow_rowcount = 9

myfeatures = {...
'timegap1' ...
,'cpma'	   ...
,'nlag4'   ...
,'nlag3'   ...
,'nlag2'   ...
,'nlag1'   ...
}

% I define boundries by counting backwards from now:
rowcount_spyv = rowcount(spyv)
boundry1 = rowcount_spyv - 103
boundry2 = boundry1 - 10000
boundry3 = boundry2 - 10000
% Notice that boundry1 > boundry2 > boundry3 
% Note that boundry1 is newer than boundry2 is newer than boundry3

% Define my tables moving from older to newer to now:
is2table  = spyv(boundry3:boundry2,      :);
oos2table = spyv(boundry2:boundry1,      :);
oos1table = spyv(boundry1:rowcount_spyv, :);

% Generate is3table from is2table, oos2table

is3table = genis3table(is2table, oos2table, myfeatures, corrpwindow_rowcount);

% is3table is now 2 features wider than is2table.
% These 2 features, upprob1 and corrp, 
% contain introspective information about the effectiveness of LR.
% myfeatures2 = myfeatures
% myfeatures2 = [myfeatures, {'upprob1'}]
myfeatures2 = [myfeatures, {'upprob1','corrp'}]

% Generate bvalues3 from is3table.
is3table_weighted = weighttable(is3table);
bvalues3 = trainnow(is3table_weighted, myfeatures2)
% I will use bvalues3 later.

% Make a copy of oos2table and call it is4table:

is4table = oos2table;

% Use is4table, and myfeatures to create bvalues4.

is4table_weighted = weighttable(is4table);
bvalues4 = trainnow(is4table_weighted, myfeatures)

% Create 2 features for oos1table (upprob1 and corrp) and call the result oos3table.
% Why?
% Because,
% oos3 features should match is3 features.
x_oos1_t = oos1table(:, myfeatures);
x_oos1   = table2array(x_oos1_t);
pihat    = mnrval(bvalues4, x_oos1);
oos3table         = oos1table;
oos3table.upprob1 = pihat(:,2);

oos3table.corrp = corrnonan(oos3table.upprob1, oos3table.pct1hg, corrpwindow_rowcount);

% Now that I have oos3table, which has the same features as is3table,
% and I have bvalues3 which I calculated earlier from is3table,
% I can calculate final predictions for oos3table:

x_oos3_t = oos3table(:, myfeatures2);
x_oos3   = table2array(x_oos3_t);
pihat    = mnrval(bvalues3, x_oos3);
results_table         = oos3table;
results_table.upprob2 = round(1000*pihat(:,2))/1000;

