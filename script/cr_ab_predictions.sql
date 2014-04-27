--
-- ~/spy611/script/cr_ab_predictions.sql
--

DROP    TABLE ab_predictions_n1dg;
DROP    TABLE ab_predictions_n2dg;
DROP    TABLE ab_predictions_n1wg;

CREATE TABLE ab_predictions_n1dg (pnum INTEGER, prob_willbetrue INTEGER);
CREATE TABLE ab_predictions_n2dg (pnum INTEGER, prob_willbetrue INTEGER);
CREATE TABLE ab_predictions_n1wg (pnum INTEGER, prob_willbetrue INTEGER);
