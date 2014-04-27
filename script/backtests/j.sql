
DROP   TABLE is_vectors;

CREATE TABLE is_vectors AS
SELECT * FROM my_vectors_wide
WHERE ydate    > ('2010'||'-01-01')::DATE
-- AND   20+ydate < ('2011'||'-01-01')::DATE
ORDER BY ydate
;

-- rpt
select decade,min(ydate),count(ydate),max(ydate) from my_vectors_ip group by decade order by decade ;
select min(ydate),count(ydate),max(ydate) from my_vectors_wide;
select min(ydate),count(ydate),max(ydate) from is_vectors;
