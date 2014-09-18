% /a/ks/b/matlab/panera21/morning.m

% I usually run this script in the morning to prepare all the data I
% need to run another script near market-close.

format compact

% Using  25 years of training data starting in 1964,
% create 25 years of initial predictions (for years 1989 through 2014)
cr_ip

writetable(myvectors, 'myvectors.csv');
writetable(ip25yr,    'ip25yr.csv');
% Restore above tables with calls to readtable():
% myvectors = readtable('myvectors.csv');
% ip25yr    = readtable('ip25yr.csv');

% Calculate rolling_corr values for initial-predictions vs n1dg, n2dg, and n1wg
cr_rolling_corr
% Backup ip25yr, it has 3 new columns now:
writetable(ip25yr,    'ip25yr.csv');

% Create enhanced training data for 2014 from 9 original features and rolling_corr values
cr_enh_x_is
writetable(enh_is_data, 'enh_is_data.csv');
writetable(x_enh_is_t,  'x_enh_is_t.csv');

% Create enhanced out-of-sample data for 2014 from 9 original features and rolling_corr values
cr_enh_x_oos
writetable(enh_oos_data, 'enh_oos_data.csv');
writetable(x_enh_oos_t,  'x_enh_oos_t.csv');

% Report status of data after morning.m 
morning_rpt
