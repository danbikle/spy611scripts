% /a/ks/b/matlab/predict_oos.m

% Predict oos 2014 observations

% train!

enh_bvals1d = mnrfit(x_enh_is, yvalue1d_is)
enh_bvals2d = mnrfit(x_enh_is, yvalue2d_is)
enh_bvals1w = mnrfit(x_enh_is, yvalue1w_is)

% trained.

% predict!

enh_pihat1d = mnrval(enh_bvals1d, x_enh_oos);
enh_pihat2d = mnrval(enh_bvals2d, x_enh_oos);
enh_pihat1w = mnrval(enh_bvals1w, x_enh_oos);

% collect predictions:

final_prd = table();
final_prd.final_prob_1d = enh_pihat1d(:,2);
final_prd.final_prob_2d = enh_pihat2d(:,2);
final_prd.final_prob_1w = enh_pihat1w(:,2);

final_prd = [final_prd enh_oos_data];

size_final_prd = size(final_prd)

% done
