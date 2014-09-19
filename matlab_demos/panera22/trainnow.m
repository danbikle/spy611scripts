% /a/ks/b/matlab/panera22/trainnow.m

% I use this function to calculate Logistic Regression b-values from in-sample-data in a table.
% This is AKA training and AKA fitting.

% Demo:
% mybvalues = trainnow(istable, myfeatures);

function bvec = trainnow(tablein, myfeatures)

x_is_t = tablein(:, myfeatures);

y_is_t = tablein(:,{'yval'});

x_is = table2array(x_is_t);
y_is = table2array(y_is_t);

bvec = mnrfit(x_is, y_is);



