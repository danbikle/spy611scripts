% /a/ks/b/matlab/panera23/lagn.m

% I use this function to shift a vector forward by n spaces.
% The resulting gap at the front,
% is filled with copies of vec(1:n).
% The n elements at the end are lost.

% Demo:
% vec1 = [ 1 2 3 4 5 6 7]'
% vec2 = lagn(2,vec1);
% vec2 should be:
% [1 2 1 2 3 4 5]'

function vec2 = lagn(n,vec1)
vec2 = [vec1(1:n)' vec1(1:end-n)']';



