
SELECT c.country_id,
	   c.entity,
       c.code,
	   count(*),
       AVG(i.number_rabies) avg_number_rabies,
       MIN(i.number_rabies) min_number_rabies,
       MAX(i.number_rabies) max_number_rabies,
       SUM(i.number_rabies) sum_number_rabies
  FROM infectious_cases i,
	   countries c
 WHERE i.country_id = c.country_id
   AND i.number_rabies is not null
 GROUP BY c.country_id,
	      c.entity,
          c.code
 ORDER BY avg_number_rabies DESC
 LIMIT 10;


