% /a/ks/b/matlab/panera25/rpt_lr2lr.m

function my_lr2lr_rpt = rpt_lr2lr(lr2lr_predictions)

rpt = lr2lr_predictions(:, {'ydate','cp','upprob1','upprob2','pctg'});

rpt.ydatestr = datestr(rpt.ydate, 'yyyy-mm-dd');

nowstr = datestr(now, 'yyyy_mm_dd_HH_MMSS');
csvfile = strcat('data/my_lr2lr_rpt_',nowstr,'.csv');
'Writing initial prediction report to: '
csvfile
writetable(rpt, csvfile);

down_up1 = rpt((rpt.upprob1 < 0.5) , :);
down_up2 = rpt((rpt.upprob2 < 0.5) , :);

up_up1 = rpt((rpt.upprob1 > 0.5) , :);
up_up2 = rpt((rpt.upprob2 > 0.5) , :);

mean( nonan( down_up1.upprob1))
mean( nonan( down_up2.upprob2))

mean( nonan( up_up1.upprob1))
mean( nonan( up_up2.upprob2))

sum( nonan( down_up1.upprob1))
sum( nonan( down_up2.upprob2))

sum( nonan( up_up1.upprob1))
sum( nonan( up_up2.upprob2))

my_lr2lr_rpt = rpt;

