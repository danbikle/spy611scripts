% /a/ks/b/matlab/panera21/cr_enh_x_is.m

% Create enhanced training data for 2014 from 9 original features joined with initial-probabilities, and rolling_corr values.

% I want to create enhanced data where 2014-1-1 is the is-oos-boundry:
yr = 2014
is_startDate  = datenum([yr-26 12 21])
is_endDate    = datenum([yr-1 12 21 ])
oos_startDate = datenum([yr 1 1     ])
oos_endDate   = datenum([yr 12 31   ])

% find() index-ranges for both is-data, oos-data:
is_range  = find(ip25yr.ydate >= is_startDate  & ip25yr.ydate <= is_endDate );
oos_range = find(ip25yr.ydate >= oos_startDate & ip25yr.ydate <= oos_endDate);

is_start  = is_range(1)
is_end    = is_range(end)

oos_start = oos_range(1)
oos_end   = oos_range(end)

enh_is_data0          = table();
enh_is_data0.ydate    = ip25yr.ydate(is_start:is_end)   ;
enh_is_data0.ydatestr = datestr(ip25yr.ydate(is_start:is_end),'yyyy-mm-dd')   ;
enh_is_data0.cpma     = ip25yr.cpma(is_start:is_end)    ;
enh_is_data0.n1dg1    = ip25yr.n1dg1(is_start:is_end)   ;
enh_is_data0.n1dg2    = ip25yr.n1dg2(is_start:is_end)   ;
enh_is_data0.n1dg3    = ip25yr.n1dg3(is_start:is_end)   ;
enh_is_data0.n2dlagd  = ip25yr.n2dlagd(is_start:is_end) ;
enh_is_data0.n1wlagd  = ip25yr.n1wlagd(is_start:is_end) ;
enh_is_data0.n2wlagd  = ip25yr.n2wlagd(is_start:is_end) ;
enh_is_data0.n1mlagd  = ip25yr.n1mlagd(is_start:is_end) ;
enh_is_data0.n2mlagd  = ip25yr.n2mlagd(is_start:is_end) ;
enh_is_data0.yvalue1d = ip25yr.yvalue1d(is_start:is_end);
enh_is_data0.yvalue2d = ip25yr.yvalue2d(is_start:is_end);
enh_is_data0.yvalue1w = ip25yr.yvalue1w(is_start:is_end);
% Above data was collected by cr_ip.m 
% 6 features below were calculated from Logistic Regression, observed gains, and rolling corr:
enh_is_data0.iprob_1d = ip25yr.prob_1d(is_start:is_end);
enh_is_data0.iprob_2d = ip25yr.prob_2d(is_start:is_end);
enh_is_data0.iprob_1w = ip25yr.prob_1w(is_start:is_end);
enh_is_data0.corr1d = ip25yr.corr1d(is_start:is_end);
enh_is_data0.corr2d = ip25yr.corr2d(is_start:is_end);
enh_is_data0.corr1w = ip25yr.corr1w(is_start:is_end);
                                                                 
% Add weights to in-sample data

enh_is_data_w5 = table();
enh_is_data_w5.ydate    = ip25yr.ydate(is_end-5*251:is_end)   ;
enh_is_data_w5.ydatestr = datestr(ip25yr.ydate(is_end-5*251:is_end),'yyyy-mm-dd');
enh_is_data_w5.cpma     = ip25yr.cpma(is_end-5*251:is_end)    ;
enh_is_data_w5.n1dg1    = ip25yr.n1dg1(is_end-5*251:is_end)   ;
enh_is_data_w5.n1dg2    = ip25yr.n1dg2(is_end-5*251:is_end)   ;
enh_is_data_w5.n1dg3    = ip25yr.n1dg3(is_end-5*251:is_end)   ;
enh_is_data_w5.n2dlagd  = ip25yr.n2dlagd(is_end-5*251:is_end) ;
enh_is_data_w5.n1wlagd  = ip25yr.n1wlagd(is_end-5*251:is_end) ;
enh_is_data_w5.n2wlagd  = ip25yr.n2wlagd(is_end-5*251:is_end) ;
enh_is_data_w5.n1mlagd  = ip25yr.n1mlagd(is_end-5*251:is_end) ;
enh_is_data_w5.n2mlagd  = ip25yr.n2mlagd(is_end-5*251:is_end) ;
enh_is_data_w5.yvalue1d = ip25yr.yvalue1d(is_end-5*251:is_end);
enh_is_data_w5.yvalue2d = ip25yr.yvalue2d(is_end-5*251:is_end);
enh_is_data_w5.yvalue1w = ip25yr.yvalue1w(is_end-5*251:is_end);
enh_is_data_w5.iprob_1d = ip25yr.prob_1d(is_end-5*251:is_end);
enh_is_data_w5.iprob_2d = ip25yr.prob_2d(is_end-5*251:is_end);
enh_is_data_w5.iprob_1w = ip25yr.prob_1w(is_end-5*251:is_end);
enh_is_data_w5.corr1d = ip25yr.corr1d(is_end-5*251:is_end);
enh_is_data_w5.corr2d = ip25yr.corr2d(is_end-5*251:is_end);
enh_is_data_w5.corr1w = ip25yr.corr1w(is_end-5*251:is_end);

