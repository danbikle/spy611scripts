% /a/ks/b/matlab/rpt_algo.m

% Report effectiveness of my algos: lr and lr2lr

rpt_prob_1d = final_prd.final_prob_1d;
rpt_n1dg    = final_prd.n1dg;

rpt_prob_2d = final_prd.final_prob_2d;
rpt_n2dg    = final_prd.n2dg;

rpt_prob_1w = final_prd.final_prob_1w;
rpt_n1wg    = final_prd.n1wg;

% correlation between lr2lr predictions and resulting gains:
lr2lr_rpt_corr1d = corr(rpt_prob_1d(1:end-1),rpt_n1dg(1:end-1));
lr2lr_rpt_corr2d = corr(rpt_prob_2d(1:end-2),rpt_n2dg(1:end-2));
lr2lr_rpt_corr1w = corr(rpt_prob_1w(1:end-5),rpt_n1wg(1:end-5));

% 1d lr2lr
gt50 = final_prd(final_prd.final_prob_1d > 0.5,:);
lt50 = final_prd(final_prd.final_prob_1d < 0.5,:);

gt50n1dg = gt50.n1dg;
lt50n1dg = lt50.n1dg;

lr2lr_avg_up_1d_pctg  = 100.0 * mean(gt50n1dg(1:end-1))
lr2lr_avg_down_1d_pctg= 100.0 * mean(lt50n1dg(1:end-1))

lr2lr_count_up_1d   = length(gt50n1dg(1:end-1))
lr2lr_count_down_1d = length(lt50n1dg(1:end-1))

% 2d lr2lr
gt50 = final_prd(final_prd.final_prob_2d > 0.5,:);
lt50 = final_prd(final_prd.final_prob_2d < 0.5,:);

gt50n2dg = gt50.n2dg;
lt50n2dg = lt50.n2dg;

lr2lr_avg_up_2d_pctg  = 100.0 * mean(gt50n2dg(1:end-2))
lr2lr_avg_down_2d_pctg= 100.0 * mean(lt50n2dg(1:end-2))

lr2lr_count_up_2d   = length(gt50n2dg(1:end-2))
lr2lr_count_down_2d = length(lt50n2dg(1:end-2))

% 1w lr2lr
gt50 = final_prd(final_prd.final_prob_1w > 0.5,:);
lt50 = final_prd(final_prd.final_prob_1w < 0.5,:);

gt50n1wg = gt50.n1wg;
lt50n1wg = lt50.n1wg;

lr2lr_avg_up_1w_pctg  = 100.0 * mean(gt50n1wg(1:end-5))
lr2lr_avg_down_1w_pctg= 100.0 * mean(lt50n1wg(1:end-5))

lr2lr_count_up_1w   = length(gt50n1wg(1:end-5))
lr2lr_count_down_1w = length(lt50n1wg(1:end-5))

% Above, I report on lr2lr algo.
% Now I look at plain lr algo results:

rpt_prob_1d = final_prd.iprob_1d;
rpt_prob_2d = final_prd.iprob_2d;
rpt_prob_1w = final_prd.iprob_1w;

% correlation between lr predictions and resulting gains:
lr_rpt_corr1d = corr(rpt_prob_1d(1:end-1),rpt_n1dg(1:end-1))
lr_rpt_corr2d = corr(rpt_prob_2d(1:end-2),rpt_n2dg(1:end-2))
lr_rpt_corr1w = corr(rpt_prob_1w(1:end-5),rpt_n1wg(1:end-5))

% 1d lr
gt50 = final_prd(final_prd.iprob_1d > 0.5,:);
lt50 = final_prd(final_prd.iprob_1d < 0.5,:);

gt50n1dg = gt50.n1dg;
lt50n1dg = lt50.n1dg;

lr_avg_up_1d_pctg  = 100.0 * mean(gt50n1dg(1:end-1))
lr_avg_down_1d_pctg= 100.0 * mean(lt50n1dg(1:end-1))

lr_count_up_1d   = length(gt50n1dg(1:end-1))
lr_count_down_1d = length(lt50n1dg(1:end-1))

% 2d lr
gt50 = final_prd(final_prd.iprob_2d > 0.5,:);
lt50 = final_prd(final_prd.iprob_2d < 0.5,:);

gt50n2dg = gt50.n2dg;
lt50n2dg = lt50.n2dg;

lr_avg_up_2d_pctg  = 100.0 * mean(gt50n2dg(1:end-2))
lr_avg_down_2d_pctg= 100.0 * mean(lt50n2dg(1:end-2))

