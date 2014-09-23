% /a/ks/b/matlab/panera23/spy_close2open_study.m

% Question:
% What does SPY typically do between close and next day open?

% Get some data:

% startDate = datenum( [ 1993 1 1 ] );
% endDate = now;
% symbl = 'SPY';
% freq = 'd';
% 
% % cp is closing-price:
% [ydate, cp, openp, lowp, highp, volume, closeadj] = StockQuoteQuery(symbl, startDate, endDate, freq);
% 
% dateprice = table();
% dateprice.ydatestr = datestr(ydate,'yyyy-mm-dd');
% dateprice.ydate    = ydate;
% dateprice.openp    = openp;
% dateprice.cp       = cp;
% 
% writetable(dateprice, 'data/dateprice.csv');

dateprice = readtable('data/dateprice.csv');

spyco = dateprice;

openp = spyco.openp;
cp = spyco.cp;

opnxt = vertcat(openp(2:end), openp(end));
cnxt  = vertcat(cp(2:end)   , cp(end)   );
ocg   = cp - openp;
cog   = opnxt - cp;
ccg   = cnxt  - cp;

% Show sum of close to close gains:
sum_ccg1 = cp(end) - cp(1)

% Show sum of individual close to close gains:
sum_ccg2 = sum(ccg)

% show sum of open to close gains when the market is open:
sum_ocg = sum(ocg)
 
% show sum of close to open gains when the market is closed:
sum_cog = sum(cog)

% calculate pct-gains:
pct_ocg = 100.0 * ocg ./ cp;
pct_ccg = 100.0 * ccg ./ cp;
pct_cog = 100.0 * cog ./ cp;

% Show sum of close to close pct-gains:
sum_pct_ocg = sum(pct_ocg)
sum_pct_ccg = sum(pct_ccg)
sum_pct_cog = sum(pct_cog)

% Show group by of sum_pct_ocg by year.

spyco.yr = str2num(datestr(spyco.ydate,'yyyy'));
spyco.pct_ocg = pct_ocg;
spyco.pct_ccg = pct_ccg;
spyco.pct_cog = pct_cog;

% Ref graphic at bottom:
% http://www.mathworks.com/help/matlab-web/matlab/ref/accumarray.html#bt3682e-1_2
ocg_accum = accumarray(2015-spyco.yr,spyco.pct_ocg,[],@sum);
cog_accum = accumarray(2015-spyco.yr,spyco.pct_cog,[],@sum);
ccg_accum = accumarray(2015-spyco.yr,spyco.pct_ccg,[],@sum);

yyr = sort(unique(spyco.yr), 'descend');

sum_group_by_yr = table();

sum_group_by_yr.yr = yyr;
sum_group_by_yr.pct_opn_clos_g_sum4yr = ocg_accum;
sum_group_by_yr.pct_clos2opn_g_sum4yr = cog_accum;
sum_group_by_yr.pct_clos_clos_g_sum4yr = ccg_accum;

% done
