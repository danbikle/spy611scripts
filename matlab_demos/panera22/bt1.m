% /a/ks/b/matlab/panera22/bt1.m

% I use this script to get back test lr2lr on 30 minute bars.

spyv = readtable('data/spyv.csv');

is1_size = 20 * 1000;
boundry_index = is1_size + 1;

boundry_date = spyv.cpdate(boundry_index);
boundry_datestr = datestr(boundry_date)

oos_size = 100;
% corrp is the correlation of the last corrpwindow_size predictions.
% It is a feature in the 2nd running of LR.
% It is possible that if the last few predictions were accurate,
% then the next prediction might be better than average (or worse if mean-reversion is at play): 
corrpwindow_size = 6;

myfeatures = {...
'timegap1' ...
,'cpma'	   ...
,'nlag4'   ...
,'nlag3'   ...
,'nlag2'   ...
,'nlag1'   ...
}

% Specify boundry of divide of is1 data into is2 data and oos2 data.
is2_size = is1_size / 2;
% Intent:
% Cut is1 data in half.
% First  half will become is2.
% Second half will become oos2.

isoos1tables = genisoos1(spyv, boundry_date, is1_size, oos_size);
is1table = isoos1tables.is1table;

% From unweighted-is1table, generate is2table, oos2table:
is2table          = is1table(1:is2_size     , : ) ;
oos2table         = is1table(is2_size+1:end , : ) ;

% Generate is3table from is2table, oos2table

is3table = genis3table(is2table, oos2table, myfeatures, corrpwindow_size);

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

oos3table.corrp = corrnonan(oos3table.upprob1, oos3table.pct1hg, corrpwindow_size);

% Now that I have oos3table, which has the same features as is3table,
% and I have bvalues3 which I calculated earlier from is3table,
% I can calculate final predictions for oos3table:

x_oos3_t = oos3table(:, myfeatures2);
x_oos3   = table2array(x_oos3_t);
pihat    = mnrval(bvalues3, x_oos3);
results_table         = oos3table;
results_table.upprob2 = round(1000*pihat(:,2))/1000;


% Write results to csv for later reporting:
btfile = strcat('backtest_results/bt',int2str(boundry_index),'.csv');
writetable(results_table, btfile);

% done
