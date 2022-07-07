-- data_scope.znt_score definition

-- Drop table

-- DROP TABLE data_scope.znt_score;

CREATE TABLE data_scope.znt_score (
	id int4 NULL,
	mandt int4 NULL,
	id_score varchar NULL,
	"date" date NULL,
	hora varchar NULL,
	patnr int4 NULL,
	usuari varchar NULL,
	vpid int4 NULL,
	vwert int4 NULL,
	pop_up varchar NULL,
	envio_medxat_med varchar NULL,
	envio_medxat_enf varchar NULL,
	envio_email varchar NULL,
	valors varchar NULL,
	aillat varchar NULL,
	ou_med_ref int4 NULL,
	care_level_ref int4 NULL
);
