% /a/ks/b/matlab/panera22/genis2table.m

% From is1table and predictions1 generate is2table:

% Demo:
% is2table = genis2table(is1table, is2_size, predictions1);

function tableout = genis2table(is1table, is2_size, predictions1)

% widetable = horzcat(is1table,predictions1);
% is2table = is1table(1:is2_size , : ) ;
tableout = table();
