-- copy data from csv files to previously generated tables

SET SEARCH_PATH TO data_scope;

--copying natio_dic.csv
\copy data_scope.nation_dic (natio_ref, "label", tt) FROM '/stage_files/natio_dic.csv' DELIMITER ';' CSV HEADER;

--copying demog
\copy data_scope.demog (patient_ref, birth_date, sex, nation_ref,load_date) FROM '/stage_files/demo_2022-07-28.txt' DELIMITER ';' CSV HEADER;

--copying znt_score
\copy data_scope.znt_score (patient_id, id, mandt, id_score, "date", hora, usuari, vpid, vwert, pop_up, envio_medxat_med, envio_medxat_enf, envio_email, valors, aillat, ou_med_ref, care_level_ref) FROM '/stage_files/znt_score_2022-07-28.txt' DELIMITER ';' CSV HEADER;

--copying diag_events
\copy data_scope.diag_events  FROM '/home/xborrat/diag.csv' DELIMITER ',' CSV HEADER;


--copying diag_dic
\copy data_scope.diag_dic   FROM '/home/xborrat/diag_dic.csv' DELIMITER ',' CSV HEADER;

--copying death_events
\copy data_scope.death_events   FROM '/home/xborrat/death_events.csv' DELIMITER ',' CSV HEADER;
