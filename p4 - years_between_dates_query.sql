SELECT DISTINCT i.year                                          year,
       MAKEDATE(i.year, 1)                                      first_day_of_the_year,
       CURDATE()                                                today,
       TIMESTAMPDIFF(YEAR, MAKEDATE(i.year, 1), CURDATE())      years_between_dates
  FROM infectious_cases i
 ORDER BY year DESC;
