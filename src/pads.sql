(SELECT CONCAT(name, '(', LEFT(occupation, 1), ')') as output
 FROM OCCUPATIONS
 ORDER BY name asc);


(SELECT CONCAT('There are a total of ', COUNT(*), ' ', LOWER(occupation), 's.') AS output
 FROM OCCUPATIONS
 GROUP BY occupation
 ORDER BY COUNT(*), occupation asc);