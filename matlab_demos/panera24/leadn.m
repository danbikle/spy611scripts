% /a/ks/b/matlab/panera24/leadn.m

% I use this function to shift a vector backward by n spaces.
% The resulting gap at the end,
% is filled with copies of vec(end-n+1:end)
% The n elements at the front are lost.

% Demo:
% vec1 = [ 1 2 3 4 5 6 7]'
% vec2 = leadn(2,vec1);
% vec2 should be:
% [3 4 5 6 7 6 7]'

function vec2 = leadn(n,vec1)
vec2 = [vec1(n+1:end)' vec1(end-n+1:end)']';



