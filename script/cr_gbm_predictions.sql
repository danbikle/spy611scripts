--
-- ~/spy611/script/cr_gbm_predictions.sql
--

DROP    TABLE gbm_predictions_n1dg;
DROP    TABLE gbm_predictions_n2dg;
DROP    TABLE gbm_predictions_n1wg;

CREATE TABLE gbm_predictions_n1dg (pnum INTEGER, prob_willbetrue INTEGER);
CREATE TABLE gbm_predictions_n2dg (pnum INTEGER, prob_willbetrue INTEGER);
CREATE TABLE gbm_predictions_n1wg (pnum INTEGER, prob_willbetrue INTEGER);
