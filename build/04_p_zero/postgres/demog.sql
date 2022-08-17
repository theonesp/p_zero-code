SELECT
	CASE
		WHEN birth_date BETWEEN 
            make_date(EXTRACT(YEAR FROM birth_date)::int, 3, 21)
            AND
            make_date(EXTRACT(YEAR FROM birth_date)::int, 6, 20)
        THEN 'Spring'
		WHEN birth_date BETWEEN 
            make_date(EXTRACT(YEAR FROM birth_date)::int, 6, 21)
            AND
            make_date(EXTRACT(YEAR FROM birth_date)::int, 9, 22)
        THEN 'Summer'
		WHEN birth_date BETWEEN 
            make_date(EXTRACT(YEAR FROM birth_date)::int, 9, 23)
            AND
            make_date(EXTRACT(YEAR FROM birth_date)::int, 12, 20)
        THEN 'Fall'
		ELSE 'Winter'
	END AS birth_date_season
FROM
	demog