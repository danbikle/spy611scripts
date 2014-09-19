% /a/ks/b/matlab/panera22/pspy.m

% I use this script to get recent prices and then issue predictions.

% spyall contains all the dates and prices I need to build vectors.

spyall = fill_spyall;

% Build some columns I want to use to build vectors.
% Get a copy of cp and shift it down 1 so lagging cp lines up with cp:
cplag1 = [spyall.cp(1) spyall.cp(1:end-1)' ]' ;

% These should match:
% spyall.cp(end-1)
% cplag1(end)

% thrice more
cplag2 = [spyall.cp(1) cplag1(1:end-1)' ]' ;
cplag3 = [spyall.cp(1) cplag2(1:end-1)' ]' ;
cplag4 = [spyall.cp(1) cplag3(1:end-1)' ]' ;

% Look at the end:
cplag4(end)
cplag3(end)
cplag2(end)
cplag1(end)
spyall.cp(end-6:end)

% Get a copy of cp and shift it up 1 so leading cp lines up with cp:
cplead = [spyall.cp(2:end)' NaN]' ;

spyv = spyall;
