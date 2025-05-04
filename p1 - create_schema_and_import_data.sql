CREATE DATABASE pandemic;
USE pandemic;

RENAME TABLE infectious_cases TO infectious_cases_source;

CREATE TABLE countries (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    entity VARCHAR(32) NOT NULL,
    code   VARCHAR(8) NOT NULL
);

CREATE TABLE infectious_cases (
  case_id  INT AUTO_INCREMENT PRIMARY KEY,
  country_id INT NOT NULL,
  year YEAR NOT NULL,
  number_yaws INT,
  polio_cases INT,
  cases_guinea_worm INT,
  number_rabies DECIMAL(20,10),
  number_malaria DECIMAL(20,10),
  number_hiv DECIMAL(20,10),
  number_tuberculosis DECIMAL(20,10),
  number_smallpox DECIMAL(20,10),
  number_cholera_cases DECIMAL(20,10),
  FOREIGN KEY (country_id) REFERENCES countries(country_id)
);

INSERT INTO countries (entity, code) 
SELECT distinct s.entity, s.code
  FROM infectious_cases_source s;

INSERT INTO infectious_cases(country_id, year, number_yaws, polio_cases, cases_guinea_worm, number_rabies, number_malaria, number_hiv, number_tuberculosis, number_smallpox, number_cholera_cases) 
SELECT (SELECT c.country_id FROM countries c WHERE c.entity = s.entity AND c.code = s.code),
       CONVERT(s.year, SIGNED),
       CONVERT(NULLIF(s.number_yaws,''), UNSIGNED),
       CONVERT(NULLIF(s.polio_cases,''), SIGNED),
       CONVERT(NULLIF(s.cases_guinea_worm,''), SIGNED),
       CONVERT(NULLIF(s.number_rabies,''), DECIMAL(20,10)),
       CONVERT(NULLIF(s.number_malaria,''), DECIMAL(20,10)),
       CONVERT(NULLIF(s.number_hiv,''), DECIMAL(20,10)),
       CONVERT(NULLIF(s.number_tuberculosis,''), DECIMAL(20,10)),
       CONVERT(NULLIF(s.number_smallpox,''), DECIMAL(20,10)),
       CONVERT(NULLIF(s.number_cholera_cases,''), DECIMAL(20,10))
  FROM infectious_cases_source s;



