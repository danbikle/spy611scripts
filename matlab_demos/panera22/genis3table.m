% /a/ks/b/matlab/panera22/genis3table.m

% Generate is3table from is2table, oos2table

function tableout = genis3table(is2table, oos2table, myfeatures, corrpwindow_size)

% is2table_weighted = weighttable(is2table) ;

% bvalues2 = trainnow(is2table_weighted, myfeatures);

% I Calculate predictions2 now:
% predictions2 = predictnow(oos2table, myfeatures, bvalues2);

% I cut my oos-data into this many pieces:
oospieces = 10
oospieces = 100

% predict_wide_oos() should be more effective than vanilla LR; why?
% Because it tries to keep gap between is-end and oos-start less than oos_chunk_length:
predictions2 = predict_wide_oos(is2table, oos2table, oospieces, myfeatures);

% prediction values are actually the last column of predictions2.
% Generate a feature I call corrp.
% It is running correlation between upprob1 and pct1hg.

tableout         = predictions2;
% Make it clear that I have just calculated initial predictions:
tableout.upprob1 = predictions2.upprob;

tableout.corrp = corrnonan(tableout.upprob1, predictions2.pct1hg, corrpwindow_size);

% done
