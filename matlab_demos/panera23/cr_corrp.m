% /a/ks/b/matlab/panera23/cr_corrp.m

% I use this function to calculate rolling correlation between upprob1 and pctg.
% I use the result as a feature in LR.

% Demo:
% corrp_rowcount = 9;
% isdata2.corrp = cr_corrp(upprob, pctg, corrp_rowcount);

% corrp_rowcount tells cr_corrp() number of rows to look backwards during calls to corr():

function corrp = cr_corrp(myx, myy, wndw)

% If wndw size > myx size that is an error of the api-user.
% I deal with that by returning an array of zeros.
if(wndw > length(myx))
  corrp = zeros(length(myx),1);
  return
end

corrp = [];

% x1 is left window boundry.
% x2 is right window boundry.
x1 = 1;
x2 = x1+wndw-1;
coffset = 1;
% I use coffset to shorten corr-vec back in time by 1 observation.
% The very last observation will correspond to NaN-pctg.
% So, I cant use the last observation in any short vectors.
while ( x2 <= length(myx))
  x2off = x2 - coffset;
  shortx = myx(x1:x2off);
  shorty = myy(x1:x2off);
  if(length(shortx > 2))
    corrp(x2) = corr(shortx, shorty);
  else
    corrp(x2) = 0;
  end
  if(isnan(corrp(x2)))
    % If I get NaN, just use the previous val:
    corrp(x2) = corrp(x2-1);
  end
  x1 = x1 + 1;
  x2 = x2 + 1;
end

% I need a vertical vector:
corrp = corrp';

% done

