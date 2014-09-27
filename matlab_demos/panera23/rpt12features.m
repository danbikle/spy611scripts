% /a/ks/b/matlab/panera23/rpt12features.m

% I use this report to help me compare 12 features to 9 features.
% Also I look at class boundry of zero vs boundry of is-median.

rpt9 = readtable('data/my_lr2lr_rpt_9features.csv');
rpt9m = readtable('data/my_lr2lr_rpt_9features_median_boundry.csv');

rpt12 = readtable('data/my_lr2lr_rpt_12features.csv');
rpt12m = readtable('data/my_lr2lr_rpt_12features_median_boundry.csv');


rpt912_c = {'rsult','myval';
'rpt9down1sum', sum(rpt9.pctg(rpt9.upprob1 < 0.5));
'rpt12down1sum', sum(rpt12.pctg(rpt12.upprob1 < 0.5));
'rpt9up1sum', sum(rpt9.pctg(rpt9.upprob1 > 0.5));
'rpt12up1sum', sum(rpt12.pctg(rpt12.upprob1 > 0.5));
'rpt9mdown1sum', sum(rpt9m.pctg(rpt9m.upprob1 < 0.5));
'rpt12mdown1sum', sum(rpt12m.pctg(rpt12m.upprob1 < 0.5));
'rpt9mup1sum', sum(rpt9m.pctg(rpt9m.upprob1 > 0.5));
'rpt12mup1sum', sum(rpt12m.pctg(rpt12m.upprob1 > 0.5));
'rpt9mdown1mean', mean(rpt9m.pctg(rpt9m.upprob1 < 0.5));
'rpt12mdown1mean', mean(rpt12m.pctg(rpt12m.upprob1 < 0.5));
'rpt9mup1mean', mean(rpt9m.pctg(rpt9m.upprob1 > 0.5));
'rpt12mup1mean', mean(rpt12m.pctg(rpt12m.upprob1 > 0.5));
}

rpt912 = cell2table(rpt912_c)

rpt9.upp1_rnd2 = roundn(2, rpt9.upprob1);
upp1_100 = 100 * rpt9.upp1_rnd2;
max_c1 = max(upp1_100);
sub1 = 1+round(max_c1 - upp1_100);

hist91 = table();
hist91.round_upprob1  = accumarray(sub1, rpt9.upp1_rnd2, [], @max);
hist91.count_upprob1  = accumarray(sub1, rpt9.upp1_rnd2, [], @length);
hist91.mean_rpt9_pctg = accumarray(sub1, rpt9.pctg,      [], @mean);
hist91.sum_rpt9_pctg  = accumarray(sub1, rpt9.pctg,      [], @sum);


rpt9.upp2_rnd2 = roundn(2, rpt9.upprob2);
upp2_100 = 100 * rpt9.upp2_rnd2;
max_c1 = max(upp2_100);
sub1 = 1+round(max_c1 - upp2_100);

hist92 = table();
hist92.round_upprob2  = accumarray(sub1, rpt9.upp2_rnd2, [], @max);
hist92.count_upprob2  = accumarray(sub1, rpt9.upp2_rnd2, [], @length);
hist92.mean_rpt9_pctg = accumarray(sub1, rpt9.pctg,      [], @mean);
hist92.sum_rpt9_pctg  = accumarray(sub1, rpt9.pctg,      [], @sum);

% rpt12:

rpt12.upp1_rnd2 = roundn(2, rpt12.upprob1);
upp1_100 = 100 * rpt12.upp1_rnd2;
max_c1 = max(upp1_100);
sub1 = 1+round(max_c1 - upp1_100);

hist121 = table();
hist121.round_upprob1  = accumarray(sub1, rpt12.upp1_rnd2, [], @max);
hist121.count_upprob1  = accumarray(sub1, rpt12.upp1_rnd2, [], @length);
hist121.mean_rpt12_pctg = accumarray(sub1, rpt12.pctg,     [], @mean);
hist121.sum_rpt12_pctg  = accumarray(sub1, rpt12.pctg,     [], @sum);


rpt12.upp2_rnd2 = roundn(2, rpt12.upprob2);
upp2_100 = 100 * rpt12.upp2_rnd2;
max_c1 = max(upp2_100);
sub1 = 1+round(max_c1 - upp2_100);

hist122 = table();
hist122.round_upprob2  = accumarray(sub1, rpt12.upp2_rnd2, [], @max);
hist122.count_upprob2  = accumarray(sub1, rpt12.upp2_rnd2, [], @length);
hist122.mean_rpt12_pctg = accumarray(sub1, rpt12.pctg,     [], @mean);
hist122.sum_rpt12_pctg  = accumarray(sub1, rpt12.pctg,     [], @sum);


% median boundry rather than 0-boundry:

rpt9m.upp1_rnd2 = roundn(2, rpt9m.upprob1);
upp1_100 = 100 * rpt9m.upp1_rnd2;
max_c1 = max(upp1_100);
sub1 = 1+round(max_c1 - upp1_100);

hist91m = table();
hist91m.round_upprob1  = accumarray(sub1, rpt9m.upp1_rnd2, [], @max);
hist91m.count_upprob1  = accumarray(sub1, rpt9m.upp1_rnd2, [], @length);
hist91m.mean_rpt9_pctg = accumarray(sub1, rpt9m.pctg,      [], @mean);
hist91m.sum_rpt9_pctg  = accumarray(sub1, rpt9m.pctg,      [], @sum);


rpt9m.upp2_rnd2 = roundn(2, rpt9m.upprob2);
upp2_100 = 100 * rpt9m.upp2_rnd2;
max_c1 = max(upp2_100);
sub1 = 1+round(max_c1 - upp2_100);

hist92m = table();
hist92m.round_upprob2  = accumarray(sub1, rpt9m.upp2_rnd2, [], @max);
hist92m.count_upprob2  = accumarray(sub1, rpt9m.upp2_rnd2, [], @length);
hist92m.mean_rpt9_pctg = accumarray(sub1, rpt9m.pctg,      [], @mean);
hist92m.sum_rpt9_pctg  = accumarray(sub1, rpt9m.pctg,      [], @sum);

% rpt12m:

rpt12m.upp1_rnd2 = roundn(2, rpt12m.upprob1);
upp1_100 = 100 * rpt12m.upp1_rnd2;
max_c1 = max(upp1_100);
sub1 = 1+round(max_c1 - upp1_100);

hist121m = table();
hist121m.round_upprob1  = accumarray(sub1, rpt12m.upp1_rnd2, [], @max);
hist121m.count_upprob1  = accumarray(sub1, rpt12m.upp1_rnd2, [], @length);
hist121m.mean_rpt12m_pctg = accumarray(sub1, rpt12m.pctg,     [], @mean);
hist121m.sum_rpt12m_pctg  = accumarray(sub1, rpt12m.pctg,     [], @sum);


rpt12m.upp2_rnd2 = roundn(2, rpt12m.upprob2);
upp2_100 = 100 * rpt12m.upp2_rnd2;
max_c1 = max(upp2_100);
sub1 = 1+round(max_c1 - upp2_100);

hist122m = table();
hist122m.round_upprob2  = accumarray(sub1, rpt12m.upp2_rnd2, [], @max);
hist122m.count_upprob2  = accumarray(sub1, rpt12m.upp2_rnd2, [], @length);
hist122m.mean_rpt12m_pctg = accumarray(sub1, rpt12m.pctg,     [], @mean);
hist122m.sum_rpt12m_pctg  = accumarray(sub1, rpt12m.pctg,     [], @sum);
