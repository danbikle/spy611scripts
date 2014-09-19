% /a/ks/b/matlab/panera22/pspy.m

% I use this script to get recent prices and then issue predictions.

% spyall contains all the dates and prices I need to build vectors.

% debug
% spyall = fill_spyall;
% spyall = readtable('data/spyall.csv');
% spyv   = cr_myvectors(spyall);
spyv = readtable('data/spyv.csv');
% debug

% From all my vectors,
% Generate some in-sample and out-of-sample data suitable for Logistic Regression.

boundry_date = datenum([2014 08 01]);
is_size = 20123;
oos_size = 40.0 * 2 * 24;
[istable, oostable] = genisoos(spyv, boundry_date, is_size, oos_size);

% Train, using istable:

myfeatures = {...
'timegap1' ...
,'cpma'	   ...
,'nlag4'   ...
,'nlag3'   ...
,'nlag2'   ...
,'nlag1'   ...
}

mybvalues = trainnow(istable, myfeatures)

% Predict, using oostable:

mypredictions = predictnow(oostable, myfeatures, mybvalues);

% report:
downg_prob = mypredictions((mypredictions.pct1hg < 0.0),{'upprob'});
upg_prob   = mypredictions((mypredictions.pct1hg > 0.0),{'upprob'});

mean_downg_prob = mean(downg_prob.upprob)
mean_upg_prob   = mean(upg_prob.upprob)

summary(downg_prob)
summary(upg_prob)

