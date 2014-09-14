% /a/ks/b/matlab/cr_ip4yr.m

% under construction

% I use this function to calculate initial LR-predictions for a specific year.

% Demo:
%
% ip4yr1989 = cr_ip4yr(1989, myvectors)
% I should see a vector with about 250 elements. Each is between 0.3 and 0.7.

function ip4yr = cr_ip4yr(yr, myvectors)
ip4yr = []
% assume yr is integer like 1989 

startDate = datenum( [ yr 1 1 ] )
endDate   = datenum( [ yr 12 31 ] )

% I want my training data to span from 6500 trading-days ago to 10 days before startDate
% I want my out-of-sample data to span from startDate to endDate

% find() index-range for both startDate and endDate
myrange   = find(myvectors.ydate >= startDate & myvectors.ydate <= endDate);
% Now I can define in-sample and out-of-sample indices:
is_start  = myrange(1) - 6500
is_end    = myrange(1) -   10
oos_start = myrange(1)
oos_end   = myrange(end)

training_data0 = [                  ...
myvectors.cpma(is_start:is_end)    ...
myvectors.n1dg1(is_start:is_end)   ...
myvectors.n1dg2(is_start:is_end)   ...
myvectors.n1dg3(is_start:is_end)   ...
myvectors.n2dlagd(is_start:is_end) ...
myvectors.n1wlagd(is_start:is_end) ...
myvectors.n2wlagd(is_start:is_end) ...
myvectors.n1mlagd(is_start:is_end) ...
myvectors.n2mlagd(is_start:is_end) ...
myvectors.yvalue1d(is_start:is_end) ...
myvectors.yvalue2d(is_start:is_end) ...
myvectors.yvalue1w(is_start:is_end) ...
];

% Add weights to in-sample data

training_data_w5 = [                   ...
myvectors.cpma(is_end-5*251:is_end)    ...
myvectors.n1dg1(is_end-5*251:is_end)   ...
myvectors.n1dg2(is_end-5*251:is_end)   ...
myvectors.n1dg3(is_end-5*251:is_end)   ...
myvectors.n2dlagd(is_end-5*251:is_end) ...
myvectors.n1wlagd(is_end-5*251:is_end) ...
myvectors.n2wlagd(is_end-5*251:is_end) ...
myvectors.n1mlagd(is_end-5*251:is_end) ...
myvectors.n2mlagd(is_end-5*251:is_end) ...
myvectors.yvalue1d(is_end-5*251:is_end) ...
myvectors.yvalue2d(is_end-5*251:is_end) ...
myvectors.yvalue1w(is_end-5*251:is_end) ...
];

training_data_w10 = [                   ...
myvectors.cpma(is_end-10*251:is_end)    ...
myvectors.n1dg1(is_end-10*251:is_end)   ...
myvectors.n1dg2(is_end-10*251:is_end)   ...
myvectors.n1dg3(is_end-10*251:is_end)   ...
myvectors.n2dlagd(is_end-10*251:is_end) ...
myvectors.n1wlagd(is_end-10*251:is_end) ...
myvectors.n2wlagd(is_end-10*251:is_end) ...
myvectors.n1mlagd(is_end-10*251:is_end) ...
myvectors.n2mlagd(is_end-10*251:is_end) ...
myvectors.yvalue1d(is_end-10*251:is_end) ...
myvectors.yvalue2d(is_end-10*251:is_end) ...
myvectors.yvalue1w(is_end-10*251:is_end) ...
];

training_data_w15 = [                   ...
myvectors.cpma(is_end-15*251:is_end)    ...
myvectors.n1dg1(is_end-15*251:is_end)   ...
myvectors.n1dg2(is_end-15*251:is_end)   ...
myvectors.n1dg3(is_end-15*251:is_end)   ...
myvectors.n2dlagd(is_end-15*251:is_end) ...
myvectors.n1wlagd(is_end-15*251:is_end) ...
myvectors.n2wlagd(is_end-15*251:is_end) ...
myvectors.n1mlagd(is_end-15*251:is_end) ...
myvectors.n2mlagd(is_end-15*251:is_end) ...
myvectors.yvalue1d(is_end-15*251:is_end) ...
myvectors.yvalue2d(is_end-15*251:is_end) ...
myvectors.yvalue1w(is_end-15*251:is_end) ...
];

training_data_w20 = [                   ...
myvectors.cpma(is_end-20*251:is_end)    ...
myvectors.n1dg1(is_end-20*251:is_end)   ...
myvectors.n1dg2(is_end-20*251:is_end)   ...
myvectors.n1dg3(is_end-20*251:is_end)   ...
myvectors.n2dlagd(is_end-20*251:is_end) ...
myvectors.n1wlagd(is_end-20*251:is_end) ...
myvectors.n2wlagd(is_end-20*251:is_end) ...
myvectors.n1mlagd(is_end-20*251:is_end) ...
myvectors.n2mlagd(is_end-20*251:is_end) ...
myvectors.yvalue1d(is_end-20*251:is_end) ...
myvectors.yvalue2d(is_end-20*251:is_end) ...
myvectors.yvalue1w(is_end-20*251:is_end) ...
];

training_data = vertcat(training_data0, ... 
  training_data_w5, ... 
  training_data_w10, ... 
  training_data_w15, ... 
  training_data_w20);

xtraining         = training_data(:,1:9);
yvalue1d_training = training_data(:,10);
yvalue2d_training = training_data(:,11);
yvalue1w_training = training_data(:,12);

% train!

bvals1d = mnrfit(xtraining, yvalue1d_training)
bvals2d = mnrfit(xtraining, yvalue2d_training)
bvals1w = mnrfit(xtraining, yvalue1w_training)

oos_data = [                          ...
myvectors.cpma(oos_start:oos_end)     ...
myvectors.n1dg1(oos_start:oos_end)    ...
myvectors.n1dg2(oos_start:oos_end)    ...
myvectors.n1dg3(oos_start:oos_end)    ...
myvectors.n2dlagd(oos_start:oos_end)  ...
myvectors.n1wlagd(oos_start:oos_end)  ...
myvectors.n2wlagd(oos_start:oos_end)  ...
myvectors.n1mlagd(oos_start:oos_end)  ...
myvectors.n2mlagd(oos_start:oos_end)  ...
myvectors.yvalue1d(oos_start:oos_end) ...
myvectors.yvalue2d(oos_start:oos_end) ...
myvectors.yvalue1w(oos_start:oos_end) ...
myvectors.n1dg(oos_start:oos_end)     ...
myvectors.n2dg(oos_start:oos_end)     ...
myvectors.n1wg(oos_start:oos_end)     ...
myvectors.ydate(oos_start:oos_end)    ...
];

% predict !

x_oos = oos_data(:,1:9);
pihat1d = mnrval(bvals1d, x_oos);
pihat2d = mnrval(bvals2d, x_oos);
pihat1w = mnrval(bvals1w, x_oos);

% The down-probabilities of x_oos are in the 1stcol.
% The up-probabilities   of x_oos are in the 2nd col.
% I am interested in the 2nd col:

prob_1d = pihat1d(:,2);
prob_2d = pihat2d(:,2);
prob_1w = pihat1w(:,2);

% I need to keep track of the dates of these predictions:

% pass along predictions and oos_data:

ip4yr = [prob_1d prob_2d prob_1w oos_data];