lr_count_up_2d   = length(gt50n2dg(1:end-2))
lr_count_down_2d = length(lt50n2dg(1:end-2))

% 1w lr
gt50 = final_prd(final_prd.iprob_1w > 0.5,:);
lt50 = final_prd(final_prd.iprob_1w < 0.5,:);

gt50n1wg = gt50.n1wg;
lt50n1wg = lt50.n1wg;

lr_avg_up_1w_pctg  = 100.0 * mean(gt50n1wg(1:end-5));
lr_avg_down_1w_pctg= 100.0 * mean(lt50n1wg(1:end-5));

lr_count_up_1w   = length(gt50n1wg(1:end-5));
lr_count_down_1w = length(lt50n1wg(1:end-5));

% Now I put the results in a table:

rpt_algo_corr = table()
rpt_algo_avg = table()
rpt_algo_count = table()

rpt_algo_corr.lr_rpt_corr1d = lr_rpt_corr1d;
rpt_algo_corr.lr_rpt_corr2d = lr_rpt_corr2d;
rpt_algo_corr.lr_rpt_corr1w = lr_rpt_corr1w;
			     
rpt_algo_corr.lr2lr_rpt_corr1d = lr2lr_rpt_corr1d;
rpt_algo_corr.lr2lr_rpt_corr2d = lr2lr_rpt_corr2d;
rpt_algo_corr.lr2lr_rpt_corr1w = lr2lr_rpt_corr1w;

rpt_algo_avg.lr_avg_up_1d_pctg      = lr_avg_up_1d_pctg      ;
rpt_algo_avg.lr_avg_down_1d_pctg    = lr_avg_down_1d_pctg    ;
                                      			  
rpt_algo_avg.lr_avg_up_2d_pctg      = lr_avg_up_2d_pctg      ;
rpt_algo_avg.lr_avg_down_2d_pctg    = lr_avg_down_2d_pctg    ;
                                      			  
rpt_algo_avg.lr_avg_up_1w_pctg      = lr_avg_up_1w_pctg      ;
rpt_algo_avg.lr_avg_down_1w_pctg    = lr_avg_down_1w_pctg    ;
                                      			  
rpt_algo_avg.lr2lr_avg_up_1d_pctg   = lr2lr_avg_up_1d_pctg   ;
rpt_algo_avg.lr2lr_avg_down_1d_pctg = lr2lr_avg_down_1d_pctg ;
                                      			  
rpt_algo_avg.lr2lr_avg_up_2d_pctg   = lr2lr_avg_up_2d_pctg   ;
rpt_algo_avg.lr2lr_avg_down_2d_pctg = lr2lr_avg_down_2d_pctg ;
                                      			  
rpt_algo_avg.lr2lr_avg_up_1w_pctg   = lr2lr_avg_up_1w_pctg   ;
rpt_algo_avg.lr2lr_avg_down_1w_pctg = lr2lr_avg_down_1w_pctg ;

rpt_algo_count.lr_count_up_1d       = lr_count_up_1d         ; 
rpt_algo_count.lr_count_down_1d     = lr_count_down_1d       ;

rpt_algo_count.lr_count_up_2d       = lr_count_up_2d         ; 
rpt_algo_count.lr_count_down_2d     = lr_count_down_2d       ;

rpt_algo_count.lr_count_up_1w       = lr_count_up_1w         ; 
rpt_algo_count.lr_count_down_1w     = lr_count_down_1w       ;

rpt_algo_count.lr2lr_count_up_1d    = lr2lr_count_up_1d      ;
rpt_algo_count.lr2lr_count_down_1d  = lr2lr_count_down_1d    ;

rpt_algo_count.lr2lr_count_up_2d    = lr2lr_count_up_2d      ;
rpt_algo_count.lr2lr_count_down_2d  = lr2lr_count_down_2d    ;

rpt_algo_count.lr2lr_count_up_1w    = lr2lr_count_up_1w      ;
rpt_algo_count.lr2lr_count_down_1w  = lr2lr_count_down_1w    ;

% report now:
rpt_algo_corr
rpt_algo_avg
rpt_algo_count

writetable(rpt_algo_corr,'rpt_algo_corr.csv');
writetable(rpt_algo_avg,'rpt_algo_avg.csv');
writetable(rpt_algo_count,'rpt_algo_count.csv');

rpt_algo_table = final_prd(:,{'ydatestr','iprob_1d','iprob_2d','iprob_1w','final_prob_1d','final_prob_2d','final_prob_1w','n1dg','n2dg','n1wg'});
writetable(rpt_algo_table,'rpt_algo_table.csv');

% done
