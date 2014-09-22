% /a/ks/b/matlab/panera22/corrnonan.m

% I use this function to calculate running correlation on 2 vectors where
% last value of pct1hg is a NaN.

function myrcorr = corrnonan(myx, myy, wndw)

% If wndw size > myx size that is an error of the api-user.
% I deal with that by returning an array of zeros.
if(wndw > length(myx))
  myrcorr = zeros(length(myx),1);
  return
end

myrcorr = [];

% x1 is left window boundry.
% x2 is right window boundry.
x1 = 1;
x2 = x1+wndw-1;
coffset = 2;
% I use coffset to shorten corr-vec back in time by 2 observations.
% The very last 2 observations will correspond to NaN-pct1hg.
% So, I cant use the last 2 observations in any short vectors.
while ( x2 <= length(myx))
  x2off = x2 - coffset;
  shortx = myx(x1:x2off);
  shorty = myy(x1:x2off);
  if(length(shortx > 2))
    myrcorr(x2) = corr(shortx, shorty);
  else
    myrcorr(x2) = 0;
  end
  if(isnan(myrcorr(x2)))
    % If I get NaN, just use the previous val:
    myrcorr(x2) = myrcorr(x2-1);
  end
  x1 = x1 + 1;
  x2 = x2 + 1;
end

% I need a vertical vector:
myrcorr = myrcorr';

% done