enh_is_data_w10 = table();
enh_is_data_w10.ydate    = ip25yr.ydate(is_end-10*251:is_end)   ;
enh_is_data_w10.ydatestr = datestr(ip25yr.ydate(is_end-10*251:is_end),'yyyy-mm-dd');
enh_is_data_w10.cpma     = ip25yr.cpma(is_end-10*251:is_end)    ;
enh_is_data_w10.n1dg1    = ip25yr.n1dg1(is_end-10*251:is_end)   ;
enh_is_data_w10.n1dg2    = ip25yr.n1dg2(is_end-10*251:is_end)   ;
enh_is_data_w10.n1dg3    = ip25yr.n1dg3(is_end-10*251:is_end)   ;
enh_is_data_w10.n2dlagd  = ip25yr.n2dlagd(is_end-10*251:is_end) ;
enh_is_data_w10.n1wlagd  = ip25yr.n1wlagd(is_end-10*251:is_end) ;
enh_is_data_w10.n2wlagd  = ip25yr.n2wlagd(is_end-10*251:is_end) ;
enh_is_data_w10.n1mlagd  = ip25yr.n1mlagd(is_end-10*251:is_end) ;
enh_is_data_w10.n2mlagd  = ip25yr.n2mlagd(is_end-10*251:is_end) ;
enh_is_data_w10.yvalue1d = ip25yr.yvalue1d(is_end-10*251:is_end);
enh_is_data_w10.yvalue2d = ip25yr.yvalue2d(is_end-10*251:is_end);
enh_is_data_w10.yvalue1w = ip25yr.yvalue1w(is_end-10*251:is_end);
enh_is_data_w10.iprob_1d = ip25yr.prob_1d(is_end-10*251:is_end);
enh_is_data_w10.iprob_2d = ip25yr.prob_2d(is_end-10*251:is_end);
enh_is_data_w10.iprob_1w = ip25yr.prob_1w(is_end-10*251:is_end);
enh_is_data_w10.corr1d = ip25yr.corr1d(is_end-10*251:is_end);
enh_is_data_w10.corr2d = ip25yr.corr2d(is_end-10*251:is_end);
enh_is_data_w10.corr1w = ip25yr.corr1w(is_end-10*251:is_end);

enh_is_data_w15 = table();
enh_is_data_w15.ydate    = ip25yr.ydate(is_end-15*251:is_end)   ;
enh_is_data_w15.ydatestr = datestr(ip25yr.ydate(is_end-15*251:is_end),'yyyy-mm-dd');
enh_is_data_w15.cpma     = ip25yr.cpma(is_end-15*251:is_end)    ;
enh_is_data_w15.n1dg1    = ip25yr.n1dg1(is_end-15*251:is_end)   ;
enh_is_data_w15.n1dg2    = ip25yr.n1dg2(is_end-15*251:is_end)   ;
enh_is_data_w15.n1dg3    = ip25yr.n1dg3(is_end-15*251:is_end)   ;
enh_is_data_w15.n2dlagd  = ip25yr.n2dlagd(is_end-15*251:is_end) ;
enh_is_data_w15.n1wlagd  = ip25yr.n1wlagd(is_end-15*251:is_end) ;
enh_is_data_w15.n2wlagd  = ip25yr.n2wlagd(is_end-15*251:is_end) ;
enh_is_data_w15.n1mlagd  = ip25yr.n1mlagd(is_end-15*251:is_end) ;
enh_is_data_w15.n2mlagd  = ip25yr.n2mlagd(is_end-15*251:is_end) ;
enh_is_data_w15.yvalue1d = ip25yr.yvalue1d(is_end-15*251:is_end);
enh_is_data_w15.yvalue2d = ip25yr.yvalue2d(is_end-15*251:is_end);
enh_is_data_w15.yvalue1w = ip25yr.yvalue1w(is_end-15*251:is_end);
enh_is_data_w15.iprob_1d = ip25yr.prob_1d(is_end-15*251:is_end);
enh_is_data_w15.iprob_2d = ip25yr.prob_2d(is_end-15*251:is_end);
enh_is_data_w15.iprob_1w = ip25yr.prob_1w(is_end-15*251:is_end);
enh_is_data_w15.corr1d = ip25yr.corr1d(is_end-15*251:is_end);
enh_is_data_w15.corr2d = ip25yr.corr2d(is_end-15*251:is_end);
enh_is_data_w15.corr1w = ip25yr.corr1w(is_end-15*251:is_end);

