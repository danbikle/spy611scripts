% /a/ks/b/matlab/panera22/simple_lr_bt.m

% I use this script to back test simple LR 30 minute bars.

spyv = readtable('data/spyv.csv');

is1_size = 20 * 1000;
boundry_index = is1_size + 1;
% boundry_date = datenum([2014 08 01]);
boundry_date = spyv.cpdate(boundry_index)
boundry_datestr = datestr(boundry_date)

oos_size         = 100;
% corrp is the correlation of the last corrpwindow_size predictions.
% It is a feature in the 2nd running of LR.
% It is possible that if the last few predictions were accurate,
% then the next prediction might be better than average (or worse if mean-reversion is at play): 
corrpwindow_size = 6;

isoos1tables = genisoos1(spyv, boundry_date, is1_size, oos_size);

% Add weight to the newer rows in is1table.
is1table_weighted = weighttable(isoos1tables.is1table);

% Train, using is1table_weighted:

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

predictions1 = predictnow(isoos1tables.oos1table, myfeatures, bvalues1);

% That completes simple LR.
