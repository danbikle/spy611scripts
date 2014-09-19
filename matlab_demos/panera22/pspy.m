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
