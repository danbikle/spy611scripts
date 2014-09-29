% /a/ks/b/matlab/panera25/rpt_p_vs_g.m

% I use this script to backtest SPY open-to-close predictions.

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

% Create vectors from dates and prices:
spyv = cr_spyv(dateprice);

% Now work towards collecting initial predictions
% where each prediction comes from 20 years of training observations:

myfeatures = {...
'pctg1'
,'pctg1ma10'
,'pctg1ma100'
,'n1dg1'
,'n1dg2'
,'n1dg3'
,'n1wlagd'
,'n2wlagd'
,'n1mlagd'
,'n2mlagd'
,'cpma'
,'cplag2open'
}' ;

ip20yr = table();
for yr = (2013:2014)
  ip20yr = vertcat(ip20yr, oc_ip4yr(yr,spyv, myfeatures));
end

% Make copy of spyv and cut it into 3 pieces:
% boundry3 ... piece3 ... boundry2 ... piece2 ... boundry1 ... piece1 ... end
boundry1 = rowcount(spyv) - 200;
boundry2 = round(boundry1/2);
boundry3 = 1;

piece1 = spyv(boundry1:end,      :);
piece2 = spyv(boundry2:boundry1, :);
piece3 = spyv(boundry3:boundry2, :);

% Use piece3 to predict both piece2 and piece1.
prdct2 = prdct(piece3, piece2, myfeatures);
prdct1 = prdct(piece3, piece1, myfeatures);

% Add 2 new features to copies of piece2 and piece1
isdata2  = prdct2;
oosdata1 = prdct1;

% upprob will get overwritten soon:
isdata2.upprob1  = isdata2.upprob;
oosdata1.upprob1 = oosdata1.upprob;

% Calculate corrp feature for both
corrp_rowcount = 9;
% corrp_rowcount tells cr_corrp() number of rows to look backwards during calls to corr():
isdata2.corrp  = cr_corrp(isdata2.upprob , isdata2.pctg , corrp_rowcount);
oosdata1.corrp = cr_corrp(oosdata1.upprob, oosdata1.pctg, corrp_rowcount);

myfeatures2 = [myfeatures, {'upprob1', 'corrp'}];

% Use isdata2 to predict oosdata1:
lr2lr_predictions         = prdct(isdata2, oosdata1, myfeatures2);
lr2lr_predictions.upprob2 = lr2lr_predictions.upprob;

lr2lr_predictions.upp1_rnd2 = roundn(2, lr2lr_predictions.upprob1);
upp1_100 = 100 * lr2lr_predictions.upp1_rnd2;
max_c1 = max(upp1_100);
sub1 = 1+round(max_c1 - upp1_100);

histo1 = table();
histo1.round_upprob1  = accumarray(sub1, lr2lr_predictions.upp1_rnd2, [], @max)   ;
histo1.count_upprob1  = accumarray(sub1, lr2lr_predictions.upp1_rnd2, [], @length);
histo1.mean_lr2lr_predictions_pctg = accumarray(sub1, lr2lr_predictions.pctg, [], @mean);
histo1.sum_lr2lr_predictions_pctg  = accumarray(sub1, lr2lr_predictions.pctg, [], @sum) ;

lr2lr_predictions.upp2_rnd2 = roundn(2, lr2lr_predictions.upprob2);
upp2_100 = 100 * lr2lr_predictions.upp2_rnd2;
max_c1 = max(upp2_100);
sub1 = 1+round(max_c1 - upp2_100);

histo2 = table();
histo2.round_upprob2  = accumarray(sub1, lr2lr_predictions.upp2_rnd2, [], @max)   ;
histo2.count_upprob2  = accumarray(sub1, lr2lr_predictions.upp2_rnd2, [], @length);
histo2.mean_lr2lr_predictions_pctg = accumarray(sub1, lr2lr_predictions.pctg, [], @mean);
histo2.sum_lr2lr_predictions_pctg  = accumarray(sub1, lr2lr_predictions.pctg, [], @sum) ;

histo2

down_up1 = lr2lr_predictions.pctg(lr2lr_predictions.upprob1 < 0.5);
count_down1 = length(down_up1)
mean_down1 = mean(down_up1)
sum_down1  = sum(down_up1)

up_up1 = lr2lr_predictions.pctg(lr2lr_predictions.upprob1 > 0.5);
count_up1 = length(up_up1)
mean_up1 = mean(up_up1)
sum_up1  = sum(up_up1)

all_up1 = lr2lr_predictions.pctg;
count_all = length(all_up1)
mean_all = mean(all_up1)
sum_all  = sum(all_up1)


down_up2 = lr2lr_predictions.pctg(lr2lr_predictions.upprob2 < 0.5);
count_down2 = length(down_up2)
mean_down2 = mean(down_up2)
sum_down2  = sum(down_up2)

up_up2 = lr2lr_predictions.pctg(lr2lr_predictions.upprob2 > 0.5);
count_up2 = length(up_up2)
mean_up2 = mean(up_up2)
sum_up2  = sum(up_up2)
