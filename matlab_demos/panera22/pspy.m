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

is1table = isoos1tables.is1table;
oos1table = isoos1tables.oos1table;

% Train, using is1table:

myfeatures = {...
'timegap1' ...
,'cpma'	   ...
,'nlag4'   ...
,'nlag3'   ...
,'nlag2'   ...
,'nlag1'   ...
}

bvalues1 = trainnow(is1table, myfeatures)

% Predict, using oos1table:

predictions1 = predictnow(oos1table, myfeatures, bvalues1);

% LR-report:
downg_prob = predictions1((predictions1.pct1hg < 0.0),{'upprob'});
upg_prob   = predictions1((predictions1.pct1hg > 0.0),{'upprob'});
mean_downg_prob = mean(downg_prob.upprob)
mean_upg_prob   = mean(upg_prob.upprob)
summary(downg_prob)
summary(upg_prob)


% Specify boundry of divide of is1 data into is2 data and oos2 data.
is2_size = is1_size / 2;
% Intent:
% Cut is1 data in half.
% First  half will become is2.
% Second half will become oos2.

% From is1table, generate is2table:
is2table = genis2table(is1table, is2_size);


