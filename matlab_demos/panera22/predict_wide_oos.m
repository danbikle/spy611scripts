% /a/ks/b/matlab/panera22/predict_wide_oos.m

% I use this function to predict a wide oos range.
% I do it in a series of steps to keep the is-data near the oos-data.

% Suppose I have an oos range of 10,000 observations.

% And before that, I have an is-range of 10,000 observations.

% I might want to divide the oos-data into 100 pieces.
% After I finish predicting the 1st piece,
% I could nudge the is-data forward to maintain the small gap between is-data ans oos-data.
% Then I could predict the 2nd piece.
% So, I could use a loop to keep nudging the is-data forward as I 
% predict the oos-data piece by piece.

% To do that with this function, I'd make an api-call like this:

% oospieces = 100
% predictions10k = predict_wide_oos(is_table, oos_table, oospieces, myfeatures);

function predictions_out = predict_wide_oos(is_table, oos_table, oospieces, myfeatures)
predictions_out  = table();
is_table_length  = rowcount(is_table)
oos_table_length = rowcount(oos_table)

allobs = vertcat(is_table, oos_table);

% Keep track of each oos_chunk.
chunk_length = round(rowcount(oos_table)/oospieces)
oos_chunki   = 1

while( oos_chunki < oos_table_length)
  is_table2        = allobs(oos_chunki:is_table_length+oos_chunki-1, :);
  oos_piece        = oos_table(oos_chunki:chunk_length+oos_chunki-1, :);
  some_predictions = predict_chunknow(is_table2, oos_piece, myfeatures);
  predictions_out  = vertcat(predictions_out , some_predictions);
  oos_chunki       = oos_chunki + chunk_length
end

% After I call predict_wide_oos(),
% I should check that oos_table matches
% oos_table inside of predictions_out.



