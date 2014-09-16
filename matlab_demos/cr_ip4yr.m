% /a/ks/b/matlab/cr_ip4yr.m

% I use this function to calculate initial LR-predictions for a specific year.

% Demo:
%
% ip4yr1989 = cr_ip4yr(1989, myvectors)
% I should see a vector with about 250 elements. Each is between 0.3 and 0.7.

function ip4yr = cr_ip4yr(yr, myvectors)
ip4yr = table();
% assume yr is integer like 1989 

% I want my training data to span from 25 years ago to 10 days before oos_startDate
% I want my out-of-sample data to span from oos_startDate to oos_endDate

is_startDate = datenum( [ yr-26 12 21])
is_endDate   = datenum( [ yr-1  12 21])

oos_startDate = datenum( [ yr 1 1 ])
oos_endDate   = datenum( [ yr 12 31 ])

% find() index-ranges for both is-data, oos-data:
is_range =  find(myvectors.ydate >= is_startDate & myvectors.ydate <= is_endDate);
oos_range = find(myvectors.ydate >= oos_startDate & myvectors.ydate <= oos_endDate);

is_start  = is_range(1)
is_end    = is_range(end)

oos_start = oos_range(1)
oos_end   = oos_range(end)

is_data0 = table();
is_data0.ydate    = myvectors.ydate(is_start:is_end)   ;
is_data0.ydatestr = datestr(myvectors.ydate(is_start:is_end),'yyyy-mm-dd')   ;
is_data0.cpma     = myvectors.cpma(is_start:is_end)    ;
is_data0.n1dg1    = myvectors.n1dg1(is_start:is_end)   ;
is_data0.n1dg2    = myvectors.n1dg2(is_start:is_end)   ;
is_data0.n1dg3    = myvectors.n1dg3(is_start:is_end)   ;
is_data0.n2dlagd  = myvectors.n2dlagd(is_start:is_end) ;
is_data0.n1wlagd  = myvectors.n1wlagd(is_start:is_end) ;
is_data0.n2wlagd  = myvectors.n2wlagd(is_start:is_end) ;
is_data0.n1mlagd  = myvectors.n1mlagd(is_start:is_end) ;
is_data0.n2mlagd  = myvectors.n2mlagd(is_start:is_end) ;
is_data0.yvalue1d = myvectors.yvalue1d(is_start:is_end);
is_data0.yvalue2d = myvectors.yvalue2d(is_start:is_end);
is_data0.yvalue1w = myvectors.yvalue1w(is_start:is_end);
                                                                 
% Add weights to in-sample data

is_data_w5 = table();
is_data_w5.ydate    = myvectors.ydate(is_end-5*251:is_end)   ;
is_data_w5.ydatestr = datestr(myvectors.ydate(is_end-5*251:is_end),'yyyy-mm-dd');
is_data_w5.cpma     = myvectors.cpma(is_end-5*251:is_end)    ;
is_data_w5.n1dg1    = myvectors.n1dg1(is_end-5*251:is_end)   ;
is_data_w5.n1dg2    = myvectors.n1dg2(is_end-5*251:is_end)   ;
is_data_w5.n1dg3    = myvectors.n1dg3(is_end-5*251:is_end)   ;
is_data_w5.n2dlagd  = myvectors.n2dlagd(is_end-5*251:is_end) ;
is_data_w5.n1wlagd  = myvectors.n1wlagd(is_end-5*251:is_end) ;
is_data_w5.n2wlagd  = myvectors.n2wlagd(is_end-5*251:is_end) ;
is_data_w5.n1mlagd  = myvectors.n1mlagd(is_end-5*251:is_end) ;
is_data_w5.n2mlagd  = myvectors.n2mlagd(is_end-5*251:is_end) ;
is_data_w5.yvalue1d = myvectors.yvalue1d(is_end-5*251:is_end);
is_data_w5.yvalue2d = myvectors.yvalue2d(is_end-5*251:is_end);
is_data_w5.yvalue1w = myvectors.yvalue1w(is_end-5*251:is_end);
                                