enh_is_data_w20 = table();
enh_is_data_w20.ydate    = ip25yr.ydate(is_end-20*251:is_end)   ;
enh_is_data_w20.ydatestr = datestr(ip25yr.ydate(is_end-20*251:is_end),'yyyy-mm-dd');
enh_is_data_w20.cpma     = ip25yr.cpma(is_end-20*251:is_end)    ;
enh_is_data_w20.n1dg1    = ip25yr.n1dg1(is_end-20*251:is_end)   ;
enh_is_data_w20.n1dg2    = ip25yr.n1dg2(is_end-20*251:is_end)   ;
enh_is_data_w20.n1dg3    = ip25yr.n1dg3(is_end-20*251:is_end)   ;
enh_is_data_w20.n2dlagd  = ip25yr.n2dlagd(is_end-20*251:is_end) ;
enh_is_data_w20.n1wlagd  = ip25yr.n1wlagd(is_end-20*251:is_end) ;
enh_is_data_w20.n2wlagd  = ip25yr.n2wlagd(is_end-20*251:is_end) ;
enh_is_data_w20.n1mlagd  = ip25yr.n1mlagd(is_end-20*251:is_end) ;
enh_is_data_w20.n2mlagd  = ip25yr.n2mlagd(is_end-20*251:is_end) ;
enh_is_data_w20.yvalue1d = ip25yr.yvalue1d(is_end-20*251:is_end);
enh_is_data_w20.yvalue2d = ip25yr.yvalue2d(is_end-20*251:is_end);
enh_is_data_w20.yvalue1w = ip25yr.yvalue1w(is_end-20*251:is_end);
enh_is_data_w20.iprob_1d = ip25yr.prob_1d(is_end-20*251:is_end);
enh_is_data_w20.iprob_2d = ip25yr.prob_2d(is_end-20*251:is_end);
enh_is_data_w20.iprob_1w = ip25yr.prob_1w(is_end-20*251:is_end);
enh_is_data_w20.corr1d = ip25yr.corr1d(is_end-20*251:is_end);
enh_is_data_w20.corr2d = ip25yr.corr2d(is_end-20*251:is_end);
enh_is_data_w20.corr1w = ip25yr.corr1w(is_end-20*251:is_end);
                                                                           
enh_is_data = vertcat(enh_is_data0, ... 
  enh_is_data_w5, ... 
  enh_is_data_w10, ... 
  enh_is_data_w15, ... 
  enh_is_data_w20);

% I like a table here so I can see the data:
x_enh_is_t = enh_is_data(:,{...
'cpma'      ...
,'n1dg1'    ...
,'n1dg2'    ...
,'n1dg3'    ...
,'n2dlagd'  ... 
,'n1wlagd'  ... 
,'n2wlagd'  ... 
,'n1mlagd'  ... 
,'n2mlagd'  ...
,'iprob_1d' ...
,'iprob_2d' ...
,'iprob_1w' ...
,'corr1d'   ...
,'corr2d'   ...
,'corr1w'   ...
});
        
% mnrfit() wants an array not a table:
x_enh_is = table2array(x_enh_is_t);

yvalue1d_is = table2array(enh_is_data(:,{'yvalue1d'}));
yvalue2d_is = table2array(enh_is_data(:,{'yvalue2d'}));
yvalue1w_is = table2array(enh_is_data(:,{'yvalue1w'}));

size_enh_is_data = size(enh_is_data)
size_x_enh_is = size(x_enh_is)

% done
