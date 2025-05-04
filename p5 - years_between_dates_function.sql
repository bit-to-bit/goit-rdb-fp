DROP FUNCTION IF EXISTS GetNumberOfYearsPassed;

DELIMITER //

CREATE FUNCTION GetNumberOfYearsPassed(case_year YEAR(4))
RETURNS INT
NO SQL
BEGIN
    DECLARE result INT;
    SET result = TIMESTAMPDIFF(YEAR, MAKEDATE(case_year, 1), CURDATE());
    RETURN result;
END //

DELIMITER ;

SELECT DISTINCT i.year                                          year,
       MAKEDATE(i.year, 1)                                      first_day_of_the_year,
       CURDATE()                                                today,
       TIMESTAMPDIFF(YEAR, MAKEDATE(i.year, 1), CURDATE())      years_between_dates,
       GetNumberOfYearsPassed(i.year)                           years_between_dates_function
  FROM infectious_cases i
 ORDER BY year DESC;