--
-- ~/spy611/script/cr_saved_predictions.sql
--

DROP TABLE   saved_predictions;
CREATE TABLE saved_predictions
(
prediction_time TIMESTAMP
,ydate          DATE
,probup         DECIMAL
,pctgain        DECIMAL
,algo           VARCHAR(7)
,model          VARCHAR(5)
)
;
