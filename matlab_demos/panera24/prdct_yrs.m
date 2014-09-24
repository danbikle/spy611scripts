% /a/ks/b/matlab/panera24/prdct_yrs.m

% I use this function to collect predictions for a group of years.

% Demo:
% prdctns = prdct_yrs(1950, 1989, ccv, myfeatures, yvalue_name);

function prdctns = prdct_yrs(yr1, yr2, ccv, myfeatures, yvalue_name)

prdctns = table();
for yr = (yr1:yr2)
  isdata   = ccv(( ccv.yr >= yr & ccv.yr < yr + 25), : ) ;
  isdata      = isdata(1:end-5, :) ;
  isdata.yval = isdata(:, yvalue_name);
  isdata.yval = table2array(isdata.yval);
  oosdata     = ccv(( ccv.yr == yr + 25), : ) ;
  prdctns = vertcat(prdctns, prdct(isdata, oosdata, myfeatures) ) ;
end
