% /a/ks/b/matlab/panera26/spy611study.m

spy611 = readtable('data/spy611.2014-10-09.csv');

% convert datatype of column named algo from cell to categorical:
spy611.algo = categorical(spy611.algo);

% Now I can use algo column:
lr2lr  = spy611((spy611.algo == 'lr2lr'), {'algo','close_price_date','prediction'});
gbm2lr = spy611((spy611.algo == 'gbm2lr'),{'algo','close_price_date','prediction'});

p26 = readtable('data/ip_rc242_corrn05.csv');

p26 = p26(:, {'ydatestr','ydate','cp','n1dg','upprob'});

% get some better names for my variables:

lr2lr.ydate    = datenum(lr2lr.close_price_date,'yyyy-mm-dd');
lr2lr.upprob_l = lr2lr.prediction;

gbm2lr.ydate    = datenum(gbm2lr.close_price_date,'yyyy-mm-dd');
gbm2lr.upprob_g = gbm2lr.prediction;

p26.upprob_p   = p26.upprob;

% Now join them on ydate to make comparisong easier:

joint1 = innerjoin(lr2lr, p26);
joint2 = joint1(:, {'upprob_l','upprob_p','ydatestr','ydate','cp','n1dg'});
joint3 = innerjoin(joint2, gbm2lr);
joint  = joint3(:, {'upprob_l','upprob_g','upprob_p','ydatestr','ydate','cp','n1dg'});

% Plot all predictions:

xy2 = joint;

xy2.x  = xy2.ydate;
xy2.y1 = xy2.cp;

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

  if     xy2.upprob_l(i) > 0.5
    xy2.y2(j) = xy2.y2(i) * (1 + xy2.n1dg(i));
  elseif xy2.upprob_l(i) < 0.5
    xy2.y2(j) = xy2.y2(i) * (1 - xy2.n1dg(i));
  else
    xy2.y2(j) = xy2.y2(i) ;
  end

  if     xy2.upprob_g(i) > 0.5
    xy2.y3(j) = xy2.y3(i) * (1 + xy2.n1dg(i));
  elseif xy2.upprob_g(i) < 0.5
    xy2.y3(j) = xy2.y3(i) * (1 - xy2.n1dg(i));
  else
    xy2.y3(j) = xy2.y3(i) ;
  end

  if     xy2.upprob_p(i) > 0.5
    xy2.y4(j) = xy2.y4(i) * (1 + xy2.n1dg(i));
  elseif xy2.upprob_p(i) < 0.5
    xy2.y4(j) = xy2.y4(i) * (1 - xy2.n1dg(i));
  else
    xy2.y4(j) = xy2.y4(i) ;
  end

end

myfhandle = figure;
plot( xy2.x, xy2.y1, 'black', xy2.x, xy2.y2, 'blue', xy2.x, xy2.y3, 'red', xy2.x, xy2.y4, 'green');
datetick('x','yyyy-mm-dd'); grid on;


ylabel('S and P 500 (GSPC)');
legend( 'GSPC'           ...
  ,'GSPC(spy611 lr2lr)'  ...
  ,'GSPC(spy611 gbm2lr)' ...
  ,'GSPC(panera26)'      ...
  ,'Location', 'NorthWest');

print (myfhandle, '-dpng', 'data/spy611study.png');


'done'
