% /a/ks/b/matlab/panera22/predictnow.m

% I use this function to generate predictions from oos-data, feature-names, and bvalues.

% Demo:
% [istable, oostable] = genisoos(spyv, boundry_date, is_size, oos_size);
% 
% myfeatures = {...
% 'timegap1' ...
% ,'cpma'	   ...
% ,'nlag4'   ...
% ,'nlag3'   ...
% ,'nlag2'   ...
% ,'nlag1'   ...
% }
% 
% mybvalues = trainnow(istable, myfeatures)
% 
% mypredictions = predictnow(oostable, myfeatures, mybvalues);

function tableout = predictnow(oostable, myfeatures, mybvalues)

x_oos_t = oostable(:, myfeatures);
x_oos   = table2array(x_oos_t);
pihat   = mnrval(mybvalues, x_oos);

tableout           = table();
tableout.cpdatestr = oostable.datestr2;
tableout.cp        = oostable.cp;
tableout.upprob    = pihat(:,2);
tableout.pct1hg    = oostable.pct1hg;

%done


