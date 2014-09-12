% Derived from:
% http://compgroups.net/comp.soft-sys.matlab/rolling-correlation/409194

function RC = rollingcorr(myx, myy, window)
cmat = [myx myy]; % Create correlation matrix
RC = size(window:length(cmat)); % Pre-allocate matrix to hold the rolling correlation

for i = window:length(cmat) 
    matx = cmat(i-window+1:i,1:2); % Trying to make moving 5x2 matrix from cmat
    matxc = corrcoef(matx); % 2x2 Correlation matrix
    RC(i) = matxc(1,2); % Pull out xy correlation value
end
