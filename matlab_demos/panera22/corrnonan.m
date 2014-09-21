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
while ( x2 <= length(myx))
  shortx = myx(x1:x2);
  shorty = myy(x1:x2);
  myrcorr(x2) = corr(shortx, shorty);
  if(isnan(myrcorr(x2)))
    % If I get NaN, just use the previous val:
    myrcorr(x2) = myrcorr(x2-1)
  end
  x1 = x1 + 1;
  x2 = x2 + 1;
end

% I need a vertical vector:
myrcorr = myrcorr';

% done
