% /a/ks/b/matlab/panera22/nonan.m

% I want to remove NaN from my vector.

% Demo: 
% vctr = [1 2 3 NaN]
% vctr2 = nonan(vctr)

function vecout = nonan(vecin)
vecout = vecin(not(isnan(vecin)))
