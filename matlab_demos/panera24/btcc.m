% /a/ks/b/matlab/panera24/btcc.m

% I use this script to help me backtest close to close lr2lr predictions of GSPC.

% Get some data:

startDate = datenum( [ 1950 1 1 ] );
endDate = now;
symbl = '^GSPC';
freq = 'd';

% cp is closing-price:
[ydate, cp, openp, lowp, highp, volume, closeadj] = StockQuoteQuery(symbl, startDate, endDate, freq);

dateprice = table();
dateprice.ydatestr = datestr(ydate,'yyyy-mm-dd');
dateprice.ydate    = ydate;
dateprice.cp       = cp;

writetable(dateprice, 'data/dateprice.csv');

dateprice = readtable('data/dateprice.csv');

% Fill ccv with vectors:

ccv = cr_ccv(dateprice);

% Get ready to,
% collect initial predictions for 1975 until now using previous 25 years of data.

myfeatures = {
'cpma'
,'n1dg1'
,'n1dg2'
,'n1dg3'
,'n1wlagd'
,'n2wlagd'
,'n1mlagd'
,'n2mlagd'
}' ;

% Group ccv by year:
dv1 = datevec(ccv.ydate);
ccv.yr = dv1(:,1);

% Predict 1950+25 through 1989+25:
iprdctns = prdct_yrs(1950, 1989, ccv, myfeatures, {'yvalue1d'});

% Now I have initial predictions.
% I need to transform them into features.
ccv2 = iprdctns;

ccv2.upprob1d = ccv2.upprob;
corrp_rowcount = 100;
ccv2.corrp1d = cr_corrp(ccv2.upprob1d, ccv2.n1dg, corrp_rowcount);

% Next yval:
iprdctns = prdct_yrs(1950, 1989, ccv, myfeatures, {'yvalue2d'});
ccv2.upprob2d = iprdctns.upprob;
ccv2.corrp2d = cr_corrp(ccv2.upprob2d, ccv2.n2dg, corrp_rowcount);

% Next yval:
iprdctns = prdct_yrs(1950, 1989, ccv, myfeatures, {'yvalue1w'});
ccv2.upprob1w = iprdctns.upprob;
ccv2.corrp1w = cr_corrp(ccv2.upprob1w, ccv2.n1wg, corrp_rowcount);

% Collect next predictions for 1989 until now using previous 25 years of data.

myfeatures2 = {
'cpma'
,'n1dg1'
,'n1dg2'
,'n1dg3'
,'n1wlagd'
,'n2wlagd'
,'n1mlagd'
,'n2mlagd'
,'upprob1d'
,'upprob2d'
,'upprob1w'
,'corrp1d'
,'corrp2d'
,'corrp1w'
}' ;

% Predict 1975+25 through 1989+25:
nxt_prdctns1d = prdct_yrs(1975, 1989, ccv2, myfeatures2, {'yvalue1d'});
nxt_prdctns2d = prdct_yrs(1975, 1989, ccv2, myfeatures2, {'yvalue2d'});
nxt_prdctns1w = prdct_yrs(1975, 1989, ccv2, myfeatures2, {'yvalue1w'});

nxt_prdctns = nxt_prdctns1d;
nxt_prdctns.nxt_prob1d = nxt_prdctns1d.upprob;
nxt_prdctns.nxt_prob2d = nxt_prdctns2d.upprob;
nxt_prdctns.nxt_prob1w = nxt_prdctns1w.upprob;

mynowstr = nowstr();
fname = strcat('data/nxt_prdctns_', mynowstr, '.csv');
writetable(nxt_prdctns,fname);
writetable(nxt_prdctns,'data/nxt_prdctns.csv');

myrpt = rpt_btcc('data/nxt_prdctns.csv');