is_data_w10 = table();
is_data_w10.ydate    = myvectors.ydate(is_end-10*251:is_end)   ;
is_data_w10.ydatestr = datestr(myvectors.ydate(is_end-10*251:is_end),'yyyy-mm-dd');
is_data_w10.cpma     = myvectors.cpma(is_end-10*251:is_end)    ;
is_data_w10.n1dg1    = myvectors.n1dg1(is_end-10*251:is_end)   ;
is_data_w10.n1dg2    = myvectors.n1dg2(is_end-10*251:is_end)   ;
is_data_w10.n1dg3    = myvectors.n1dg3(is_end-10*251:is_end)   ;
is_data_w10.n2dlagd  = myvectors.n2dlagd(is_end-10*251:is_end) ;
is_data_w10.n1wlagd  = myvectors.n1wlagd(is_end-10*251:is_end) ;
is_data_w10.n2wlagd  = myvectors.n2wlagd(is_end-10*251:is_end) ;
is_data_w10.n1mlagd  = myvectors.n1mlagd(is_end-10*251:is_end) ;
is_data_w10.n2mlagd  = myvectors.n2mlagd(is_end-10*251:is_end) ;
is_data_w10.yvalue1d = myvectors.yvalue1d(is_end-10*251:is_end);
is_data_w10.yvalue2d = myvectors.yvalue2d(is_end-10*251:is_end);
is_data_w10.yvalue1w = myvectors.yvalue1w(is_end-10*251:is_end);

is_data_w15 = table();
is_data_w15.ydate    = myvectors.ydate(is_end-15*251:is_end)   ;
is_data_w15.ydatestr = datestr(myvectors.ydate(is_end-15*251:is_end),'yyyy-mm-dd');
is_data_w15.cpma     = myvectors.cpma(is_end-15*251:is_end)    ;
is_data_w15.n1dg1    = myvectors.n1dg1(is_end-15*251:is_end)   ;
is_data_w15.n1dg2    = myvectors.n1dg2(is_end-15*251:is_end)   ;
is_data_w15.n1dg3    = myvectors.n1dg3(is_end-15*251:is_end)   ;
is_data_w15.n2dlagd  = myvectors.n2dlagd(is_end-15*251:is_end) ;
is_data_w15.n1wlagd  = myvectors.n1wlagd(is_end-15*251:is_end) ;
is_data_w15.n2wlagd  = myvectors.n2wlagd(is_end-15*251:is_end) ;
is_data_w15.n1mlagd  = myvectors.n1mlagd(is_end-15*251:is_end) ;
is_data_w15.n2mlagd  = myvectors.n2mlagd(is_end-15*251:is_end) ;
is_data_w15.yvalue1d = myvectors.yvalue1d(is_end-15*251:is_end);
is_data_w15.yvalue2d = myvectors.yvalue2d(is_end-15*251:is_end);
is_data_w15.yvalue1w = myvectors.yvalue1w(is_end-15*251:is_end);

is_data_w20 = table();
is_data_w20.ydate    = myvectors.ydate(is_end-20*251:is_end)   ;
is_data_w20.ydatestr = datestr(myvectors.ydate(is_end-20*251:is_end),'yyyy-mm-dd');
is_data_w20.cpma     = myvectors.cpma(is_end-20*251:is_end)    ;
is_data_w20.n1dg1    = myvectors.n1dg1(is_end-20*251:is_end)   ;
is_data_w20.n1dg2    = myvectors.n1dg2(is_end-20*251:is_end)   ;
is_data_w20.n1dg3    = myvectors.n1dg3(is_end-20*251:is_end)   ;
is_data_w20.n2dlagd  = myvectors.n2dlagd(is_end-20*251:is_end) ;
is_data_w20.n1wlagd  = myvectors.n1wlagd(is_end-20*251:is_end) ;
is_data_w20.n2wlagd  = myvectors.n2wlagd(is_end-20*251:is_end) ;
is_data_w20.n1mlagd  = myvectors.n1mlagd(is_end-20*251:is_end) ;
is_data_w20.n2mlagd  = myvectors.n2mlagd(is_end-20*251:is_end) ;
is_data_w20.yvalue1d = myvectors.yvalue1d(is_end-20*251:is_end);
is_data_w20.yvalue2d = myvectors.yvalue2d(is_end-20*251:is_end);
is_data_w20.yvalue1w = myvectors.yvalue1w(is_end-20*251:is_end);
                                
