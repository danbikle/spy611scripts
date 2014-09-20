% /a/ks/b/matlab/panera22/corrnonan.m

% I use this function to calculate running correlation on 2 vectors where
% last value of pct1hg is a NaN.

function myrcorr = corrnonan(myx, myy, wndw)
myrcorr = [];

% x1 is left window boundry.
% x2 is right window boundry.
x1 = 1;
x2 = x1+wndw-1;
while ( x2 <= length(myx))
  shortx = myx(x1:x2);
  shorty = myy(x1:x2);
  myrcorr(x2) = corr(shortx, shorty);
  x1 = x1 + 1;
  x2 = x2 + 1;
end
% Assume last value of myrcorr is NaN.
% The value before is good enough:
myrcorr(end) = myrcorr(end-1);

% I need a vertical vector:
myrcorr = myrcorr';

% done
