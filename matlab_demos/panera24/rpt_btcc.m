% /a/ks/b/matlab/panera24/rpt_btcc.m

% I use this function to help me study the effectiveness of close to close lr2lr predictions.

function myrpt = rpt_btcc(filename)

% function myrpt = rpt_btcc()
% nxt_prdctns = readtable('data/nxt_prdctns.csv');

nxt_prdctns = readtable(filename);

nprpt = nxt_prdctns(:, {'yr'
,'ydatestr'
,'cp'
,'upprob1d'
,'upprob2d'
,'upprob1w'
,'nxt_prob1d'
,'nxt_prob2d'
,'nxt_prob1w'
,'n1dg'
,'n2dg'
,'n1wg'});

down1d = nprpt((nprpt.nxt_prob1d<0.5),{'yr','n1dg'});
up1d   = nprpt((nprpt.nxt_prob1d>0.5),{'yr','n1dg'});

down2d = nprpt((nprpt.nxt_prob2d<0.5),{'yr','n2dg'});
up2d   = nprpt((nprpt.nxt_prob2d>0.5),{'yr','n2dg'});

down1w = nprpt((nprpt.nxt_prob1w<0.5),{'yr','n1wg'});
up1w   = nprpt((nprpt.nxt_prob1w>0.5),{'yr','n1wg'});

rptyr     = accumarray(2015-down1d.yr, down1d.yr,   [],@max);

down1dcount = accumarray(2015-down1d.yr, down1d.n1dg, [],@length);
down1dmean  = accumarray(2015-down1d.yr, down1d.n1dg, [],@mean);
down1dsum   = accumarray(2015-down1d.yr, down1d.n1dg, [],@sum);
up1dcount = accumarray(2015-up1d.yr, up1d.n1dg, [],@length);
up1dmean  = accumarray(2015-up1d.yr, up1d.n1dg, [],@mean);
up1dsum   = accumarray(2015-up1d.yr, up1d.n1dg, [],@sum);

down2dcount = accumarray(2015-down2d.yr, down2d.n2dg, [],@length);
down2dmean  = accumarray(2015-down2d.yr, down2d.n2dg, [],@mean);
down2dsum   = accumarray(2015-down2d.yr, down2d.n2dg, [],@sum);
up2dcount = accumarray(2015-up2d.yr, up2d.n2dg, [],@length);
up2dmean  = accumarray(2015-up2d.yr, up2d.n2dg, [],@mean);
up2dsum   = accumarray(2015-up2d.yr, up2d.n2dg, [],@sum);

down1wcount = accumarray(2015-down1w.yr, down1w.n1wg, [],@length);
down1wmean  = accumarray(2015-down1w.yr, down1w.n1wg, [],@mean);
down1wsum   = accumarray(2015-down1w.yr, down1w.n1wg, [],@sum);
up1wcount = accumarray(2015-up1w.yr, up1w.n1wg, [],@length);
up1wmean  = accumarray(2015-up1w.yr, up1w.n1wg, [],@mean);
up1wsum   = accumarray(2015-up1w.yr, up1w.n1wg, [],@sum);


myrpt = table();
myrpt.yr        = rptyr;
myrpt.down1dcount = down1dcount;
myrpt.down1dmean  = down1dmean;
myrpt.down1dsum   = down1dsum;
myrpt.up1dcount = up1dcount;
myrpt.up1dmean  = up1dmean;
myrpt.up1dsum   = up1dsum;
myrpt.diff1dsum = up1dsum - down1dsum;

myrpt.down2dcount = down2dcount;
myrpt.down2dmean  = down2dmean;
myrpt.down2dsum   = down2dsum;
myrpt.up2dcount = up2dcount;
myrpt.up2dmean  = up2dmean;
myrpt.up2dsum   = up2dsum;
myrpt.diff2dsum = up2dsum - down2dsum;

myrpt.down1wcount = down1wcount;
myrpt.down1wmean  = down1wmean;
myrpt.down1wsum   = down1wsum;
myrpt.up1wcount = up1wcount;
myrpt.up1wmean  = up1wmean;
myrpt.up1wsum   = up1wsum;
myrpt.diff1wsum = up1wsum - down1wsum;
myrpt.yrr       = rptyr;

%done
