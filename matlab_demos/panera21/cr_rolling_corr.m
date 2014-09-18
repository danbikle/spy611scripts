% /a/ks/b/matlab/panera21/cr_rolling_corr.m

% Calculate rolling_corr values for initial-predictions vs n1dg, n2dg, and n1wg

% I want a window on the last 100 days for each observation:
wndw = 100

% The data I want is in a table named: ip25yr

corr1d = rollingcorr(ip25yr.prob_1d, ip25yr.n1dg, wndw)';
corr2d = rollingcorr(ip25yr.prob_2d, ip25yr.n2dg, wndw)';
corr1w = rollingcorr(ip25yr.prob_1w, ip25yr.n1wg, wndw)';

% Deal with NaNs at ends:
corr1d(end) = corr1d(end-1);

corr2d(end) = corr2d(end-2);
corr2d(end-1) = corr2d(end-2);

corr1w(end) = corr1w(end-5);
corr1w(end-1) = corr1w(end-5);
corr1w(end-2) = corr1w(end-5);
corr1w(end-3) = corr1w(end-5);
corr1w(end-4) = corr1w(end-5);

% ip25yr keeps getting wider:
ip25yr.corr1d = corr1d;
ip25yr.corr2d = corr2d;
ip25yr.corr1w = corr1w;

size_ip25yr = size(ip25yr)
% Im done here.