is_data = vertcat(is_data0, ... 
  is_data_w5, ... 
  is_data_w10, ... 
  is_data_w15, ... 
  is_data_w20);

% I like a table here so I can see the data:
x_is_t = is_data(:,{...
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
x_is = table2array(x_is_t);

yvalue1d_is = table2array(is_data(:,{'yvalue1d'}));
yvalue2d_is = table2array(is_data(:,{'yvalue2d'}));
yvalue1w_is = table2array(is_data(:,{'yvalue1w'}));

% train!

bvals1d = mnrfit(x_is, yvalue1d_is)
bvals2d = mnrfit(x_is, yvalue2d_is)
bvals1w = mnrfit(x_is, yvalue1w_is)

% trained.

oos_data = table();
oos_data.ydate    = myvectors.ydate(oos_start:oos_end)   ;
oos_data.ydatestr = datestr(myvectors.ydate(oos_start:oos_end),'yyyy-mm-dd') ;
oos_data.cpma     = myvectors.cpma(oos_start:oos_end)    ;
oos_data.n1dg1    = myvectors.n1dg1(oos_start:oos_end)   ;
oos_data.n1dg2    = myvectors.n1dg2(oos_start:oos_end)   ;
oos_data.n1dg3    = myvectors.n1dg3(oos_start:oos_end)   ;
oos_data.n2dlagd  = myvectors.n2dlagd(oos_start:oos_end) ;
oos_data.n1wlagd  = myvectors.n1wlagd(oos_start:oos_end) ;
oos_data.n2wlagd  = myvectors.n2wlagd(oos_start:oos_end) ;
oos_data.n1mlagd  = myvectors.n1mlagd(oos_start:oos_end) ;
oos_data.n2mlagd  = myvectors.n2mlagd(oos_start:oos_end) ;
oos_data.yvalue1d = myvectors.yvalue1d(oos_start:oos_end);
oos_data.yvalue2d = myvectors.yvalue2d(oos_start:oos_end);
oos_data.yvalue1w = myvectors.yvalue1w(oos_start:oos_end);
oos_data.n1dg     = myvectors.n1dg(oos_start:oos_end)    ;
oos_data.n2dg     = myvectors.n2dg(oos_start:oos_end)    ;
oos_data.n1wg     = myvectors.n1wg(oos_start:oos_end)    ;

% Build a table here so I can see the data I want to pass to mnrval():
x_oos_t = oos_data(:,{...
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
x_oos = table2array(x_oos_t);

% predict !

pihat1d = mnrval(bvals1d, x_oos);
pihat2d = mnrval(bvals2d, x_oos);
pihat1w = mnrval(bvals1w, x_oos);

% The down-probabilities of x_oos are in the 1stcol.
% The up-probabilities   of x_oos are in the 2nd col.
% I am interested in the 2nd col:

ip4yr.prob_1d = pihat1d(:,2);
ip4yr.prob_2d = pihat2d(:,2);
ip4yr.prob_1w = pihat1w(:,2);

% pass along predictions and oos_data:
ip4yr = [ip4yr oos_data];

% I now have predictions for 1 year.
% Return to cr_ip.m
