-- copy data from csv files to previously generated tables

SET SEARCH_PATH TO data_scope;

--copying demog
\copy data_scope.demog (patient_ref, birth_date, sex, nation_ref,load_date) FROM '/stage_files/demo_2022-07-28.txt' DELIMITER ';' CSV HEADER;


