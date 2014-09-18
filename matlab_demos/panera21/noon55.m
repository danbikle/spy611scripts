% /a/ks/b/matlab/panera21/noon55.m

% I Accept an estimate of today's closing
% price and then predict tomorrow's closing price.
% I intend to run noon55.m at 12:55 California time which is 5 minutes before market close.
% I want noon55.m to give me a prediction by 12:58 so have 2 minutes to act on it.

% Start by getting latest available data from yahoo:

cp_startDate = datenum( [ 1950 1 1 ] )

cp_endDate = now

symbl = '^GSPC'

freq = 'd'

% cp is closing-price:
[ydate, cp, openp, lowp, highp, volume, closeadj] = StockQuoteQuery( symbl, cp_startDate, cp_endDate, freq);

% I intend for operator to edit file named noon55price.m
% Now, run that file to pull in the variables: noon55_price, noon55_date.
noon55price

% Rebuild myvectors now that I have 1 more observation.
if(noon55_date > ydate(end))
  ydate = [ydate' noon55_date ]';
  cp    = [cp'    noon55_price]';
end

% Compare a vector from StockQuoteQuery, lowp, to both ydate and cp.
% They should both be 1-larger than lowp:
size_lowp = size(lowp)
size_ydate = size(ydate)
size_cp      = size(cp)

% Here is another check.
% I want to see todays date.
% I want to see my estimate of todays closing price:
ydatestr_end = datestr(ydate(end))
cp_end       = cp(end)

% Create vectors I will use to build both in-sample and oos data to
% then calculate initial predictions for the last 20 observations:

cr_myvectors

% Establish some boundries appropriate for noon55 knowing that I did a bunch of
% number crunching this morning to collect initial predictions through last year.

is_startDate2 = datenum( [1989 1 1])
% 20 trading days ago:
is_endDate2   = myvectors.ydate(end - 20)

is_range2     =  find(myvectors.ydate >= is_startDate2 & myvectors.ydate <= is_endDate2);

% Later I intend to predict observations in oos_range:
oos_range2    =  find(myvectors.ydate > is_endDate2)

% Begin effort to train using data in is_range2.

% Start by collecting and weighting in-sample data:

is_start  = is_range2(1)
is_end    = is_range2(end)

is_data_noon55_w0 = myvectors(is_start:is_end, :)   ;

% String format of date is convenient when I look at the data:
is_data_noon55_w0.ydatestr = datestr(is_data_noon55_w0.ydate,'yyyy-mm-dd') ;
            
% Add weights to in-sample data

is_data_noon55_w1 = is_data_noon55_w0(end-1*251:end, : )   ;
is_data_noon55_w2 = is_data_noon55_w0(end-2*251:end, : )   ;
is_data_noon55_w3 = is_data_noon55_w0(end-3*251:end, : )   ;
is_data_noon55_w4 = is_data_noon55_w0(end-4*251:end, : )   ;
is_data_noon55_w5 = is_data_noon55_w0(end-5*251:end, : )   ;
is_data_noon55_w10 = is_data_noon55_w0(end-10*251:end, : ) ;
is_data_noon55_w15 = is_data_noon55_w0(end-15*251:end, : ) ;
is_data_noon55_w20 = is_data_noon55_w0(end-20*251:end, : ) ;

is_data_noon55 = vertcat(is_data_noon55_w0, ... 
  is_data_noon55_w1, ... 
  is_data_noon55_w2, ... 
  is_data_noon55_w3, ... 
  is_data_noon55_w4, ... 
  is_data_noon55_w5, ... 
  is_data_noon55_w10, ... 
  is_data_noon55_w15, ... 
  is_data_noon55_w20);

% I like a table here so I can see the data:
x_is_noon55_t = is_data_noon55(:,{...
'cpma'     ...
,'n1dg1'   ...
,'n1dg2'   ...
,'n1dg3'   ...
,'n2dlagd' ... 
,'n1wlagd' ... 
,'n2wlagd' ... 
,'n1mlagd' ... 
,'n2mlagd' ...
});

% mnrfit() wants an array not a table:
x_is_noon55 = table2array(x_is_noon55_t);

yvalue1d_is = table2array(is_data_noon55(:,{'yvalue1d'}));
yvalue2d_is = table2array(is_data_noon55(:,{'yvalue2d'}));
yvalue1w_is = table2array(is_data_noon55(:,{'yvalue1w'}));

% train!

bvals1d = mnrfit(x_is_noon55, yvalue1d_is)
bvals2d = mnrfit(x_is_noon55, yvalue2d_is)
bvals1w = mnrfit(x_is_noon55, yvalue1w_is)

% trained.
                   
% Now work towards predicting the last 20 observations.
% I want to eventually feed the 20 predictions to lr2lr.

oos_start = oos_range2(1)
oos_end   = oos_range2(end)

oos_data_noon55 = myvectors(oos_start:oos_end, : )   ;
oos_data_noon55.ydatestr = datestr(oos_data_noon55.ydate, 'yyyy-mm-dd');


% Build a table here so I can see the data I want to pass to mnrval():
x_oos_noon55_t = oos_data_noon55(:,{...
'cpma'     ...
,'n1dg1'   ...
,'n1dg2'   ...
,'n1dg3'   ...
,'n2dlagd' ... 
,'n1wlagd' ... 
,'n2wlagd' ... 
,'n1mlagd' ... 
,'n2mlagd' ...
});

% mnrval() wants array not table:
x_oos_noon55 = table2array(x_oos_noon55_t);

% I should see about 20 rows here:
size_x_oos_noon55 = size(x_oos_noon55)

% predict !

pihat1d = mnrval(bvals1d, x_oos_noon55);
pihat2d = mnrval(bvals2d, x_oos_noon55);
pihat1w = mnrval(bvals1w, x_oos_noon55);

oos_data_noon55.prob_1d = pihat1d(:,2);
oos_data_noon55.prob_2d = pihat2d(:,2);
oos_data_noon55.prob_1w = pihat1w(:,2);

% Get data from morning.m when it was run this morn:
ip25yr    = readtable('ip25yr.csv');
% Workaround matlab-bug:
ip25yr.ydatestr = datestr(ip25yr.ydate, 'yyyy-mm-dd');

% Merge my 20 new predictions with data from this morning.

noon55_oos_start_date = min(oos_data_noon55.ydate)

% DELETE ip25yr WHERE ip25yr.ydate >= noon55_oos_start_date
ip25yr( ( ip25yr.ydate >= noon55_oos_start_date ), : ) = []; 

% I need to matchup the columns from both tables.
% I have fewer columns in oos_data_noon55 so I use them:
mycols = oos_data_noon55.Properties.VariableNames;

% Line up ip25yr columns with oos_data_noon55 columns:
toptbl = ip25yr(:,{...
'ydate'    ...
,'ydatestr'...
,'cpma'    ...
,'n1dg1'   ...
,'n1dg2'   ...
,'n1dg3'   ...
,'n2dlagd' ... 
,'n1wlagd' ... 
,'n2wlagd' ... 
,'n1mlagd' ... 
,'n2mlagd' ...
,'prob_1d' ...
,'prob_2d' ...
,'prob_1w' ...
,'n1dg'   ...
,'n2dg'   ...
,'n1wg'   ...
,'yvalue1d' ...
,'yvalue2d' ...
,'yvalue1w' ...
});

bottomtbl = oos_data_noon55(:,{...
'ydate'    ...
,'ydatestr'...
,'cpma'    ...
,'n1dg1'   ...
,'n1dg2'   ...
,'n1dg3'   ...
,'n2dlagd' ... 
,'n1wlagd' ... 
,'n2wlagd' ... 
,'n1mlagd' ... 
,'n2mlagd' ...
,'prob_1d' ...
,'prob_2d' ...
,'prob_1w' ...
,'n1dg'   ...
,'n2dg'   ...
,'n1wg'   ...
,'yvalue1d' ...
,'yvalue2d' ...
,'yvalue1w' ...
});


% I do the merge here:
ip_noon55 = vertcat(toptbl, bottomtbl);

% Calculate rolling_corr values for initial-predictions vs n1dg, n2dg, and n1wg

% I want a window on the last 100 days for each observation:
wndw = 100

corr1d = rollingcorr(ip_noon55.prob_1d, ip_noon55.n1dg, wndw)';
corr2d = rollingcorr(ip_noon55.prob_2d, ip_noon55.n2dg, wndw)';
corr1w = rollingcorr(ip_noon55.prob_1w, ip_noon55.n1wg, wndw)';

% Deal with NaNs at ends:
corr1d(end) = corr1d(end-1);

corr2d(end) = corr2d(end-2);
corr2d(end-1) = corr2d(end-2);

corr1w(end) = corr1w(end-5);
corr1w(end-1) = corr1w(end-5);
corr1w(end-2) = corr1w(end-5);
corr1w(end-3) = corr1w(end-5);
corr1w(end-4) = corr1w(end-5);

% ip_noon55 keeps getting wider:
ip_noon55.corr1d = corr1d;
ip_noon55.corr2d = corr2d;
ip_noon55.corr1w = corr1w;

size_ip_noon55 = size(ip_noon55)

% I now have the data I need to do final predictions on the last 20
% observations which includes today's estimated closing price.

% Create enhanced training data for 2014 from 9 original features and rolling_corr values
cr_x_is_noon55_enh

% train!

bvals1d = mnrfit(x_is_noon55_enh, yvalue1d_is)
bvals2d = mnrfit(x_is_noon55_enh, yvalue2d_is)
bvals1w = mnrfit(x_is_noon55_enh, yvalue1w_is)

% Now work towards predicting the last 20 observations.


oos_start = is_end + 1

oos_data_noon55_enh = ip_noon55(oos_start:end,:);

x_oos_noon55_enh_t = oos_data_noon55_enh(:,{...
'cpma'     ...
,'n1dg1'   ...
,'n1dg2'   ...
,'n1dg3'   ...
,'n2dlagd' ... 
,'n1wlagd' ... 
,'n2wlagd' ... 
,'n1mlagd' ... 
,'n2mlagd' ...
,'prob_1d' ...
,'prob_2d' ...
,'prob_1w' ...
,'corr1d'  ...
,'corr2d'  ...
,'corr1w'  ...
});

x_oos_noon55_enh = table2array(x_oos_noon55_enh_t)

% predict !

pihat1d = mnrval(bvals1d, x_oos_noon55_enh);
pihat2d = mnrval(bvals2d, x_oos_noon55_enh);
pihat1w = mnrval(bvals1w, x_oos_noon55_enh);

noon55predictions = table();

noon55predictions.iprob_1d = x_oos_noon55_enh_t.prob_1d;
noon55predictions.iprob_2d = x_oos_noon55_enh_t.prob_2d;
noon55predictions.iprob_1w = x_oos_noon55_enh_t.prob_1w;

noon55predictions.corr1d = x_oos_noon55_enh_t.corr1d;
noon55predictions.corr2d = x_oos_noon55_enh_t.corr2d;
noon55predictions.corr1w = x_oos_noon55_enh_t.corr1w;

noon55predictions.fprob_1d = pihat1d(:, 2);
noon55predictions.fprob_2d = pihat2d(:, 2);
noon55predictions.fprob_1w = pihat1w(:, 2);

noon55predictions.ydatestr = oos_data_noon55_enh.ydatestr;
noon55predictions.n1dg     = oos_data_noon55_enh.n1dg;
noon55predictions.n2dg     = oos_data_noon55_enh.n2dg;
noon55predictions.n1wg     = oos_data_noon55_enh.n1wg;

% Report:
noon55predictions

% done
