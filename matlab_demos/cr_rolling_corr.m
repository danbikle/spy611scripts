% /a/ks/b/matlab/cr_rolling_corr.m

% under construction

% Calculate rolling_corr values for initial-predictions vs n1dg, n2dg, and n1wg
corr_window = 100

probn1dg  = ip25yr(:,1);
n1dg      = ip25yr(:,10);

probn2dg  = ip25yr(:,2);
n2dg      = ip25yr(:,11);

probn1wg  = ip25yr(:,3);
n1wg      = ip25yr(:,12);

corr1d = rollingcorr(probn1dg, n1dg, corr_window);
corr2d = rollingcorr(probn2dg, n2dg, corr_window);
corr1w = rollingcorr(probn1wg, n1wg, corr_window);

% Pass the corr-values along to next step:
ip25yr = [ip25yr corr1d' corr2d' corr1w'];


