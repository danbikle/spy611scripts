% /a/ks/b/matlab/panera23/co_ip4yr.m

% I use this function to calculate about 250 predictions for a given
% year from 20 years of training data.

% Demo:
% ip20yr = table();
% for yr = (2013:2014)
%   ip20yr = vertcat(ip20yr, co_ip4yr(yr,spyv, myfeatures));
% end

function ip4yr = co_ip4yr(yr,spyv, myfeatures)

oos4yr = spyv( (spyv.ydate > datenum([yr 01 01]) & spyv.ydate <= datenum([yr 12 31]) ) , : );

is4yr = spyv( (spyv.ydate > datenum([yr-20 01 01]) & spyv.ydate <= datenum([yr-1 12 31]) ) , : );

ip4yr = prdct(is4yr, oos4yr, myfeatures);

% done
