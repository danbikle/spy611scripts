% /a/ks/b/matlab/panera22/rpt_btr.m

allbt = readtable('backtest_results/allbt.csv');

'downprob1 = allbt( (allbt.upprob1<0.5) , : );'
downprob1 = allbt( (allbt.upprob1<0.5) , : );
mean(downprob1.pct1hg)
sum(downprob1.pct1hg)

'upprob1 = allbt( (allbt.upprob1>0.5) , : );'
upprob1 = allbt( (allbt.upprob1>0.5) , : );
mean(upprob1.pct1hg)
sum(upprob1.pct1hg)

'downprob2 = allbt( (allbt.upprob2<0.47) , : );'
downprob2 = allbt( (allbt.upprob2<0.47) , : );
mean(downprob2.pct1hg)
sum(downprob2.pct1hg)

'downprob2 = allbt( (allbt.upprob2<0.48) , : );'
downprob2 = allbt( (allbt.upprob2<0.48) , : );
mean(downprob2.pct1hg)
sum(downprob2.pct1hg)

'downprob2 = allbt( (allbt.upprob2<0.49) , : );'
downprob2 = allbt( (allbt.upprob2<0.49) , : );
mean(downprob2.pct1hg)
sum(downprob2.pct1hg)

'downprob2 = allbt( (allbt.upprob2<0.50) , : );'
downprob2 = allbt( (allbt.upprob2<0.50) , : );
mean(downprob2.pct1hg)
sum(downprob2.pct1hg)

'downprob2 = allbt( (allbt.upprob2>0.49 & allbt.upprob2<0.5) , : );'
downprob2 = allbt( (allbt.upprob2>0.49 & allbt.upprob2<0.5) , : );
mean(downprob2.pct1hg)
sum(downprob2.pct1hg)


'upprob2 = allbt( (allbt.upprob2>0.5) , : );'
upprob2 = allbt( (allbt.upprob2>0.5) , : );
mean(upprob2.pct1hg)
sum(upprob2.pct1hg)

'upprob2 = allbt( (allbt.upprob2>0.51) , : );'
upprob2 = allbt( (allbt.upprob2>0.51) , : );
mean(upprob2.pct1hg)
sum(upprob2.pct1hg)

'upprob2 = allbt( (allbt.upprob2>0.52) , : );'
upprob2 = allbt( (allbt.upprob2>0.52) , : );
mean(upprob2.pct1hg)
sum(upprob2.pct1hg)

'upprob2 = allbt( (allbt.upprob2>0.53) , : );'
upprob2 = allbt( (allbt.upprob2>0.53) , : );
mean(upprob2.pct1hg)
sum(upprob2.pct1hg)
