% /a/ks/b/matlab/panera22/weighttable.m

% I use this function to help me create a weighted is-table.
% Demo:
% is2table_weighted = weighttable(is2table);

function tableout = weighttable(tablein)

% I want rowcount of table
rcount = rowcount(tablein);

wcount = round(rcount/4)-1;

w1 = tablein(end-1*wcount:end, : );
w2 = tablein(end-2*wcount:end, : );
w3 = tablein(end-3*wcount:end, : );
w4 = tablein(end-4*wcount:end, : );

tableout = vertcat(tablein,w1,w2,w3,w4);

% done
