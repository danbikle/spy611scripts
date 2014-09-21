% /a/ks/b/matlab/panera22/predict_chunknow.m

% I use this function to predict a piece of oos data

% Demo:
% some_predictions = predict_chunknow(is_table2, oos_piece, myfeatures);

function some_predictions = predict_chunknow(is_table, oos_piece, myfeatures)

% Start by weighting the is data
is_table_weighted = weighttable(is_table);
mybvals = trainnow(is_table_weighted, myfeatures);
x_oos_t = oos_piece(:, myfeatures);
x_oos   = table2array(x_oos_t);
pihat   = mnrval(mybvals, x_oos);
some_predictions         = oos_piece;
some_predictions.upprob  = pihat(:,2);
