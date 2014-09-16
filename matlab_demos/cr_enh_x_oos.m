% /a/ks/b/matlab/cr_enh_x_oos.m

% Create enhanced out-of-sample data for 2014 from 9 original features, initial probabilities, and rolling_corr values

enh_oos_data          = table();
enh_oos_data.ydate    = ip25yr.ydate(oos_start:oos_end)   ;
enh_oos_data.ydatestr = datestr(ip25yr.ydate(oos_start:oos_end),'yyyy-mm-dd') ;
enh_oos_data.cpma     = ip25yr.cpma(oos_start:oos_end)    ;
enh_oos_data.n1dg1    = ip25yr.n1dg1(oos_start:oos_end)   ;
enh_oos_data.n1dg2    = ip25yr.n1dg2(oos_start:oos_end)   ;
enh_oos_data.n1dg3    = ip25yr.n1dg3(oos_start:oos_end)   ;
enh_oos_data.n2dlagd  = ip25yr.n2dlagd(oos_start:oos_end) ;
enh_oos_data.n1wlagd  = ip25yr.n1wlagd(oos_start:oos_end) ;
enh_oos_data.n2wlagd  = ip25yr.n2wlagd(oos_start:oos_end) ;
enh_oos_data.n1mlagd  = ip25yr.n1mlagd(oos_start:oos_end) ;
enh_oos_data.n2mlagd  = ip25yr.n2mlagd(oos_start:oos_end) ;
enh_oos_data.yvalue1d = ip25yr.yvalue1d(oos_start:oos_end);
enh_oos_data.yvalue2d = ip25yr.yvalue2d(oos_start:oos_end);
enh_oos_data.yvalue1w = ip25yr.yvalue1w(oos_start:oos_end);
% Above data was collected by cr_ip.m 
% 6 features below were calculated from Logistic Regression, observed gains, and rolling corr:
enh_oos_data.iprob_1d = ip25yr.prob_1d(oos_start:oos_end);
enh_oos_data.iprob_2d = ip25yr.prob_2d(oos_start:oos_end);
enh_oos_data.iprob_1w = ip25yr.prob_1w(oos_start:oos_end);
enh_oos_data.corr1d = ip25yr.corr1d(oos_start:oos_end);
enh_oos_data.corr2d = ip25yr.corr2d(oos_start:oos_end);
enh_oos_data.corr1w = ip25yr.corr1w(oos_start:oos_end);
% Attach gains so I can later gauge effectiveness:
enh_oos_data.n1dg    = ip25yr.n1dg(oos_start:oos_end) ;
enh_oos_data.n2dg    = ip25yr.n2dg(oos_start:oos_end) ;
enh_oos_data.n1wg    = ip25yr.n1wg(oos_start:oos_end) ;

% Build a table here so I can see the data I want to pass to mnrval():
x_enh_oos_t = enh_oos_data(:,{...
'cpma'     ...
,'n1dg1'   ...
,'n1dg2'   ...
,'n1dg3'   ...
,'n2dlagd' ... 
,'n1wlagd' ... 
,'n2wlagd' ... 
,'n1mlagd' ... 
,'n2mlagd' ...
,'iprob_1d' ...
,'iprob_2d' ...
,'iprob_1w' ...
,'corr1d'   ...
,'corr2d'   ...
,'corr1w'   ...
});

% mnrfit() wants an array not a table:
x_enh_oos = table2array(x_enh_oos_t);

size_enh_oos_data = size(enh_oos_data)
size_x_enh_oos = size(x_enh_oos)

% done
