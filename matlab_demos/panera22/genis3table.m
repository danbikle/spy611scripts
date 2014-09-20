% /a/ks/b/matlab/panera22/genis3table.m

% Generate is3table from is2table, oos2table

function tableout = genis3table(is2table_weighted, oos2table, myfeatures)

bvalues2 = trainnow(is2table_weighted, myfeatures);

% I Calculate predictions2 now:
predictions2 = predictnow(oos2table, myfeatures, bvalues2);
% prediction values are actually the last column of predictions2 
% Generate a feature I call corrp.
% It is running correlation between upprob1 and pct1hg.
wndw = 100;
corrp = corrnonan(predictions2.upprob1, predictions2.pct1hg, wndw);

tableout       = predictions2;
tableout.corrp = corrp;

% done
