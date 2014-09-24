% /a/ks/b/matlab/panera24/noon55cc.m

% I use this script to now issue close to close predictions at noon55.

% Get some data:

% startDate = datenum( [ 1950 1 1 ] );
% endDate = now;
% symbl = '^GSPC';
% freq = 'd';
% 
% % cp is closing-price:
% [ydate, cp, openp, lowp, highp, volume, closeadj] = StockQuoteQuery(symbl, startDate, endDate, freq);
% 
% dateprice = table();
% dateprice.ydatestr = datestr(ydate,'yyyy-mm-dd');
% dateprice.ydate    = ydate;
% dateprice.cp       = cp;
% 
% writetable(dateprice, 'data/dateprice.csv');

dateprice = readtable('data/dateprice.csv');
new_lastrow = table();
noon55price;
% Add estimated closing price I expect to see in 5 minutes:
new_lastrow.ydatestr = noon55_datestr;
new_lastrow.ydate    = noon55_date;
new_lastrow.cp       = noon55_price;

new_dateprice = vertcat(dateprice, new_lastrow);

% Fill ccv with vectors:

ccv = cr_ccv(new_dateprice);

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

% Predict 1989+25 through 1989+25:
nxt_prdctns1d = prdct_yrs(1989, 1989, ccv2, myfeatures2, {'yvalue1d'});
nxt_prdctns2d = prdct_yrs(1989, 1989, ccv2, myfeatures2, {'yvalue2d'});
nxt_prdctns1w = prdct_yrs(1989, 1989, ccv2, myfeatures2, {'yvalue1w'});

nxt_prdctns = nxt_prdctns1d;
nxt_prdctns.nxt_prob1d = nxt_prdctns1d.upprob;
nxt_prdctns.nxt_prob2d = nxt_prdctns2d.upprob;
nxt_prdctns.nxt_prob1w = nxt_prdctns1w.upprob;

noon55_prdctns = nxt_prdctns(:,{'ydatestr','cp','upprob1d','upprob2d','upprob1w','nxt_prob1d','nxt_prob2d','nxt_prob1w'});
mynowstr = nowstr();
fname = strcat('data/noon55_prdctns_', mynowstr, '.csv');
writetable(noon55_prdctns,fname);
writetable(noon55_prdctns,'data/noon55_prdctns.csv');

