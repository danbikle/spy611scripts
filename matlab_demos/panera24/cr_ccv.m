% /a/ks/b/matlab/panera24/cr_ccv.m

% I use this script to transform dates and prices into vectors full of features.

% Demo:
% ccv = cr_ccv(dateprice);

function ccv = cr_ccv(dateprice)

ccv = dateprice;

cp     = ccv.cp;
lag    = lagn(1,cp);
lead   = leadn(1,cp);
lag5   = lagn(5,cp);
lead2  = leadn(2,cp);
lead5  = leadn(5,cp);
lag20  = lagn(20,cp);
lead20 = leadn(20,cp);

mvavg_wndw = 100;
% Follow what matlab-help-filter shows:
bval = ones(1,mvavg_wndw)/mvavg_wndw;
mvgavg100 = filter(bval, 1, cp);
mvgavg100(1:mvavg_wndw) = cp(1:mvavg_wndw);
cpma = cp ./ mvgavg100;

n1dg1   = (cp-lag) ./ lag;
n1wlagd = (cp-lag5) ./ lag5;
n1mlagd = (cp-lag20) ./ lag20;

n1dg2   = lagn(1,n1dg1);
n1dg3   = lagn(2,n1dg1);
n2wlagd = lagn(5, n1wlagd);
n2mlagd = lagn(20, n1mlagd);
% That is the past, now I want the future.

n1dg = (lead-cp) ./ cp;
n2dg = (lead2-cp) ./ cp;
n1wg = (lead5-cp) ./ cp;
yvalue1d = 1 + (n1dg > 0.00042);
yvalue2d = 1 + (n2dg > 0.00089);
yvalue1w = 1 + (n1wg > 0.00259);

% past:
ccv.cpma    = cpma   ;
ccv.n1dg1   = n1dg1  ;
ccv.n1dg2   = n1dg2  ;
ccv.n1dg3   = n1dg3  ;
ccv.n1wlagd = n1wlagd;
ccv.n2wlagd = n2wlagd;
ccv.n1mlagd = n1mlagd;
ccv.n2mlagd = n2mlagd;
% future:
ccv.n1dg     = n1dg    ;
ccv.n2dg     = n2dg    ;
ccv.n1wg     = n1wg    ;
ccv.yvalue1d = yvalue1d;
ccv.yvalue2d = yvalue2d;
ccv.yvalue1w = yvalue1w;
