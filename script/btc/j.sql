select
algo
,model
,yr
,count(ydate)
from btc_algo
group by 
algo
,model
,yr
order by 
algo
,model
,yr
;

select
algo
,model
,yr
,count(ydate)
from btc_algo
where prob_willbetrue < 0.5
group by 
algo
,model
,yr
order by 
algo
,model
,yr
;

select
algo
,model
,yr
,count(ydate)
from btc_algo
where prob_willbetrue >= 0.5
group by 
algo
,model
,yr
order by 
algo
,model
,yr
;
