% % /a/ks/b/matlab/panera26/btlr.m
% 
% % I use this script to backtest lr on GSPC
% 

% params:

is_rowcount   = 242;
is_rowcount_s = num2str(is_rowcount);
corrnfeat     = 'corrn09';
features      = {'n1dg1','n2dg1',corrnfeat};

% Use params to label results:

png1 = strcat('data/plot_ipall_rc', is_rowcount_s,'_',corrnfeat,'.png');
png2 = strcat('data/plot_ip2530_rc',is_rowcount_s,'_',corrnfeat,'.png');
csv1 = strcat('data/ip_rc',         is_rowcount_s,'_',corrnfeat,'.csv');

% startDate = datenum( [ 1950 1 1 ] );
% endDate = now;
% symbl = '^GSPC';
% freq = 'd';
% 
% % cp is closing-price:
% [ydate, cp, openp, lowp, highp, volume, closeadj] = StockQuoteQuery(symbl, startDate, endDate, freq);
% 
% dateprice = table();
% dateprice.ydatestr = datestr(ydate,'yyyy-mm-dd');
% dateprice.ydate    = ydate;
% dateprice.openp    = openp;
% dateprice.cp       = cp;
% 
% writetable(dateprice, 'data/dateprice.csv');

dateprice = readtable('data/dateprice.csv');

% Create vectors from dates and prices:

ccv = dateprice;

cp     = ccv.cp;
lag    = lagn(1,cp);
lag2   = lagn(2,cp);
lead   = leadn(1,cp);

n1dg1   = (cp-lag) ./ lag;
n2dg1   = (cp-lag2) ./ lag2;

n1dg2   = lagn(1,n1dg1);

corrn05 = cr_corrp(n1dg2, n1dg1,  5);
corrn06 = cr_corrp(n1dg2, n1dg1,  6);
corrn07 = cr_corrp(n1dg2, n1dg1,  7);
corrn08 = cr_corrp(n1dg2, n1dg1,  8);
corrn09 = cr_corrp(n1dg2, n1dg1,  9);

n1dg = (lead-cp) ./ cp;

yval = 1 + (n1dg > 0.0);

% past:
ccv.n1dg1   = n1dg1  ;
ccv.n1dg2   = n1dg2  ;
ccv.n2dg1   = n2dg1  ;
ccv.corrn05 = corrn05;
ccv.corrn06 = corrn06;
ccv.corrn07 = corrn07;
ccv.corrn08 = corrn08;
ccv.corrn09 = corrn09;

% future:
ccv.n1dg   = n1dg ;
ccv.yval   = yval ;
% Vectors now built, move on to collecting predictions.


% Initial place in the vectors I start collecting predictions:
ccv_start = is_rowcount + 2;
% That should be a date in the 1950s.

% The place in the vectors where I stop collecting predictions:
ccv_end    = length(ccv.ydate);
% That should be a date near today.

initial_predictions = table();

% Loop below needs 5 to 15 min depending on cpu:
for i = (ccv_start:ccv_end)
  is_data  = ccv(i-is_rowcount:i-2, : ) ;
  oos_data = ccv(i:i,               : ) ;
  a_prediction = prdct(is_data, oos_data, features);
  initial_predictions = vertcat( initial_predictions, a_prediction );
end

writetable(initial_predictions, 'data/ip.csv');
writetable(initial_predictions, csv1);

% Plot all predictions:

xy1 = readtable('data/ip.csv');

xy2 = table();
xy2.x = xy1.ydate;
xy2.y1 = xy1.cp;
xy2.upprob = xy1.upprob;
xy2.n1dg = xy1.n1dg;

xy2.zeros = zeros(length(xy2.y1),1);
xy2.ones  = ones(length(xy2.y1),1);

xy2.y2 = xy2.zeros;
xy2.y3 = xy2.zeros;
xy2.y4 = xy2.zeros;
xy2.y2(1) = xy2.y1(1);
xy2.y3(1) = xy2.y1(1);
xy2.y4(1) = xy2.y1(1);

% Loop below needs a few minutes:

