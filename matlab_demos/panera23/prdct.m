% /a/ks/b/matlab/panera23/prdct.m

% This function calculates a set of predictions from is-data, oos-data, and a list of feature-names.
% The predictions are attached to a copy of the oos-data as a column called upprob.
% Then this enhanced copy is returned to the caller.

function prdctns = prdct(is4yr, oos4yr, myfeatures)

xis_t  = is4yr(1:end-1 , myfeatures);
xoos_t = oos4yr(:      , myfeatures);
yval_t = is4yr(1:end-1 , {'yval'});
xis  = table2array(xis_t);
xoos = table2array(xoos_t);
yval = table2array(yval_t);

mybvals = mnrfit(xis,     yval);
pihat   = mnrval(mybvals, xoos);

prdctns = oos4yr;
prdctns.upprob = pihat(:,2);

% done
