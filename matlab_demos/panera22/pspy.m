% /a/ks/b/matlab/panera22/pspy.m

% I use this script to get recent prices and then issue predictions.

% General algorithm intent:

% Get SPY dates and prices from net into spyall.
% Generate features, future prices, and yvalues into spyv.
% Divide spyv at boundry_date.
% From spyv, Generate is1-data into is1table.
% From spyv, Generate oos1-data into oos1table.
% Calculate LR-bvalues into bvalues1 (AKA train, or fit)
% Calculate predictions1.

% Specify boundry of divide of is1-data into is2-data and oos2-data.
% From is1-data and boundry2 generate is2-data, oos2-data.

% Calculate LR-bvalues into bvalues2.
% Calculate predictions2.

% Merge predictions2, corrp, and oos2-data into is3-data.

% From is3-data, Calculate LR-bvalues into bvalues3.

% Declare a copy of oos2-data to be is4-data.

% From is4 calculate LR-bvalues into bvalues4.

% Calculate predictions41 from bvalues4 and oos1-data.

% Merge predictions41 with oos1-data into oos3-data.

% Calculate predictions3 from bvalues3 and oos3-data.


% debug
% spyall = fill_spyall;
% spyall = readtable('data/spyall.csv');
% spyv   = cr_myvectors(spyall);
spyv = readtable('data/spyv.csv');
% debug

boundry_date = datenum([2014 08 01]);
is1_size = 20 * 1000;
% I size oos data at about 500 hours.
% Know though that many of these hours actually span days due to nights and weekends:
oos_size = 1000;

isoos1tables = genisoos1(spyv, boundry_date, is1_size, oos_size);

is1table          = isoos1tables.is1table;
is1table_weighted = isoos1tables.is1table_weighted;
oos1table         = isoos1tables.oos1table;

% Train, using is1table:

myfeatures = {...
'timegap1' ...
,'cpma'	   ...
,'nlag4'   ...
,'nlag3'   ...
,'nlag2'   ...
,'nlag1'   ...
}

bvalues1 = trainnow(is1table_weighted, myfeatures)

% Predict, using oos1table:

predictions1 = predictnow(oos1table, myfeatures, bvalues1);

% LR-report:
downg_prob = predictions1((predictions1.pct1hg < 0.0),{'upprob1'});
upg_prob   = predictions1((predictions1.pct1hg > 0.0),{'upprob1'});
mean_downg_prob = mean(downg_prob.upprob1)
mean_upg_prob   = mean(upg_prob.upprob1)
summary(downg_prob)
summary(upg_prob)


% Specify boundry of divide of is1 data into is2 data and oos2 data.
is2_size = is1_size / 2;
% Intent:
% Cut is1 data in half.
% First  half will become is2.
% Second half will become oos2.

% From unweighted-is1table, generate is2table, oos2table:
is2table          = is1table(1:is2_size-2   , : ) ;
oos2table         = is1table(is2_size+1:end , : ) ;
is2table_weighted = weighttable(is2table)         ;

% Generate is3table from is2table_weighted, oos2table

is3table = genis3table(is2table_weighted,oos2table,myfeatures);

% is3table is now 2 features wider than is2table.
% These 2 features, upprob1 and corrp, 
% contain introspective information about the effectiveness of LR.
myfeatures2 = [myfeatures, {'upprob1','corrp'}];

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
wndw  = 100;
oos3table.corrp = corrnonan(oos3table.upprob1, oos3table.pct1hg, wndw);

% Now that I have oos3table, which has the same features as is3table,
% and I have bvalues3 which I calculated earlier from is3table,
% I can calculate final predictions for oos3table:

x_oos3_t = oos3table(:, myfeatures2);
x_oos3   = table2array(x_oos3_t);
pihat    = mnrval(bvalues3, x_oos3);
results_table         = oos3table;
results_table.upprob2 = pihat(:,2);

% report results:
downprediction_gains1 = results_table( (results_table.upprob1 < 0.5) , {'pct1hg'});
upprediction_gains1   = results_table( (results_table.upprob1 > 0.5) , {'pct1hg'});
downprediction_gains2 = results_table( (results_table.upprob2 < 0.5) , {'pct1hg'});
upprediction_gains2   = results_table( (results_table.upprob2 > 0.5) , {'pct1hg'});

summary(downprediction_gains1)
summary(upprediction_gains1)

summary(downprediction_gains2)
summary(upprediction_gains2)

sum(downprediction_gains1.pct1hg ( not ( isnan ( downprediction_gains1.pct1hg ))))
sum(upprediction_gains1.pct1hg ( not ( isnan ( upprediction_gains1.pct1hg ))))

sum(downprediction_gains2.pct1hg ( not ( isnan ( downprediction_gains2.pct1hg ))))
sum(upprediction_gains2.pct1hg ( not ( isnan ( upprediction_gains2.pct1hg ))))

