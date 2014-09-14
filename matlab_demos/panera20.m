% /a/ks/b/matlab/panera20.m

format compact

% I use this script to demo logistic regression.

% Using  25 years of training data starting in 1964,
% create 25 years of initial predictions (for years 1989 through 2014)
cr_ip

% debug
qquit
% debug

% Calculate rolling_corr values for initial-predictions vs n1dg, n2dg, and n1wg
cr_rolling_corr

% Create enhanced training data for 2014 from 9 original features and rolling_corr values
cr_enh_x_is

% Create enhanced out-of-sample data for 2014 from 9 original features and rolling_corr values
cr_enh_x_oos

% Predict oos 2014 observations
predict_oos

% Report effectiveness of my algo
rpt_algo





