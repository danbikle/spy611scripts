% I use this funcion to calculate a rolling-correlation of 2 vectors.

% Demo:
% 
% demox = [1 2 3 4 5]'
% demoy = [1 2 3 2.2 3.3]'
% demowindow = 3
% myrollcorr = rollingcorr(demox, demoy, demowindow)
% I should see:
% myrollcorr =
%        0         0    1.0000    0.1890    0.2638

function myrcorr = rollingcorr(myx, myy, window)
% assume length(myx) <= length(myy)

% I return this:
myrcorr = [];

% x1 is left window boundry.
% x2 is right window boundry.
x1 = 1;
x2 = x1+window-1;
while ( x2 <= length(myx))
  shortx = myx(x1:x2);
  shorty = myy(x1:x2);
  myrcorr(x2) = corr(shortx, shorty);
  x1 = x1 + 1;
  x2 = x2 + 1;
end
