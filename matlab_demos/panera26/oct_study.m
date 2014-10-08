% /a/ks/b/matlab/panera26/oct_study.m

% Should I buy in October?

dateprice = readtable('data/dateprice.csv');

ccv = dateprice;

cp     = ccv.cp;

ccv.lead   = leadn(1,cp);

ccv.n1dg = (lead-cp) ./ cp;

ccv.mnth = datestr(ccv.ydate, 'mm');
ccv.mnth = str2num(ccv.mnth);

% All Octobers:
mean_octg    = mean(ccv.n1dg(ccv.mnth == 10))
mean_notoct  = mean(ccv.n1dg(ccv.mnth ~= 10))

% Last 24 Octobers:
ccv25y = ccv( end-(25*253):end, : );

mean_octg    = mean(ccv25y.n1dg(ccv25y.mnth == 10))
mean_notoct  = mean(ccv25y.n1dg(ccv25y.mnth ~= 10))

% October is a good time to buy.
