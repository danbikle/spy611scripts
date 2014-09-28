% /a/ks/b/matlab/panera23/rpt_ip.m

% Report on initial-prediction effectiveness

% Demo:
% myiprpt = rpt_ip(ip20yr);

function myiprpt = rpt_ip(ip20yr)

downp49 = ip20yr( (ip20yr.upprob < 0.49) ,: );
downp50 = ip20yr( (ip20yr.upprob < 0.5) , : );

upp50    = ip20yr( (ip20yr.upprob >= 0.5) , : );
upp51    = ip20yr( (ip20yr.upprob > 0.51) , : );
upp55    = ip20yr( (ip20yr.upprob > 0.55) , : );
upp60    = ip20yr( (ip20yr.upprob > 0.60) , : );
upp65    = ip20yr( (ip20yr.upprob > 0.65) , : );

rowcount_downp49 = rowcount(downp49)
rowcount_downp50 = rowcount(downp50)

rowcount_upp50 = rowcount(upp50)
rowcount_upp51 = rowcount(upp51)
rowcount_upp55 = rowcount(upp55)
rowcount_upp60 = rowcount(upp60)
rowcount_upp65 = rowcount(upp65)

mean_downp49 = mean( nonan(downp49.pctg))
mean_downp50 = mean( nonan(downp50.pctg))

mean_upp50 = mean( nonan(upp50.pctg))
mean_upp51 = mean( nonan(upp51.pctg))
mean_upp55 = mean( nonan(upp55.pctg))
mean_upp60 = mean( nonan(upp60.pctg))
mean_upp65 = mean( nonan(upp65.pctg))

sum_downp49 = sum( nonan(downp49.pctg))
sum_downp50 = sum( nonan(downp50.pctg))

sum_upp50 = sum( nonan(upp50.pctg))
sum_upp51 = sum( nonan(upp51.pctg))
sum_upp55 = sum( nonan(upp55.pctg))
sum_upp60 = sum( nonan(upp60.pctg))
sum_upp65 = sum( nonan(upp65.pctg))

myiprpt = ip20yr(:, {'ydate','cp','upprob','pctg'});
myiprpt.ydatestr = datestr(myiprpt.ydate, 'yyyy-mm-dd');

nowstr = datestr(now, 'yyyy_mm_dd_HH_MMSS');
csvfile = strcat('data/myiprpt_',nowstr,'.csv');
'Writing initial prediction report to: '
csvfile
writetable(myiprpt, csvfile);

% done