for j=2:length(xy2.y2)
  i = j-1;

  if     xy2.upprob(i) > 0.5
    xy2.y2(j) = xy2.y2(i) * (1 + xy2.n1dg(i));
  elseif xy2.upprob(i) < 0.5
    xy2.y2(j) = xy2.y2(i) * (1 - xy2.n1dg(i));
  else
    xy2.y2(j) = xy2.y2(i) ;
  end

  if     xy2.upprob(i) > 0.51
    xy2.y3(j) = xy2.y3(i) * (1 + xy2.n1dg(i));
  elseif xy2.upprob(i) < 0.49
    xy2.y3(j) = xy2.y3(i) * (1 - xy2.n1dg(i));
  else
    xy2.y3(j) = xy2.y3(i) ;
  end

  if     xy2.upprob(i) > 0.52
    xy2.y4(j) = xy2.y4(i) * (1 + xy2.n1dg(i));
  elseif xy2.upprob(i) < 0.48
    xy2.y4(j) = xy2.y4(i) * (1 - xy2.n1dg(i));
  else
    xy2.y4(j) = xy2.y4(i) ;
  end

end;

myfhandle = figure;
plot( xy2.x, xy2.y1, 'black', xy2.x, xy2.y2, 'blue', xy2.x, xy2.y3, 'red', xy2.x, xy2.y4, 'cyan' );
datetick('x','yyyy-mm-dd'); grid on;

ylabel('S and P 500 (GSPC)');
legend( 'GSPC'...
  ,'GSPC(lt0.5,gt0.5)'   ...
  ,'GSPC(lt0.49,gt0.51)' ...
  ,'GSPC(lt0.48,gt0.52)' ...
  ,'Location', 'NorthWest');

print (myfhandle, '-dpng', png1);

% Look at previous 2530 observations:
xy1 = xy1(end-2530:end , :);

xy2 = table();
xy2.x = xy1.ydate;
xy2.y1 = xy1.cp;
xy2.upprob = xy1.upprob;
xy2.n1dg = xy1.n1dg;

xy2.zeros = zeros(length(xy2.y1),1);
xy2.ones  = ones(length(xy2.y1),1);

xy2.y2 = xy2.zeros;
xy2.y3 = xy2.zeros;
xy2.y4 = xy2.zeros;
xy2.y2(1) = xy2.y1(1);
xy2.y3(1) = xy2.y1(1);
xy2.y4(1) = xy2.y1(1);

for j=2:length(xy2.y2)
  i = j-1;

  if     xy2.upprob(i) > 0.5
    xy2.y2(j) = xy2.y2(i) * (1 + xy2.n1dg(i));
  elseif xy2.upprob(i) < 0.5
    xy2.y2(j) = xy2.y2(i) * (1 - xy2.n1dg(i));
  else
    xy2.y2(j) = xy2.y2(i) ;
  end

  if     xy2.upprob(i) > 0.51
    xy2.y3(j) = xy2.y3(i) * (1 + xy2.n1dg(i));
  elseif xy2.upprob(i) < 0.49
    xy2.y3(j) = xy2.y3(i) * (1 - xy2.n1dg(i));
  else
    xy2.y3(j) = xy2.y3(i) ;
  end

  if     xy2.upprob(i) > 0.52
    xy2.y4(j) = xy2.y4(i) * (1 + xy2.n1dg(i));
  elseif xy2.upprob(i) < 0.48
    xy2.y4(j) = xy2.y4(i) * (1 - xy2.n1dg(i));
  else
    xy2.y4(j) = xy2.y4(i) ;
  end

end;

% Avoid overlays:
xy2.y2 = xy2.y2 +1;
xy2.y3 = xy2.y3 -1;
xy2.y4 = xy2.y4 -2;

myfhandle = figure;
plot( xy2.x, xy2.y1, 'black', xy2.x, xy2.y2, 'blue', xy2.x, xy2.y3, 'red', xy2.x, xy2.y4, 'green' );
datetick('x','yyyy-mm-dd'); grid on;

ylabel('S and P 500 (GSPC)');
legend( 'GSPC'...
  ,'GSPC(lt0.5,gt0.5)'   ...
  ,'GSPC(lt0.49,gt0.51)' ...
  ,'GSPC(lt0.48,gt0.52)' ...
  ,'Location', 'NorthWest');

print (myfhandle, '-dpng', png2);

'done'

