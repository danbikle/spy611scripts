% /a/ks/b/matlab/panera22/bt2.m

% I use this function to backtest lr2lr against a set constant sized oos observations.

% Demo:

% Set the size of each is-table:
% is1_rowcount = 20 * 1000;
% Set the size of each oos-table:
% oos_rowcount = 100;
% corrpwindow_rowcount = 9;

% spyv = readtable('data/spyv.csv');

% bt2(is1_rowcount, oos_rowcount, corrpwindow_rowcount, isstart, spyv);

% I then look for output here:
% backtest_results/bt*csv

function bt2out = bt2(is1_rowcount, oos_rowcount, corrpwindow_rowcount, isstart, spyv)

myfeatures = {...
'timegap1' ...
,'cpma'	   ...
,'nlag4'   ...
,'nlag3'   ...
,'nlag2'   ...
,'nlag1'   ...
}

% Specify boundry of divide of is1 data into is2 data and oos2 data.
is2_rowcount = is1_rowcount / 2;
% Intent:
% Cut is1 data in half.
% First  half will become is2.
% Second half will become oos2.

[is1table oos1table] = genisoos1(spyv, is1_rowcount, oos_rowcount, isstart);

% From unweighted-is1table, generate is2table, oos2table:
is2table          = is1table(1:is2_rowcount     , : ) ;
oos2table         = is1table(is2_rowcount+1:end , : ) ;

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

% Write results to csv for later reporting:
btfile = strcat('backtest_results/bt',int2str(isstart+is1_rowcount),'.csv');
writetable(results_table, btfile);

bt2out = 'Done'

