% /a/ks/b/matlab/panera23/roundn.m

% Demo:
% rounded_to3rd_dec = roundn(3, 1.2345678)
% Should give:
% 1.235
function rndn = roundn(places,decin)
rndn = round(10^places * decin) / 10^places;
